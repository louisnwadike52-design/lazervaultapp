// This is a generated file - do not edit.
//
// Generated from statistics.proto.

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
import 'statistics.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'statistics.pbenum.dart';

/// Expense Messages
class ExpenseMessage extends $pb.GeneratedMessage {
  factory ExpenseMessage({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    $core.String? subcategory,
    $core.String? description,
    $core.String? merchant,
    $1.Timestamp? transactionDate,
    $core.String? paymentMethod,
    $core.String? receiptUrl,
    $core.Iterable<$core.String>? tags,
    $core.String? notes,
    $core.bool? isRecurring,
    $core.String? recurrencePattern,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (subcategory != null) result.subcategory = subcategory;
    if (description != null) result.description = description;
    if (merchant != null) result.merchant = merchant;
    if (transactionDate != null) result.transactionDate = transactionDate;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (receiptUrl != null) result.receiptUrl = receiptUrl;
    if (tags != null) result.tags.addAll(tags);
    if (notes != null) result.notes = notes;
    if (isRecurring != null) result.isRecurring = isRecurring;
    if (recurrencePattern != null) result.recurrencePattern = recurrencePattern;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  ExpenseMessage._();

  factory ExpenseMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExpenseMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExpenseMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..e<ExpenseCategory>(
        6, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..aOS(7, _omitFieldNames ? '' : 'subcategory')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'merchant')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'transactionDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(11, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(12, _omitFieldNames ? '' : 'receiptUrl')
    ..pPS(13, _omitFieldNames ? '' : 'tags')
    ..aOS(14, _omitFieldNames ? '' : 'notes')
    ..aOB(15, _omitFieldNames ? '' : 'isRecurring')
    ..aOS(16, _omitFieldNames ? '' : 'recurrencePattern')
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExpenseMessage clone() => ExpenseMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExpenseMessage copyWith(void Function(ExpenseMessage) updates) =>
      super.copyWith((message) => updates(message as ExpenseMessage))
          as ExpenseMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExpenseMessage create() => ExpenseMessage._();
  @$core.override
  ExpenseMessage createEmptyInstance() => create();
  static $pb.PbList<ExpenseMessage> createRepeated() =>
      $pb.PbList<ExpenseMessage>();
  @$core.pragma('dart2js:noInline')
  static ExpenseMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExpenseMessage>(create);
  static ExpenseMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

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
  ExpenseCategory get category => $_getN(5);
  @$pb.TagNumber(6)
  set category(ExpenseCategory value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get subcategory => $_getSZ(6);
  @$pb.TagNumber(7)
  set subcategory($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSubcategory() => $_has(6);
  @$pb.TagNumber(7)
  void clearSubcategory() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get merchant => $_getSZ(8);
  @$pb.TagNumber(9)
  set merchant($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMerchant() => $_has(8);
  @$pb.TagNumber(9)
  void clearMerchant() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get transactionDate => $_getN(9);
  @$pb.TagNumber(10)
  set transactionDate($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasTransactionDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionDate() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureTransactionDate() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get paymentMethod => $_getSZ(10);
  @$pb.TagNumber(11)
  set paymentMethod($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPaymentMethod() => $_has(10);
  @$pb.TagNumber(11)
  void clearPaymentMethod() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get receiptUrl => $_getSZ(11);
  @$pb.TagNumber(12)
  set receiptUrl($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasReceiptUrl() => $_has(11);
  @$pb.TagNumber(12)
  void clearReceiptUrl() => $_clearField(12);

  @$pb.TagNumber(13)
  $pb.PbList<$core.String> get tags => $_getList(12);

  @$pb.TagNumber(14)
  $core.String get notes => $_getSZ(13);
  @$pb.TagNumber(14)
  set notes($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasNotes() => $_has(13);
  @$pb.TagNumber(14)
  void clearNotes() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.bool get isRecurring => $_getBF(14);
  @$pb.TagNumber(15)
  set isRecurring($core.bool value) => $_setBool(14, value);
  @$pb.TagNumber(15)
  $core.bool hasIsRecurring() => $_has(14);
  @$pb.TagNumber(15)
  void clearIsRecurring() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get recurrencePattern => $_getSZ(15);
  @$pb.TagNumber(16)
  set recurrencePattern($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasRecurrencePattern() => $_has(15);
  @$pb.TagNumber(16)
  void clearRecurrencePattern() => $_clearField(16);

  @$pb.TagNumber(17)
  $1.Timestamp get createdAt => $_getN(16);
  @$pb.TagNumber(17)
  set createdAt($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureCreatedAt() => $_ensure(16);

  @$pb.TagNumber(18)
  $1.Timestamp get updatedAt => $_getN(17);
  @$pb.TagNumber(18)
  set updatedAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearUpdatedAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureUpdatedAt() => $_ensure(17);
}

/// Budget Messages
class BudgetMessage extends $pb.GeneratedMessage {
  factory BudgetMessage({
    $core.String? id,
    $core.String? userId,
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    BudgetPeriod? period,
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
    $core.double? spentAmount,
    $core.double? remainingAmount,
    $core.double? percentageUsed,
    BudgetStatus? status,
    $core.bool? enableAlerts,
    $core.double? alertThreshold,
    BudgetEnforcementMode? enforcementMode,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (period != null) result.period = period;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (spentAmount != null) result.spentAmount = spentAmount;
    if (remainingAmount != null) result.remainingAmount = remainingAmount;
    if (percentageUsed != null) result.percentageUsed = percentageUsed;
    if (status != null) result.status = status;
    if (enableAlerts != null) result.enableAlerts = enableAlerts;
    if (alertThreshold != null) result.alertThreshold = alertThreshold;
    if (enforcementMode != null) result.enforcementMode = enforcementMode;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  BudgetMessage._();

  factory BudgetMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BudgetMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BudgetMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..e<ExpenseCategory>(
        6, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..e<BudgetPeriod>(7, _omitFieldNames ? '' : 'period', $pb.PbFieldType.OE,
        defaultOrMaker: BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED,
        valueOf: BudgetPeriod.valueOf,
        enumValues: BudgetPeriod.values)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'spentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'remainingAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        12, _omitFieldNames ? '' : 'percentageUsed', $pb.PbFieldType.OD)
    ..e<BudgetStatus>(13, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: BudgetStatus.BUDGET_STATUS_UNSPECIFIED,
        valueOf: BudgetStatus.valueOf,
        enumValues: BudgetStatus.values)
    ..aOB(14, _omitFieldNames ? '' : 'enableAlerts')
    ..a<$core.double>(
        15, _omitFieldNames ? '' : 'alertThreshold', $pb.PbFieldType.OD)
    ..e<BudgetEnforcementMode>(
        16, _omitFieldNames ? '' : 'enforcementMode', $pb.PbFieldType.OE,
        defaultOrMaker:
            BudgetEnforcementMode.BUDGET_ENFORCEMENT_MODE_UNSPECIFIED,
        valueOf: BudgetEnforcementMode.valueOf,
        enumValues: BudgetEnforcementMode.values)
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BudgetMessage clone() => BudgetMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BudgetMessage copyWith(void Function(BudgetMessage) updates) =>
      super.copyWith((message) => updates(message as BudgetMessage))
          as BudgetMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BudgetMessage create() => BudgetMessage._();
  @$core.override
  BudgetMessage createEmptyInstance() => create();
  static $pb.PbList<BudgetMessage> createRepeated() =>
      $pb.PbList<BudgetMessage>();
  @$core.pragma('dart2js:noInline')
  static BudgetMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BudgetMessage>(create);
  static BudgetMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

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
  ExpenseCategory get category => $_getN(5);
  @$pb.TagNumber(6)
  set category(ExpenseCategory value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => $_clearField(6);

  @$pb.TagNumber(7)
  BudgetPeriod get period => $_getN(6);
  @$pb.TagNumber(7)
  set period(BudgetPeriod value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasPeriod() => $_has(6);
  @$pb.TagNumber(7)
  void clearPeriod() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get startDate => $_getN(7);
  @$pb.TagNumber(8)
  set startDate($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStartDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearStartDate() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureStartDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get endDate => $_getN(8);
  @$pb.TagNumber(9)
  set endDate($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasEndDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearEndDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureEndDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.double get spentAmount => $_getN(9);
  @$pb.TagNumber(10)
  set spentAmount($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSpentAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearSpentAmount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get remainingAmount => $_getN(10);
  @$pb.TagNumber(11)
  set remainingAmount($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasRemainingAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearRemainingAmount() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get percentageUsed => $_getN(11);
  @$pb.TagNumber(12)
  set percentageUsed($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasPercentageUsed() => $_has(11);
  @$pb.TagNumber(12)
  void clearPercentageUsed() => $_clearField(12);

  @$pb.TagNumber(13)
  BudgetStatus get status => $_getN(12);
  @$pb.TagNumber(13)
  set status(BudgetStatus value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasStatus() => $_has(12);
  @$pb.TagNumber(13)
  void clearStatus() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get enableAlerts => $_getBF(13);
  @$pb.TagNumber(14)
  set enableAlerts($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasEnableAlerts() => $_has(13);
  @$pb.TagNumber(14)
  void clearEnableAlerts() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.double get alertThreshold => $_getN(14);
  @$pb.TagNumber(15)
  set alertThreshold($core.double value) => $_setDouble(14, value);
  @$pb.TagNumber(15)
  $core.bool hasAlertThreshold() => $_has(14);
  @$pb.TagNumber(15)
  void clearAlertThreshold() => $_clearField(15);

  @$pb.TagNumber(16)
  BudgetEnforcementMode get enforcementMode => $_getN(15);
  @$pb.TagNumber(16)
  set enforcementMode(BudgetEnforcementMode value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasEnforcementMode() => $_has(15);
  @$pb.TagNumber(16)
  void clearEnforcementMode() => $_clearField(16);

  @$pb.TagNumber(17)
  $1.Timestamp get createdAt => $_getN(16);
  @$pb.TagNumber(17)
  set createdAt($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureCreatedAt() => $_ensure(16);

  @$pb.TagNumber(18)
  $1.Timestamp get updatedAt => $_getN(17);
  @$pb.TagNumber(18)
  set updatedAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearUpdatedAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureUpdatedAt() => $_ensure(17);
}

/// Alert Messages
class BudgetAlertMessage extends $pb.GeneratedMessage {
  factory BudgetAlertMessage({
    $core.String? id,
    $core.String? userId,
    $core.String? budgetId,
    $core.String? budgetName,
    AlertType? alertType,
    $core.String? message,
    $core.double? currentSpent,
    $core.double? budgetLimit,
    $core.double? percentageUsed,
    $core.bool? isRead,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (budgetId != null) result.budgetId = budgetId;
    if (budgetName != null) result.budgetName = budgetName;
    if (alertType != null) result.alertType = alertType;
    if (message != null) result.message = message;
    if (currentSpent != null) result.currentSpent = currentSpent;
    if (budgetLimit != null) result.budgetLimit = budgetLimit;
    if (percentageUsed != null) result.percentageUsed = percentageUsed;
    if (isRead != null) result.isRead = isRead;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  BudgetAlertMessage._();

  factory BudgetAlertMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BudgetAlertMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BudgetAlertMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'budgetId')
    ..aOS(4, _omitFieldNames ? '' : 'budgetName')
    ..e<AlertType>(5, _omitFieldNames ? '' : 'alertType', $pb.PbFieldType.OE,
        defaultOrMaker: AlertType.ALERT_TYPE_UNSPECIFIED,
        valueOf: AlertType.valueOf,
        enumValues: AlertType.values)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'currentSpent', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'budgetLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'percentageUsed', $pb.PbFieldType.OD)
    ..aOB(10, _omitFieldNames ? '' : 'isRead')
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BudgetAlertMessage clone() => BudgetAlertMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BudgetAlertMessage copyWith(void Function(BudgetAlertMessage) updates) =>
      super.copyWith((message) => updates(message as BudgetAlertMessage))
          as BudgetAlertMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BudgetAlertMessage create() => BudgetAlertMessage._();
  @$core.override
  BudgetAlertMessage createEmptyInstance() => create();
  static $pb.PbList<BudgetAlertMessage> createRepeated() =>
      $pb.PbList<BudgetAlertMessage>();
  @$core.pragma('dart2js:noInline')
  static BudgetAlertMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BudgetAlertMessage>(create);
  static BudgetAlertMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get budgetId => $_getSZ(2);
  @$pb.TagNumber(3)
  set budgetId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBudgetId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBudgetId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get budgetName => $_getSZ(3);
  @$pb.TagNumber(4)
  set budgetName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBudgetName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBudgetName() => $_clearField(4);

  @$pb.TagNumber(5)
  AlertType get alertType => $_getN(4);
  @$pb.TagNumber(5)
  set alertType(AlertType value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasAlertType() => $_has(4);
  @$pb.TagNumber(5)
  void clearAlertType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get currentSpent => $_getN(6);
  @$pb.TagNumber(7)
  set currentSpent($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrentSpent() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrentSpent() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get budgetLimit => $_getN(7);
  @$pb.TagNumber(8)
  set budgetLimit($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBudgetLimit() => $_has(7);
  @$pb.TagNumber(8)
  void clearBudgetLimit() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get percentageUsed => $_getN(8);
  @$pb.TagNumber(9)
  set percentageUsed($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPercentageUsed() => $_has(8);
  @$pb.TagNumber(9)
  void clearPercentageUsed() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isRead => $_getBF(9);
  @$pb.TagNumber(10)
  set isRead($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsRead() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsRead() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCreatedAt() => $_ensure(10);
}

/// Analytics Messages
class SpendingAnalytics extends $pb.GeneratedMessage {
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
    final result = create();
    if (period != null) result.period = period;
    if (totalSpent != null) result.totalSpent = totalSpent;
    if (totalBudget != null) result.totalBudget = totalBudget;
    if (remainingBudget != null) result.remainingBudget = remainingBudget;
    if (transactionCount != null) result.transactionCount = transactionCount;
    if (averageTransaction != null)
      result.averageTransaction = averageTransaction;
    if (categoryBreakdown != null)
      result.categoryBreakdown.addAll(categoryBreakdown);
    if (dailyTrend != null) result.dailyTrend.addAll(dailyTrend);
    if (topCategory != null) result.topCategory = topCategory;
    if (topCategoryAmount != null) result.topCategoryAmount = topCategoryAmount;
    if (savingsRate != null) result.savingsRate = savingsRate;
    return result;
  }

  SpendingAnalytics._();

  factory SpendingAnalytics.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SpendingAnalytics.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SpendingAnalytics',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'period')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalSpent', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalBudget', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'remainingBudget', $pb.PbFieldType.OD)
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'averageTransaction', $pb.PbFieldType.OD)
    ..pc<CategorySpending>(
        7, _omitFieldNames ? '' : 'categoryBreakdown', $pb.PbFieldType.PM,
        subBuilder: CategorySpending.create)
    ..pc<DailySpending>(
        8, _omitFieldNames ? '' : 'dailyTrend', $pb.PbFieldType.PM,
        subBuilder: DailySpending.create)
    ..aOS(9, _omitFieldNames ? '' : 'topCategory')
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'topCategoryAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'savingsRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SpendingAnalytics clone() => SpendingAnalytics()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SpendingAnalytics copyWith(void Function(SpendingAnalytics) updates) =>
      super.copyWith((message) => updates(message as SpendingAnalytics))
          as SpendingAnalytics;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SpendingAnalytics create() => SpendingAnalytics._();
  @$core.override
  SpendingAnalytics createEmptyInstance() => create();
  static $pb.PbList<SpendingAnalytics> createRepeated() =>
      $pb.PbList<SpendingAnalytics>();
  @$core.pragma('dart2js:noInline')
  static SpendingAnalytics getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SpendingAnalytics>(create);
  static SpendingAnalytics? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get period => $_getSZ(0);
  @$pb.TagNumber(1)
  set period($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalSpent => $_getN(1);
  @$pb.TagNumber(2)
  set totalSpent($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalSpent() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalSpent() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalBudget => $_getN(2);
  @$pb.TagNumber(3)
  set totalBudget($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalBudget() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalBudget() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get remainingBudget => $_getN(3);
  @$pb.TagNumber(4)
  set remainingBudget($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRemainingBudget() => $_has(3);
  @$pb.TagNumber(4)
  void clearRemainingBudget() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get transactionCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set transactionCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransactionCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get averageTransaction => $_getN(5);
  @$pb.TagNumber(6)
  set averageTransaction($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAverageTransaction() => $_has(5);
  @$pb.TagNumber(6)
  void clearAverageTransaction() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<CategorySpending> get categoryBreakdown => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<DailySpending> get dailyTrend => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get topCategory => $_getSZ(8);
  @$pb.TagNumber(9)
  set topCategory($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTopCategory() => $_has(8);
  @$pb.TagNumber(9)
  void clearTopCategory() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get topCategoryAmount => $_getN(9);
  @$pb.TagNumber(10)
  set topCategoryAmount($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTopCategoryAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearTopCategoryAmount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get savingsRate => $_getN(10);
  @$pb.TagNumber(11)
  set savingsRate($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSavingsRate() => $_has(10);
  @$pb.TagNumber(11)
  void clearSavingsRate() => $_clearField(11);
}

class CategorySpending extends $pb.GeneratedMessage {
  factory CategorySpending({
    ExpenseCategory? category,
    $core.String? categoryName,
    $core.double? amount,
    $core.double? percentage,
    $core.int? transactionCount,
    $core.double? budgetAllocated,
    $core.double? budgetRemaining,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (categoryName != null) result.categoryName = categoryName;
    if (amount != null) result.amount = amount;
    if (percentage != null) result.percentage = percentage;
    if (transactionCount != null) result.transactionCount = transactionCount;
    if (budgetAllocated != null) result.budgetAllocated = budgetAllocated;
    if (budgetRemaining != null) result.budgetRemaining = budgetRemaining;
    return result;
  }

  CategorySpending._();

  factory CategorySpending.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CategorySpending.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CategorySpending',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<ExpenseCategory>(
        1, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..aOS(2, _omitFieldNames ? '' : 'categoryName')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.OD)
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'budgetAllocated', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'budgetRemaining', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategorySpending clone() => CategorySpending()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategorySpending copyWith(void Function(CategorySpending) updates) =>
      super.copyWith((message) => updates(message as CategorySpending))
          as CategorySpending;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CategorySpending create() => CategorySpending._();
  @$core.override
  CategorySpending createEmptyInstance() => create();
  static $pb.PbList<CategorySpending> createRepeated() =>
      $pb.PbList<CategorySpending>();
  @$core.pragma('dart2js:noInline')
  static CategorySpending getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CategorySpending>(create);
  static CategorySpending? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(ExpenseCategory value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get categoryName => $_getSZ(1);
  @$pb.TagNumber(2)
  set categoryName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategoryName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategoryName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get percentage => $_getN(3);
  @$pb.TagNumber(4)
  set percentage($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPercentage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get transactionCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set transactionCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransactionCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get budgetAllocated => $_getN(5);
  @$pb.TagNumber(6)
  set budgetAllocated($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBudgetAllocated() => $_has(5);
  @$pb.TagNumber(6)
  void clearBudgetAllocated() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get budgetRemaining => $_getN(6);
  @$pb.TagNumber(7)
  set budgetRemaining($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBudgetRemaining() => $_has(6);
  @$pb.TagNumber(7)
  void clearBudgetRemaining() => $_clearField(7);
}

class DailySpending extends $pb.GeneratedMessage {
  factory DailySpending({
    $1.Timestamp? date,
    $core.double? amount,
    $core.int? transactionCount,
  }) {
    final result = create();
    if (date != null) result.date = date;
    if (amount != null) result.amount = amount;
    if (transactionCount != null) result.transactionCount = transactionCount;
    return result;
  }

  DailySpending._();

  factory DailySpending.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DailySpending.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DailySpending',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'date',
        subBuilder: $1.Timestamp.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailySpending clone() => DailySpending()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailySpending copyWith(void Function(DailySpending) updates) =>
      super.copyWith((message) => updates(message as DailySpending))
          as DailySpending;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DailySpending create() => DailySpending._();
  @$core.override
  DailySpending createEmptyInstance() => create();
  static $pb.PbList<DailySpending> createRepeated() =>
      $pb.PbList<DailySpending>();
  @$core.pragma('dart2js:noInline')
  static DailySpending getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DailySpending>(create);
  static DailySpending? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get date => $_getN(0);
  @$pb.TagNumber(1)
  set date($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get transactionCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set transactionCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionCount() => $_clearField(3);
}

class BudgetProgressItem extends $pb.GeneratedMessage {
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
    final result = create();
    if (budgetId != null) result.budgetId = budgetId;
    if (budgetName != null) result.budgetName = budgetName;
    if (category != null) result.category = category;
    if (budgetAmount != null) result.budgetAmount = budgetAmount;
    if (spentAmount != null) result.spentAmount = spentAmount;
    if (remainingAmount != null) result.remainingAmount = remainingAmount;
    if (percentageUsed != null) result.percentageUsed = percentageUsed;
    if (status != null) result.status = status;
    if (daysRemaining != null) result.daysRemaining = daysRemaining;
    if (dailyAverageSpend != null) result.dailyAverageSpend = dailyAverageSpend;
    if (projectedSpend != null) result.projectedSpend = projectedSpend;
    if (willExceed != null) result.willExceed = willExceed;
    return result;
  }

  BudgetProgressItem._();

  factory BudgetProgressItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BudgetProgressItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BudgetProgressItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'budgetId')
    ..aOS(2, _omitFieldNames ? '' : 'budgetName')
    ..e<ExpenseCategory>(
        3, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'budgetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'spentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'remainingAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'percentageUsed', $pb.PbFieldType.OD)
    ..e<BudgetStatus>(8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: BudgetStatus.BUDGET_STATUS_UNSPECIFIED,
        valueOf: BudgetStatus.valueOf,
        enumValues: BudgetStatus.values)
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'dailyAverageSpend', $pb.PbFieldType.OD)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'projectedSpend', $pb.PbFieldType.OD)
    ..aOB(12, _omitFieldNames ? '' : 'willExceed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BudgetProgressItem clone() => BudgetProgressItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BudgetProgressItem copyWith(void Function(BudgetProgressItem) updates) =>
      super.copyWith((message) => updates(message as BudgetProgressItem))
          as BudgetProgressItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BudgetProgressItem create() => BudgetProgressItem._();
  @$core.override
  BudgetProgressItem createEmptyInstance() => create();
  static $pb.PbList<BudgetProgressItem> createRepeated() =>
      $pb.PbList<BudgetProgressItem>();
  @$core.pragma('dart2js:noInline')
  static BudgetProgressItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BudgetProgressItem>(create);
  static BudgetProgressItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get budgetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set budgetId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBudgetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudgetId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get budgetName => $_getSZ(1);
  @$pb.TagNumber(2)
  set budgetName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBudgetName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBudgetName() => $_clearField(2);

  @$pb.TagNumber(3)
  ExpenseCategory get category => $_getN(2);
  @$pb.TagNumber(3)
  set category(ExpenseCategory value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get budgetAmount => $_getN(3);
  @$pb.TagNumber(4)
  set budgetAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBudgetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearBudgetAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get spentAmount => $_getN(4);
  @$pb.TagNumber(5)
  set spentAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSpentAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearSpentAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get remainingAmount => $_getN(5);
  @$pb.TagNumber(6)
  set remainingAmount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRemainingAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearRemainingAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get percentageUsed => $_getN(6);
  @$pb.TagNumber(7)
  set percentageUsed($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPercentageUsed() => $_has(6);
  @$pb.TagNumber(7)
  void clearPercentageUsed() => $_clearField(7);

  @$pb.TagNumber(8)
  BudgetStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(BudgetStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get daysRemaining => $_getIZ(8);
  @$pb.TagNumber(9)
  set daysRemaining($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDaysRemaining() => $_has(8);
  @$pb.TagNumber(9)
  void clearDaysRemaining() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get dailyAverageSpend => $_getN(9);
  @$pb.TagNumber(10)
  set dailyAverageSpend($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDailyAverageSpend() => $_has(9);
  @$pb.TagNumber(10)
  void clearDailyAverageSpend() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get projectedSpend => $_getN(10);
  @$pb.TagNumber(11)
  set projectedSpend($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasProjectedSpend() => $_has(10);
  @$pb.TagNumber(11)
  void clearProjectedSpend() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get willExceed => $_getBF(11);
  @$pb.TagNumber(12)
  set willExceed($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasWillExceed() => $_has(11);
  @$pb.TagNumber(12)
  void clearWillExceed() => $_clearField(12);
}

class SpendingTrend extends $pb.GeneratedMessage {
  factory SpendingTrend({
    $core.String? periodLabel,
    $1.Timestamp? periodStart,
    $1.Timestamp? periodEnd,
    $core.double? totalSpent,
    $core.double? budgetAmount,
    $core.double? variance,
    $core.double? variancePercentage,
    $core.Iterable<CategorySpending>? categories,
  }) {
    final result = create();
    if (periodLabel != null) result.periodLabel = periodLabel;
    if (periodStart != null) result.periodStart = periodStart;
    if (periodEnd != null) result.periodEnd = periodEnd;
    if (totalSpent != null) result.totalSpent = totalSpent;
    if (budgetAmount != null) result.budgetAmount = budgetAmount;
    if (variance != null) result.variance = variance;
    if (variancePercentage != null)
      result.variancePercentage = variancePercentage;
    if (categories != null) result.categories.addAll(categories);
    return result;
  }

  SpendingTrend._();

  factory SpendingTrend.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SpendingTrend.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SpendingTrend',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'periodLabel')
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'periodStart',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'periodEnd',
        subBuilder: $1.Timestamp.create)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalSpent', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'budgetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'variance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'variancePercentage', $pb.PbFieldType.OD)
    ..pc<CategorySpending>(
        8, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM,
        subBuilder: CategorySpending.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SpendingTrend clone() => SpendingTrend()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SpendingTrend copyWith(void Function(SpendingTrend) updates) =>
      super.copyWith((message) => updates(message as SpendingTrend))
          as SpendingTrend;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SpendingTrend create() => SpendingTrend._();
  @$core.override
  SpendingTrend createEmptyInstance() => create();
  static $pb.PbList<SpendingTrend> createRepeated() =>
      $pb.PbList<SpendingTrend>();
  @$core.pragma('dart2js:noInline')
  static SpendingTrend getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SpendingTrend>(create);
  static SpendingTrend? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get periodLabel => $_getSZ(0);
  @$pb.TagNumber(1)
  set periodLabel($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriodLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriodLabel() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.Timestamp get periodStart => $_getN(1);
  @$pb.TagNumber(2)
  set periodStart($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPeriodStart() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriodStart() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensurePeriodStart() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Timestamp get periodEnd => $_getN(2);
  @$pb.TagNumber(3)
  set periodEnd($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPeriodEnd() => $_has(2);
  @$pb.TagNumber(3)
  void clearPeriodEnd() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensurePeriodEnd() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get totalSpent => $_getN(3);
  @$pb.TagNumber(4)
  set totalSpent($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalSpent() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalSpent() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get budgetAmount => $_getN(4);
  @$pb.TagNumber(5)
  set budgetAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBudgetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearBudgetAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get variance => $_getN(5);
  @$pb.TagNumber(6)
  set variance($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVariance() => $_has(5);
  @$pb.TagNumber(6)
  void clearVariance() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get variancePercentage => $_getN(6);
  @$pb.TagNumber(7)
  set variancePercentage($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVariancePercentage() => $_has(6);
  @$pb.TagNumber(7)
  void clearVariancePercentage() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<CategorySpending> get categories => $_getList(7);
}

/// Expense Requests
class CreateExpenseRequest extends $pb.GeneratedMessage {
  factory CreateExpenseRequest({
    $core.String? accountId,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    $core.String? subcategory,
    $core.String? description,
    $core.String? merchant,
    $1.Timestamp? transactionDate,
    $core.String? paymentMethod,
    $core.String? receiptUrl,
    $core.Iterable<$core.String>? tags,
    $core.String? notes,
    $core.bool? isRecurring,
    $core.String? recurrencePattern,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (subcategory != null) result.subcategory = subcategory;
    if (description != null) result.description = description;
    if (merchant != null) result.merchant = merchant;
    if (transactionDate != null) result.transactionDate = transactionDate;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (receiptUrl != null) result.receiptUrl = receiptUrl;
    if (tags != null) result.tags.addAll(tags);
    if (notes != null) result.notes = notes;
    if (isRecurring != null) result.isRecurring = isRecurring;
    if (recurrencePattern != null) result.recurrencePattern = recurrencePattern;
    return result;
  }

  CreateExpenseRequest._();

  factory CreateExpenseRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateExpenseRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateExpenseRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..e<ExpenseCategory>(
        4, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..aOS(5, _omitFieldNames ? '' : 'subcategory')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'merchant')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'transactionDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(9, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(10, _omitFieldNames ? '' : 'receiptUrl')
    ..pPS(11, _omitFieldNames ? '' : 'tags')
    ..aOS(12, _omitFieldNames ? '' : 'notes')
    ..aOB(13, _omitFieldNames ? '' : 'isRecurring')
    ..aOS(14, _omitFieldNames ? '' : 'recurrencePattern')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateExpenseRequest clone() =>
      CreateExpenseRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateExpenseRequest copyWith(void Function(CreateExpenseRequest) updates) =>
      super.copyWith((message) => updates(message as CreateExpenseRequest))
          as CreateExpenseRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateExpenseRequest create() => CreateExpenseRequest._();
  @$core.override
  CreateExpenseRequest createEmptyInstance() => create();
  static $pb.PbList<CreateExpenseRequest> createRepeated() =>
      $pb.PbList<CreateExpenseRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateExpenseRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateExpenseRequest>(create);
  static CreateExpenseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

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
  ExpenseCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(ExpenseCategory value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get subcategory => $_getSZ(4);
  @$pb.TagNumber(5)
  set subcategory($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSubcategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearSubcategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get merchant => $_getSZ(6);
  @$pb.TagNumber(7)
  set merchant($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMerchant() => $_has(6);
  @$pb.TagNumber(7)
  void clearMerchant() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get transactionDate => $_getN(7);
  @$pb.TagNumber(8)
  set transactionDate($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasTransactionDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransactionDate() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureTransactionDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get paymentMethod => $_getSZ(8);
  @$pb.TagNumber(9)
  set paymentMethod($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPaymentMethod() => $_has(8);
  @$pb.TagNumber(9)
  void clearPaymentMethod() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get receiptUrl => $_getSZ(9);
  @$pb.TagNumber(10)
  set receiptUrl($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasReceiptUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearReceiptUrl() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<$core.String> get tags => $_getList(10);

  @$pb.TagNumber(12)
  $core.String get notes => $_getSZ(11);
  @$pb.TagNumber(12)
  set notes($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasNotes() => $_has(11);
  @$pb.TagNumber(12)
  void clearNotes() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get isRecurring => $_getBF(12);
  @$pb.TagNumber(13)
  set isRecurring($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIsRecurring() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsRecurring() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get recurrencePattern => $_getSZ(13);
  @$pb.TagNumber(14)
  set recurrencePattern($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasRecurrencePattern() => $_has(13);
  @$pb.TagNumber(14)
  void clearRecurrencePattern() => $_clearField(14);
}

class CreateExpenseResponse extends $pb.GeneratedMessage {
  factory CreateExpenseResponse({
    ExpenseMessage? expense,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (expense != null) result.expense = expense;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  CreateExpenseResponse._();

  factory CreateExpenseResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateExpenseResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateExpenseResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ExpenseMessage>(1, _omitFieldNames ? '' : 'expense',
        subBuilder: ExpenseMessage.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateExpenseResponse clone() =>
      CreateExpenseResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateExpenseResponse copyWith(
          void Function(CreateExpenseResponse) updates) =>
      super.copyWith((message) => updates(message as CreateExpenseResponse))
          as CreateExpenseResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateExpenseResponse create() => CreateExpenseResponse._();
  @$core.override
  CreateExpenseResponse createEmptyInstance() => create();
  static $pb.PbList<CreateExpenseResponse> createRepeated() =>
      $pb.PbList<CreateExpenseResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateExpenseResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateExpenseResponse>(create);
  static CreateExpenseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseMessage get expense => $_getN(0);
  @$pb.TagNumber(1)
  set expense(ExpenseMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasExpense() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpense() => $_clearField(1);
  @$pb.TagNumber(1)
  ExpenseMessage ensureExpense() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class GetExpensesRequest extends $pb.GeneratedMessage {
  factory GetExpensesRequest({
    $core.int? page,
    $core.int? perPage,
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
    ExpenseCategory? category,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.String? searchQuery,
    $core.Iterable<$core.String>? tags,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (category != null) result.category = category;
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    if (searchQuery != null) result.searchQuery = searchQuery;
    if (tags != null) result.tags.addAll(tags);
    return result;
  }

  GetExpensesRequest._();

  factory GetExpensesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExpensesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExpensesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..e<ExpenseCategory>(
        5, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'searchQuery')
    ..pPS(9, _omitFieldNames ? '' : 'tags')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpensesRequest clone() => GetExpensesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpensesRequest copyWith(void Function(GetExpensesRequest) updates) =>
      super.copyWith((message) => updates(message as GetExpensesRequest))
          as GetExpensesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExpensesRequest create() => GetExpensesRequest._();
  @$core.override
  GetExpensesRequest createEmptyInstance() => create();
  static $pb.PbList<GetExpensesRequest> createRepeated() =>
      $pb.PbList<GetExpensesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExpensesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExpensesRequest>(create);
  static GetExpensesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get perPage => $_getIZ(1);
  @$pb.TagNumber(2)
  set perPage($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPerPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get startDate => $_getN(2);
  @$pb.TagNumber(3)
  set startDate($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureStartDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Timestamp get endDate => $_getN(3);
  @$pb.TagNumber(4)
  set endDate($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureEndDate() => $_ensure(3);

  @$pb.TagNumber(5)
  ExpenseCategory get category => $_getN(4);
  @$pb.TagNumber(5)
  set category(ExpenseCategory value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get minAmount => $_getN(5);
  @$pb.TagNumber(6)
  set minAmount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMinAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearMinAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get maxAmount => $_getN(6);
  @$pb.TagNumber(7)
  set maxAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMaxAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get searchQuery => $_getSZ(7);
  @$pb.TagNumber(8)
  set searchQuery($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSearchQuery() => $_has(7);
  @$pb.TagNumber(8)
  void clearSearchQuery() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get tags => $_getList(8);
}

class GetExpensesResponse extends $pb.GeneratedMessage {
  factory GetExpensesResponse({
    $core.Iterable<ExpenseMessage>? expenses,
    PaginationMetadata? pagination,
    $core.double? totalAmount,
    $core.int? totalCount,
  }) {
    final result = create();
    if (expenses != null) result.expenses.addAll(expenses);
    if (pagination != null) result.pagination = pagination;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  GetExpensesResponse._();

  factory GetExpensesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExpensesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExpensesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<ExpenseMessage>(
        1, _omitFieldNames ? '' : 'expenses', $pb.PbFieldType.PM,
        subBuilder: ExpenseMessage.create)
    ..aOM<PaginationMetadata>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PaginationMetadata.create)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpensesResponse clone() => GetExpensesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpensesResponse copyWith(void Function(GetExpensesResponse) updates) =>
      super.copyWith((message) => updates(message as GetExpensesResponse))
          as GetExpensesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExpensesResponse create() => GetExpensesResponse._();
  @$core.override
  GetExpensesResponse createEmptyInstance() => create();
  static $pb.PbList<GetExpensesResponse> createRepeated() =>
      $pb.PbList<GetExpensesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExpensesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExpensesResponse>(create);
  static GetExpensesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ExpenseMessage> get expenses => $_getList(0);

  @$pb.TagNumber(2)
  PaginationMetadata get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaginationMetadata value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PaginationMetadata ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get totalAmount => $_getN(2);
  @$pb.TagNumber(3)
  set totalAmount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCount() => $_clearField(4);
}

class GetExpenseByIdRequest extends $pb.GeneratedMessage {
  factory GetExpenseByIdRequest({
    $core.String? expenseId,
  }) {
    final result = create();
    if (expenseId != null) result.expenseId = expenseId;
    return result;
  }

  GetExpenseByIdRequest._();

  factory GetExpenseByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExpenseByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExpenseByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'expenseId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpenseByIdRequest clone() =>
      GetExpenseByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpenseByIdRequest copyWith(
          void Function(GetExpenseByIdRequest) updates) =>
      super.copyWith((message) => updates(message as GetExpenseByIdRequest))
          as GetExpenseByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExpenseByIdRequest create() => GetExpenseByIdRequest._();
  @$core.override
  GetExpenseByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetExpenseByIdRequest> createRepeated() =>
      $pb.PbList<GetExpenseByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExpenseByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExpenseByIdRequest>(create);
  static GetExpenseByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get expenseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set expenseId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExpenseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpenseId() => $_clearField(1);
}

class GetExpenseByIdResponse extends $pb.GeneratedMessage {
  factory GetExpenseByIdResponse({
    ExpenseMessage? expense,
  }) {
    final result = create();
    if (expense != null) result.expense = expense;
    return result;
  }

  GetExpenseByIdResponse._();

  factory GetExpenseByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExpenseByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExpenseByIdResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ExpenseMessage>(1, _omitFieldNames ? '' : 'expense',
        subBuilder: ExpenseMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpenseByIdResponse clone() =>
      GetExpenseByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpenseByIdResponse copyWith(
          void Function(GetExpenseByIdResponse) updates) =>
      super.copyWith((message) => updates(message as GetExpenseByIdResponse))
          as GetExpenseByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExpenseByIdResponse create() => GetExpenseByIdResponse._();
  @$core.override
  GetExpenseByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetExpenseByIdResponse> createRepeated() =>
      $pb.PbList<GetExpenseByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExpenseByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExpenseByIdResponse>(create);
  static GetExpenseByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseMessage get expense => $_getN(0);
  @$pb.TagNumber(1)
  set expense(ExpenseMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasExpense() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpense() => $_clearField(1);
  @$pb.TagNumber(1)
  ExpenseMessage ensureExpense() => $_ensure(0);
}

class UpdateExpenseRequest extends $pb.GeneratedMessage {
  factory UpdateExpenseRequest({
    $core.String? expenseId,
    $core.double? amount,
    ExpenseCategory? category,
    $core.String? subcategory,
    $core.String? description,
    $core.String? merchant,
    $1.Timestamp? transactionDate,
    $core.String? paymentMethod,
    $core.Iterable<$core.String>? tags,
    $core.String? notes,
  }) {
    final result = create();
    if (expenseId != null) result.expenseId = expenseId;
    if (amount != null) result.amount = amount;
    if (category != null) result.category = category;
    if (subcategory != null) result.subcategory = subcategory;
    if (description != null) result.description = description;
    if (merchant != null) result.merchant = merchant;
    if (transactionDate != null) result.transactionDate = transactionDate;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (tags != null) result.tags.addAll(tags);
    if (notes != null) result.notes = notes;
    return result;
  }

  UpdateExpenseRequest._();

  factory UpdateExpenseRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateExpenseRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateExpenseRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'expenseId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..e<ExpenseCategory>(
        3, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..aOS(4, _omitFieldNames ? '' : 'subcategory')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'merchant')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'transactionDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(8, _omitFieldNames ? '' : 'paymentMethod')
    ..pPS(9, _omitFieldNames ? '' : 'tags')
    ..aOS(10, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateExpenseRequest clone() =>
      UpdateExpenseRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateExpenseRequest copyWith(void Function(UpdateExpenseRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateExpenseRequest))
          as UpdateExpenseRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateExpenseRequest create() => UpdateExpenseRequest._();
  @$core.override
  UpdateExpenseRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateExpenseRequest> createRepeated() =>
      $pb.PbList<UpdateExpenseRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateExpenseRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateExpenseRequest>(create);
  static UpdateExpenseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get expenseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set expenseId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExpenseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpenseId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  ExpenseCategory get category => $_getN(2);
  @$pb.TagNumber(3)
  set category(ExpenseCategory value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get subcategory => $_getSZ(3);
  @$pb.TagNumber(4)
  set subcategory($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSubcategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubcategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get merchant => $_getSZ(5);
  @$pb.TagNumber(6)
  set merchant($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMerchant() => $_has(5);
  @$pb.TagNumber(6)
  void clearMerchant() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get transactionDate => $_getN(6);
  @$pb.TagNumber(7)
  set transactionDate($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTransactionDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionDate() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureTransactionDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get paymentMethod => $_getSZ(7);
  @$pb.TagNumber(8)
  set paymentMethod($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPaymentMethod() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentMethod() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get tags => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get notes => $_getSZ(9);
  @$pb.TagNumber(10)
  set notes($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasNotes() => $_has(9);
  @$pb.TagNumber(10)
  void clearNotes() => $_clearField(10);
}

class UpdateExpenseResponse extends $pb.GeneratedMessage {
  factory UpdateExpenseResponse({
    ExpenseMessage? expense,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (expense != null) result.expense = expense;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  UpdateExpenseResponse._();

  factory UpdateExpenseResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateExpenseResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateExpenseResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ExpenseMessage>(1, _omitFieldNames ? '' : 'expense',
        subBuilder: ExpenseMessage.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateExpenseResponse clone() =>
      UpdateExpenseResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateExpenseResponse copyWith(
          void Function(UpdateExpenseResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateExpenseResponse))
          as UpdateExpenseResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateExpenseResponse create() => UpdateExpenseResponse._();
  @$core.override
  UpdateExpenseResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateExpenseResponse> createRepeated() =>
      $pb.PbList<UpdateExpenseResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateExpenseResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateExpenseResponse>(create);
  static UpdateExpenseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseMessage get expense => $_getN(0);
  @$pb.TagNumber(1)
  set expense(ExpenseMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasExpense() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpense() => $_clearField(1);
  @$pb.TagNumber(1)
  ExpenseMessage ensureExpense() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class DeleteExpenseRequest extends $pb.GeneratedMessage {
  factory DeleteExpenseRequest({
    $core.String? expenseId,
  }) {
    final result = create();
    if (expenseId != null) result.expenseId = expenseId;
    return result;
  }

  DeleteExpenseRequest._();

  factory DeleteExpenseRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteExpenseRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteExpenseRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'expenseId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteExpenseRequest clone() =>
      DeleteExpenseRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteExpenseRequest copyWith(void Function(DeleteExpenseRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteExpenseRequest))
          as DeleteExpenseRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteExpenseRequest create() => DeleteExpenseRequest._();
  @$core.override
  DeleteExpenseRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteExpenseRequest> createRepeated() =>
      $pb.PbList<DeleteExpenseRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteExpenseRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteExpenseRequest>(create);
  static DeleteExpenseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get expenseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set expenseId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExpenseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpenseId() => $_clearField(1);
}

class DeleteExpenseResponse extends $pb.GeneratedMessage {
  factory DeleteExpenseResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteExpenseResponse._();

  factory DeleteExpenseResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteExpenseResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteExpenseResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteExpenseResponse clone() =>
      DeleteExpenseResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteExpenseResponse copyWith(
          void Function(DeleteExpenseResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteExpenseResponse))
          as DeleteExpenseResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteExpenseResponse create() => DeleteExpenseResponse._();
  @$core.override
  DeleteExpenseResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteExpenseResponse> createRepeated() =>
      $pb.PbList<DeleteExpenseResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteExpenseResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteExpenseResponse>(create);
  static DeleteExpenseResponse? _defaultInstance;

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

/// Budget Requests
class CreateBudgetRequest extends $pb.GeneratedMessage {
  factory CreateBudgetRequest({
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    BudgetPeriod? period,
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
    $core.bool? enableAlerts,
    $core.double? alertThreshold,
    BudgetEnforcementMode? enforcementMode,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (period != null) result.period = period;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (enableAlerts != null) result.enableAlerts = enableAlerts;
    if (alertThreshold != null) result.alertThreshold = alertThreshold;
    if (enforcementMode != null) result.enforcementMode = enforcementMode;
    return result;
  }

  CreateBudgetRequest._();

  factory CreateBudgetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateBudgetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateBudgetRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..e<ExpenseCategory>(
        4, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..e<BudgetPeriod>(5, _omitFieldNames ? '' : 'period', $pb.PbFieldType.OE,
        defaultOrMaker: BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED,
        valueOf: BudgetPeriod.valueOf,
        enumValues: BudgetPeriod.values)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..aOB(8, _omitFieldNames ? '' : 'enableAlerts')
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'alertThreshold', $pb.PbFieldType.OD)
    ..e<BudgetEnforcementMode>(
        10, _omitFieldNames ? '' : 'enforcementMode', $pb.PbFieldType.OE,
        defaultOrMaker:
            BudgetEnforcementMode.BUDGET_ENFORCEMENT_MODE_UNSPECIFIED,
        valueOf: BudgetEnforcementMode.valueOf,
        enumValues: BudgetEnforcementMode.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBudgetRequest clone() => CreateBudgetRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBudgetRequest copyWith(void Function(CreateBudgetRequest) updates) =>
      super.copyWith((message) => updates(message as CreateBudgetRequest))
          as CreateBudgetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateBudgetRequest create() => CreateBudgetRequest._();
  @$core.override
  CreateBudgetRequest createEmptyInstance() => create();
  static $pb.PbList<CreateBudgetRequest> createRepeated() =>
      $pb.PbList<CreateBudgetRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateBudgetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateBudgetRequest>(create);
  static CreateBudgetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

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
  ExpenseCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(ExpenseCategory value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  BudgetPeriod get period => $_getN(4);
  @$pb.TagNumber(5)
  set period(BudgetPeriod value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPeriod() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeriod() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get startDate => $_getN(5);
  @$pb.TagNumber(6)
  set startDate($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStartDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartDate() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureStartDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.Timestamp get endDate => $_getN(6);
  @$pb.TagNumber(7)
  set endDate($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEndDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearEndDate() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureEndDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get enableAlerts => $_getBF(7);
  @$pb.TagNumber(8)
  set enableAlerts($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasEnableAlerts() => $_has(7);
  @$pb.TagNumber(8)
  void clearEnableAlerts() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get alertThreshold => $_getN(8);
  @$pb.TagNumber(9)
  set alertThreshold($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAlertThreshold() => $_has(8);
  @$pb.TagNumber(9)
  void clearAlertThreshold() => $_clearField(9);

  @$pb.TagNumber(10)
  BudgetEnforcementMode get enforcementMode => $_getN(9);
  @$pb.TagNumber(10)
  set enforcementMode(BudgetEnforcementMode value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasEnforcementMode() => $_has(9);
  @$pb.TagNumber(10)
  void clearEnforcementMode() => $_clearField(10);
}

class CreateBudgetResponse extends $pb.GeneratedMessage {
  factory CreateBudgetResponse({
    BudgetMessage? budget,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (budget != null) result.budget = budget;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  CreateBudgetResponse._();

  factory CreateBudgetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateBudgetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateBudgetResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<BudgetMessage>(1, _omitFieldNames ? '' : 'budget',
        subBuilder: BudgetMessage.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBudgetResponse clone() =>
      CreateBudgetResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBudgetResponse copyWith(void Function(CreateBudgetResponse) updates) =>
      super.copyWith((message) => updates(message as CreateBudgetResponse))
          as CreateBudgetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateBudgetResponse create() => CreateBudgetResponse._();
  @$core.override
  CreateBudgetResponse createEmptyInstance() => create();
  static $pb.PbList<CreateBudgetResponse> createRepeated() =>
      $pb.PbList<CreateBudgetResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateBudgetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateBudgetResponse>(create);
  static CreateBudgetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BudgetMessage get budget => $_getN(0);
  @$pb.TagNumber(1)
  set budget(BudgetMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBudget() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudget() => $_clearField(1);
  @$pb.TagNumber(1)
  BudgetMessage ensureBudget() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class GetBudgetsRequest extends $pb.GeneratedMessage {
  factory GetBudgetsRequest({
    $core.int? page,
    $core.int? perPage,
    BudgetStatus? status,
    ExpenseCategory? category,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    if (status != null) result.status = status;
    if (category != null) result.category = category;
    return result;
  }

  GetBudgetsRequest._();

  factory GetBudgetsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBudgetsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBudgetsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..e<BudgetStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: BudgetStatus.BUDGET_STATUS_UNSPECIFIED,
        valueOf: BudgetStatus.valueOf,
        enumValues: BudgetStatus.values)
    ..e<ExpenseCategory>(
        4, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetsRequest clone() => GetBudgetsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetsRequest copyWith(void Function(GetBudgetsRequest) updates) =>
      super.copyWith((message) => updates(message as GetBudgetsRequest))
          as GetBudgetsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBudgetsRequest create() => GetBudgetsRequest._();
  @$core.override
  GetBudgetsRequest createEmptyInstance() => create();
  static $pb.PbList<GetBudgetsRequest> createRepeated() =>
      $pb.PbList<GetBudgetsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBudgetsRequest>(create);
  static GetBudgetsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get perPage => $_getIZ(1);
  @$pb.TagNumber(2)
  set perPage($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPerPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerPage() => $_clearField(2);

  @$pb.TagNumber(3)
  BudgetStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(BudgetStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  ExpenseCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(ExpenseCategory value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);
}

class GetBudgetsResponse extends $pb.GeneratedMessage {
  factory GetBudgetsResponse({
    $core.Iterable<BudgetMessage>? budgets,
    PaginationMetadata? pagination,
    $core.double? totalBudgetAmount,
    $core.double? totalSpentAmount,
  }) {
    final result = create();
    if (budgets != null) result.budgets.addAll(budgets);
    if (pagination != null) result.pagination = pagination;
    if (totalBudgetAmount != null) result.totalBudgetAmount = totalBudgetAmount;
    if (totalSpentAmount != null) result.totalSpentAmount = totalSpentAmount;
    return result;
  }

  GetBudgetsResponse._();

  factory GetBudgetsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBudgetsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBudgetsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<BudgetMessage>(1, _omitFieldNames ? '' : 'budgets', $pb.PbFieldType.PM,
        subBuilder: BudgetMessage.create)
    ..aOM<PaginationMetadata>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PaginationMetadata.create)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalBudgetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalSpentAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetsResponse clone() => GetBudgetsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetsResponse copyWith(void Function(GetBudgetsResponse) updates) =>
      super.copyWith((message) => updates(message as GetBudgetsResponse))
          as GetBudgetsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBudgetsResponse create() => GetBudgetsResponse._();
  @$core.override
  GetBudgetsResponse createEmptyInstance() => create();
  static $pb.PbList<GetBudgetsResponse> createRepeated() =>
      $pb.PbList<GetBudgetsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBudgetsResponse>(create);
  static GetBudgetsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BudgetMessage> get budgets => $_getList(0);

  @$pb.TagNumber(2)
  PaginationMetadata get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaginationMetadata value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PaginationMetadata ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get totalBudgetAmount => $_getN(2);
  @$pb.TagNumber(3)
  set totalBudgetAmount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalBudgetAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalBudgetAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalSpentAmount => $_getN(3);
  @$pb.TagNumber(4)
  set totalSpentAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalSpentAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalSpentAmount() => $_clearField(4);
}

class GetBudgetByIdRequest extends $pb.GeneratedMessage {
  factory GetBudgetByIdRequest({
    $core.String? budgetId,
  }) {
    final result = create();
    if (budgetId != null) result.budgetId = budgetId;
    return result;
  }

  GetBudgetByIdRequest._();

  factory GetBudgetByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBudgetByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBudgetByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'budgetId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetByIdRequest clone() =>
      GetBudgetByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetByIdRequest copyWith(void Function(GetBudgetByIdRequest) updates) =>
      super.copyWith((message) => updates(message as GetBudgetByIdRequest))
          as GetBudgetByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBudgetByIdRequest create() => GetBudgetByIdRequest._();
  @$core.override
  GetBudgetByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetBudgetByIdRequest> createRepeated() =>
      $pb.PbList<GetBudgetByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBudgetByIdRequest>(create);
  static GetBudgetByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get budgetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set budgetId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBudgetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudgetId() => $_clearField(1);
}

class GetBudgetByIdResponse extends $pb.GeneratedMessage {
  factory GetBudgetByIdResponse({
    BudgetMessage? budget,
    $core.Iterable<ExpenseMessage>? recentExpenses,
  }) {
    final result = create();
    if (budget != null) result.budget = budget;
    if (recentExpenses != null) result.recentExpenses.addAll(recentExpenses);
    return result;
  }

  GetBudgetByIdResponse._();

  factory GetBudgetByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBudgetByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBudgetByIdResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<BudgetMessage>(1, _omitFieldNames ? '' : 'budget',
        subBuilder: BudgetMessage.create)
    ..pc<ExpenseMessage>(
        2, _omitFieldNames ? '' : 'recentExpenses', $pb.PbFieldType.PM,
        subBuilder: ExpenseMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetByIdResponse clone() =>
      GetBudgetByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetByIdResponse copyWith(
          void Function(GetBudgetByIdResponse) updates) =>
      super.copyWith((message) => updates(message as GetBudgetByIdResponse))
          as GetBudgetByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBudgetByIdResponse create() => GetBudgetByIdResponse._();
  @$core.override
  GetBudgetByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetBudgetByIdResponse> createRepeated() =>
      $pb.PbList<GetBudgetByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBudgetByIdResponse>(create);
  static GetBudgetByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BudgetMessage get budget => $_getN(0);
  @$pb.TagNumber(1)
  set budget(BudgetMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBudget() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudget() => $_clearField(1);
  @$pb.TagNumber(1)
  BudgetMessage ensureBudget() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<ExpenseMessage> get recentExpenses => $_getList(1);
}

class UpdateBudgetRequest extends $pb.GeneratedMessage {
  factory UpdateBudgetRequest({
    $core.String? budgetId,
    $core.String? name,
    $core.double? amount,
    BudgetPeriod? period,
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
    $core.bool? enableAlerts,
    $core.double? alertThreshold,
    BudgetEnforcementMode? enforcementMode,
  }) {
    final result = create();
    if (budgetId != null) result.budgetId = budgetId;
    if (name != null) result.name = name;
    if (amount != null) result.amount = amount;
    if (period != null) result.period = period;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (enableAlerts != null) result.enableAlerts = enableAlerts;
    if (alertThreshold != null) result.alertThreshold = alertThreshold;
    if (enforcementMode != null) result.enforcementMode = enforcementMode;
    return result;
  }

  UpdateBudgetRequest._();

  factory UpdateBudgetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateBudgetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateBudgetRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'budgetId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..e<BudgetPeriod>(4, _omitFieldNames ? '' : 'period', $pb.PbFieldType.OE,
        defaultOrMaker: BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED,
        valueOf: BudgetPeriod.valueOf,
        enumValues: BudgetPeriod.values)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..aOB(7, _omitFieldNames ? '' : 'enableAlerts')
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'alertThreshold', $pb.PbFieldType.OD)
    ..e<BudgetEnforcementMode>(
        9, _omitFieldNames ? '' : 'enforcementMode', $pb.PbFieldType.OE,
        defaultOrMaker:
            BudgetEnforcementMode.BUDGET_ENFORCEMENT_MODE_UNSPECIFIED,
        valueOf: BudgetEnforcementMode.valueOf,
        enumValues: BudgetEnforcementMode.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBudgetRequest clone() => UpdateBudgetRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBudgetRequest copyWith(void Function(UpdateBudgetRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateBudgetRequest))
          as UpdateBudgetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateBudgetRequest create() => UpdateBudgetRequest._();
  @$core.override
  UpdateBudgetRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateBudgetRequest> createRepeated() =>
      $pb.PbList<UpdateBudgetRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateBudgetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateBudgetRequest>(create);
  static UpdateBudgetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get budgetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set budgetId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBudgetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudgetId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  BudgetPeriod get period => $_getN(3);
  @$pb.TagNumber(4)
  set period(BudgetPeriod value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPeriod() => $_has(3);
  @$pb.TagNumber(4)
  void clearPeriod() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get startDate => $_getN(4);
  @$pb.TagNumber(5)
  set startDate($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStartDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearStartDate() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureStartDate() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Timestamp get endDate => $_getN(5);
  @$pb.TagNumber(6)
  set endDate($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasEndDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearEndDate() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureEndDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get enableAlerts => $_getBF(6);
  @$pb.TagNumber(7)
  set enableAlerts($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEnableAlerts() => $_has(6);
  @$pb.TagNumber(7)
  void clearEnableAlerts() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get alertThreshold => $_getN(7);
  @$pb.TagNumber(8)
  set alertThreshold($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAlertThreshold() => $_has(7);
  @$pb.TagNumber(8)
  void clearAlertThreshold() => $_clearField(8);

  @$pb.TagNumber(9)
  BudgetEnforcementMode get enforcementMode => $_getN(8);
  @$pb.TagNumber(9)
  set enforcementMode(BudgetEnforcementMode value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasEnforcementMode() => $_has(8);
  @$pb.TagNumber(9)
  void clearEnforcementMode() => $_clearField(9);
}

class UpdateBudgetResponse extends $pb.GeneratedMessage {
  factory UpdateBudgetResponse({
    BudgetMessage? budget,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (budget != null) result.budget = budget;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  UpdateBudgetResponse._();

  factory UpdateBudgetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateBudgetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateBudgetResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<BudgetMessage>(1, _omitFieldNames ? '' : 'budget',
        subBuilder: BudgetMessage.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBudgetResponse clone() =>
      UpdateBudgetResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBudgetResponse copyWith(void Function(UpdateBudgetResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateBudgetResponse))
          as UpdateBudgetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateBudgetResponse create() => UpdateBudgetResponse._();
  @$core.override
  UpdateBudgetResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateBudgetResponse> createRepeated() =>
      $pb.PbList<UpdateBudgetResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateBudgetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateBudgetResponse>(create);
  static UpdateBudgetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BudgetMessage get budget => $_getN(0);
  @$pb.TagNumber(1)
  set budget(BudgetMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBudget() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudget() => $_clearField(1);
  @$pb.TagNumber(1)
  BudgetMessage ensureBudget() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class DeleteBudgetRequest extends $pb.GeneratedMessage {
  factory DeleteBudgetRequest({
    $core.String? budgetId,
  }) {
    final result = create();
    if (budgetId != null) result.budgetId = budgetId;
    return result;
  }

  DeleteBudgetRequest._();

  factory DeleteBudgetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteBudgetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteBudgetRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'budgetId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBudgetRequest clone() => DeleteBudgetRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBudgetRequest copyWith(void Function(DeleteBudgetRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteBudgetRequest))
          as DeleteBudgetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteBudgetRequest create() => DeleteBudgetRequest._();
  @$core.override
  DeleteBudgetRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteBudgetRequest> createRepeated() =>
      $pb.PbList<DeleteBudgetRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteBudgetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteBudgetRequest>(create);
  static DeleteBudgetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get budgetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set budgetId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBudgetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudgetId() => $_clearField(1);
}

class DeleteBudgetResponse extends $pb.GeneratedMessage {
  factory DeleteBudgetResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteBudgetResponse._();

  factory DeleteBudgetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteBudgetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteBudgetResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBudgetResponse clone() =>
      DeleteBudgetResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBudgetResponse copyWith(void Function(DeleteBudgetResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteBudgetResponse))
          as DeleteBudgetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteBudgetResponse create() => DeleteBudgetResponse._();
  @$core.override
  DeleteBudgetResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteBudgetResponse> createRepeated() =>
      $pb.PbList<DeleteBudgetResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteBudgetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteBudgetResponse>(create);
  static DeleteBudgetResponse? _defaultInstance;

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

/// Analytics Requests
class GetSpendingAnalyticsRequest extends $pb.GeneratedMessage {
  factory GetSpendingAnalyticsRequest({
    $core.String? period,
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
    ExpenseCategory? category,
  }) {
    final result = create();
    if (period != null) result.period = period;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (category != null) result.category = category;
    return result;
  }

  GetSpendingAnalyticsRequest._();

  factory GetSpendingAnalyticsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSpendingAnalyticsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSpendingAnalyticsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'period')
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..e<ExpenseCategory>(
        4, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSpendingAnalyticsRequest clone() =>
      GetSpendingAnalyticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSpendingAnalyticsRequest copyWith(
          void Function(GetSpendingAnalyticsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetSpendingAnalyticsRequest))
          as GetSpendingAnalyticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSpendingAnalyticsRequest create() =>
      GetSpendingAnalyticsRequest._();
  @$core.override
  GetSpendingAnalyticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSpendingAnalyticsRequest> createRepeated() =>
      $pb.PbList<GetSpendingAnalyticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSpendingAnalyticsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSpendingAnalyticsRequest>(create);
  static GetSpendingAnalyticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get period => $_getSZ(0);
  @$pb.TagNumber(1)
  set period($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.Timestamp get startDate => $_getN(1);
  @$pb.TagNumber(2)
  set startDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureStartDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Timestamp get endDate => $_getN(2);
  @$pb.TagNumber(3)
  set endDate($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureEndDate() => $_ensure(2);

  @$pb.TagNumber(4)
  ExpenseCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(ExpenseCategory value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);
}

class GetSpendingAnalyticsResponse extends $pb.GeneratedMessage {
  factory GetSpendingAnalyticsResponse({
    SpendingAnalytics? analytics,
  }) {
    final result = create();
    if (analytics != null) result.analytics = analytics;
    return result;
  }

  GetSpendingAnalyticsResponse._();

  factory GetSpendingAnalyticsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSpendingAnalyticsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSpendingAnalyticsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<SpendingAnalytics>(1, _omitFieldNames ? '' : 'analytics',
        subBuilder: SpendingAnalytics.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSpendingAnalyticsResponse clone() =>
      GetSpendingAnalyticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSpendingAnalyticsResponse copyWith(
          void Function(GetSpendingAnalyticsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetSpendingAnalyticsResponse))
          as GetSpendingAnalyticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSpendingAnalyticsResponse create() =>
      GetSpendingAnalyticsResponse._();
  @$core.override
  GetSpendingAnalyticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSpendingAnalyticsResponse> createRepeated() =>
      $pb.PbList<GetSpendingAnalyticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSpendingAnalyticsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSpendingAnalyticsResponse>(create);
  static GetSpendingAnalyticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SpendingAnalytics get analytics => $_getN(0);
  @$pb.TagNumber(1)
  set analytics(SpendingAnalytics value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAnalytics() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnalytics() => $_clearField(1);
  @$pb.TagNumber(1)
  SpendingAnalytics ensureAnalytics() => $_ensure(0);
}

class GetCategoryBreakdownRequest extends $pb.GeneratedMessage {
  factory GetCategoryBreakdownRequest({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetCategoryBreakdownRequest._();

  factory GetCategoryBreakdownRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCategoryBreakdownRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCategoryBreakdownRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCategoryBreakdownRequest clone() =>
      GetCategoryBreakdownRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCategoryBreakdownRequest copyWith(
          void Function(GetCategoryBreakdownRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCategoryBreakdownRequest))
          as GetCategoryBreakdownRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCategoryBreakdownRequest create() =>
      GetCategoryBreakdownRequest._();
  @$core.override
  GetCategoryBreakdownRequest createEmptyInstance() => create();
  static $pb.PbList<GetCategoryBreakdownRequest> createRepeated() =>
      $pb.PbList<GetCategoryBreakdownRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCategoryBreakdownRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCategoryBreakdownRequest>(create);
  static GetCategoryBreakdownRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);
}

class GetCategoryBreakdownResponse extends $pb.GeneratedMessage {
  factory GetCategoryBreakdownResponse({
    $core.Iterable<CategorySpending>? categories,
    $core.double? totalSpent,
  }) {
    final result = create();
    if (categories != null) result.categories.addAll(categories);
    if (totalSpent != null) result.totalSpent = totalSpent;
    return result;
  }

  GetCategoryBreakdownResponse._();

  factory GetCategoryBreakdownResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCategoryBreakdownResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCategoryBreakdownResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<CategorySpending>(
        1, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM,
        subBuilder: CategorySpending.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalSpent', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCategoryBreakdownResponse clone() =>
      GetCategoryBreakdownResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCategoryBreakdownResponse copyWith(
          void Function(GetCategoryBreakdownResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCategoryBreakdownResponse))
          as GetCategoryBreakdownResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCategoryBreakdownResponse create() =>
      GetCategoryBreakdownResponse._();
  @$core.override
  GetCategoryBreakdownResponse createEmptyInstance() => create();
  static $pb.PbList<GetCategoryBreakdownResponse> createRepeated() =>
      $pb.PbList<GetCategoryBreakdownResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCategoryBreakdownResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCategoryBreakdownResponse>(create);
  static GetCategoryBreakdownResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CategorySpending> get categories => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalSpent => $_getN(1);
  @$pb.TagNumber(2)
  set totalSpent($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalSpent() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalSpent() => $_clearField(2);
}

class GetBudgetProgressRequest extends $pb.GeneratedMessage {
  factory GetBudgetProgressRequest({
    BudgetPeriod? period,
  }) {
    final result = create();
    if (period != null) result.period = period;
    return result;
  }

  GetBudgetProgressRequest._();

  factory GetBudgetProgressRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBudgetProgressRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBudgetProgressRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<BudgetPeriod>(1, _omitFieldNames ? '' : 'period', $pb.PbFieldType.OE,
        defaultOrMaker: BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED,
        valueOf: BudgetPeriod.valueOf,
        enumValues: BudgetPeriod.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetProgressRequest clone() =>
      GetBudgetProgressRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetProgressRequest copyWith(
          void Function(GetBudgetProgressRequest) updates) =>
      super.copyWith((message) => updates(message as GetBudgetProgressRequest))
          as GetBudgetProgressRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBudgetProgressRequest create() => GetBudgetProgressRequest._();
  @$core.override
  GetBudgetProgressRequest createEmptyInstance() => create();
  static $pb.PbList<GetBudgetProgressRequest> createRepeated() =>
      $pb.PbList<GetBudgetProgressRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetProgressRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBudgetProgressRequest>(create);
  static GetBudgetProgressRequest? _defaultInstance;

  @$pb.TagNumber(1)
  BudgetPeriod get period => $_getN(0);
  @$pb.TagNumber(1)
  set period(BudgetPeriod value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => $_clearField(1);
}

class GetBudgetProgressResponse extends $pb.GeneratedMessage {
  factory GetBudgetProgressResponse({
    $core.Iterable<BudgetProgressItem>? budgets,
    $core.double? totalBudget,
    $core.double? totalSpent,
    $core.double? overallPercentage,
  }) {
    final result = create();
    if (budgets != null) result.budgets.addAll(budgets);
    if (totalBudget != null) result.totalBudget = totalBudget;
    if (totalSpent != null) result.totalSpent = totalSpent;
    if (overallPercentage != null) result.overallPercentage = overallPercentage;
    return result;
  }

  GetBudgetProgressResponse._();

  factory GetBudgetProgressResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBudgetProgressResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBudgetProgressResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<BudgetProgressItem>(
        1, _omitFieldNames ? '' : 'budgets', $pb.PbFieldType.PM,
        subBuilder: BudgetProgressItem.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalBudget', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalSpent', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'overallPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetProgressResponse clone() =>
      GetBudgetProgressResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetProgressResponse copyWith(
          void Function(GetBudgetProgressResponse) updates) =>
      super.copyWith((message) => updates(message as GetBudgetProgressResponse))
          as GetBudgetProgressResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBudgetProgressResponse create() => GetBudgetProgressResponse._();
  @$core.override
  GetBudgetProgressResponse createEmptyInstance() => create();
  static $pb.PbList<GetBudgetProgressResponse> createRepeated() =>
      $pb.PbList<GetBudgetProgressResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetProgressResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBudgetProgressResponse>(create);
  static GetBudgetProgressResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BudgetProgressItem> get budgets => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalBudget => $_getN(1);
  @$pb.TagNumber(2)
  set totalBudget($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalBudget() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalBudget() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalSpent => $_getN(2);
  @$pb.TagNumber(3)
  set totalSpent($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalSpent() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSpent() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get overallPercentage => $_getN(3);
  @$pb.TagNumber(4)
  set overallPercentage($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOverallPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearOverallPercentage() => $_clearField(4);
}

class GetSpendingTrendsRequest extends $pb.GeneratedMessage {
  factory GetSpendingTrendsRequest({
    $core.String? periodType,
    $core.int? periodsCount,
    $1.Timestamp? endDate,
  }) {
    final result = create();
    if (periodType != null) result.periodType = periodType;
    if (periodsCount != null) result.periodsCount = periodsCount;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetSpendingTrendsRequest._();

  factory GetSpendingTrendsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSpendingTrendsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSpendingTrendsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'periodType')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'periodsCount', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSpendingTrendsRequest clone() =>
      GetSpendingTrendsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSpendingTrendsRequest copyWith(
          void Function(GetSpendingTrendsRequest) updates) =>
      super.copyWith((message) => updates(message as GetSpendingTrendsRequest))
          as GetSpendingTrendsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSpendingTrendsRequest create() => GetSpendingTrendsRequest._();
  @$core.override
  GetSpendingTrendsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSpendingTrendsRequest> createRepeated() =>
      $pb.PbList<GetSpendingTrendsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSpendingTrendsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSpendingTrendsRequest>(create);
  static GetSpendingTrendsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get periodType => $_getSZ(0);
  @$pb.TagNumber(1)
  set periodType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriodType() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriodType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get periodsCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set periodsCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPeriodsCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriodsCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get endDate => $_getN(2);
  @$pb.TagNumber(3)
  set endDate($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureEndDate() => $_ensure(2);
}

class GetSpendingTrendsResponse extends $pb.GeneratedMessage {
  factory GetSpendingTrendsResponse({
    $core.Iterable<SpendingTrend>? trends,
  }) {
    final result = create();
    if (trends != null) result.trends.addAll(trends);
    return result;
  }

  GetSpendingTrendsResponse._();

  factory GetSpendingTrendsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSpendingTrendsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSpendingTrendsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<SpendingTrend>(1, _omitFieldNames ? '' : 'trends', $pb.PbFieldType.PM,
        subBuilder: SpendingTrend.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSpendingTrendsResponse clone() =>
      GetSpendingTrendsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSpendingTrendsResponse copyWith(
          void Function(GetSpendingTrendsResponse) updates) =>
      super.copyWith((message) => updates(message as GetSpendingTrendsResponse))
          as GetSpendingTrendsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSpendingTrendsResponse create() => GetSpendingTrendsResponse._();
  @$core.override
  GetSpendingTrendsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSpendingTrendsResponse> createRepeated() =>
      $pb.PbList<GetSpendingTrendsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSpendingTrendsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSpendingTrendsResponse>(create);
  static GetSpendingTrendsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SpendingTrend> get trends => $_getList(0);
}

/// Alert Requests
class GetBudgetAlertsRequest extends $pb.GeneratedMessage {
  factory GetBudgetAlertsRequest({
    $core.bool? unreadOnly,
    $core.int? limit,
  }) {
    final result = create();
    if (unreadOnly != null) result.unreadOnly = unreadOnly;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetBudgetAlertsRequest._();

  factory GetBudgetAlertsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBudgetAlertsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBudgetAlertsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'unreadOnly')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetAlertsRequest clone() =>
      GetBudgetAlertsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetAlertsRequest copyWith(
          void Function(GetBudgetAlertsRequest) updates) =>
      super.copyWith((message) => updates(message as GetBudgetAlertsRequest))
          as GetBudgetAlertsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBudgetAlertsRequest create() => GetBudgetAlertsRequest._();
  @$core.override
  GetBudgetAlertsRequest createEmptyInstance() => create();
  static $pb.PbList<GetBudgetAlertsRequest> createRepeated() =>
      $pb.PbList<GetBudgetAlertsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetAlertsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBudgetAlertsRequest>(create);
  static GetBudgetAlertsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get unreadOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set unreadOnly($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUnreadOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearUnreadOnly() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetBudgetAlertsResponse extends $pb.GeneratedMessage {
  factory GetBudgetAlertsResponse({
    $core.Iterable<BudgetAlertMessage>? alerts,
    $core.int? unreadCount,
  }) {
    final result = create();
    if (alerts != null) result.alerts.addAll(alerts);
    if (unreadCount != null) result.unreadCount = unreadCount;
    return result;
  }

  GetBudgetAlertsResponse._();

  factory GetBudgetAlertsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBudgetAlertsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBudgetAlertsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<BudgetAlertMessage>(
        1, _omitFieldNames ? '' : 'alerts', $pb.PbFieldType.PM,
        subBuilder: BudgetAlertMessage.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'unreadCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetAlertsResponse clone() =>
      GetBudgetAlertsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBudgetAlertsResponse copyWith(
          void Function(GetBudgetAlertsResponse) updates) =>
      super.copyWith((message) => updates(message as GetBudgetAlertsResponse))
          as GetBudgetAlertsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBudgetAlertsResponse create() => GetBudgetAlertsResponse._();
  @$core.override
  GetBudgetAlertsResponse createEmptyInstance() => create();
  static $pb.PbList<GetBudgetAlertsResponse> createRepeated() =>
      $pb.PbList<GetBudgetAlertsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetAlertsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBudgetAlertsResponse>(create);
  static GetBudgetAlertsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BudgetAlertMessage> get alerts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get unreadCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set unreadCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUnreadCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnreadCount() => $_clearField(2);
}

class MarkAlertAsReadRequest extends $pb.GeneratedMessage {
  factory MarkAlertAsReadRequest({
    $core.String? alertId,
  }) {
    final result = create();
    if (alertId != null) result.alertId = alertId;
    return result;
  }

  MarkAlertAsReadRequest._();

  factory MarkAlertAsReadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarkAlertAsReadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarkAlertAsReadRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'alertId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkAlertAsReadRequest clone() =>
      MarkAlertAsReadRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkAlertAsReadRequest copyWith(
          void Function(MarkAlertAsReadRequest) updates) =>
      super.copyWith((message) => updates(message as MarkAlertAsReadRequest))
          as MarkAlertAsReadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkAlertAsReadRequest create() => MarkAlertAsReadRequest._();
  @$core.override
  MarkAlertAsReadRequest createEmptyInstance() => create();
  static $pb.PbList<MarkAlertAsReadRequest> createRepeated() =>
      $pb.PbList<MarkAlertAsReadRequest>();
  @$core.pragma('dart2js:noInline')
  static MarkAlertAsReadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarkAlertAsReadRequest>(create);
  static MarkAlertAsReadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get alertId => $_getSZ(0);
  @$pb.TagNumber(1)
  set alertId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAlertId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlertId() => $_clearField(1);
}

class MarkAlertAsReadResponse extends $pb.GeneratedMessage {
  factory MarkAlertAsReadResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  MarkAlertAsReadResponse._();

  factory MarkAlertAsReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarkAlertAsReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarkAlertAsReadResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkAlertAsReadResponse clone() =>
      MarkAlertAsReadResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkAlertAsReadResponse copyWith(
          void Function(MarkAlertAsReadResponse) updates) =>
      super.copyWith((message) => updates(message as MarkAlertAsReadResponse))
          as MarkAlertAsReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkAlertAsReadResponse create() => MarkAlertAsReadResponse._();
  @$core.override
  MarkAlertAsReadResponse createEmptyInstance() => create();
  static $pb.PbList<MarkAlertAsReadResponse> createRepeated() =>
      $pb.PbList<MarkAlertAsReadResponse>();
  @$core.pragma('dart2js:noInline')
  static MarkAlertAsReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarkAlertAsReadResponse>(create);
  static MarkAlertAsReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

/// Pagination
class PaginationMetadata extends $pb.GeneratedMessage {
  factory PaginationMetadata({
    $core.int? currentPage,
    $core.int? perPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final result = create();
    if (currentPage != null) result.currentPage = currentPage;
    if (perPage != null) result.perPage = perPage;
    if (totalPages != null) result.totalPages = totalPages;
    if (totalItems != null) result.totalItems = totalItems;
    if (hasNext != null) result.hasNext = hasNext;
    if (hasPrev != null) result.hasPrev = hasPrev;
    return result;
  }

  PaginationMetadata._();

  factory PaginationMetadata.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaginationMetadata.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaginationMetadata',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasNext')
    ..aOB(6, _omitFieldNames ? '' : 'hasPrev')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginationMetadata clone() => PaginationMetadata()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginationMetadata copyWith(void Function(PaginationMetadata) updates) =>
      super.copyWith((message) => updates(message as PaginationMetadata))
          as PaginationMetadata;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginationMetadata create() => PaginationMetadata._();
  @$core.override
  PaginationMetadata createEmptyInstance() => create();
  static $pb.PbList<PaginationMetadata> createRepeated() =>
      $pb.PbList<PaginationMetadata>();
  @$core.pragma('dart2js:noInline')
  static PaginationMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaginationMetadata>(create);
  static PaginationMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get perPage => $_getIZ(1);
  @$pb.TagNumber(2)
  set perPage($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPerPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalPages => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalPages($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalPages() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPages() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalItems => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalItems($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalItems() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalItems() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPrev => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPrev($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasHasPrev() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPrev() => $_clearField(6);
}

/// AI Spending Insights Request
class GetAISpendingInsightsRequest extends $pb.GeneratedMessage {
  factory GetAISpendingInsightsRequest({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
    $core.String? focusArea,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (focusArea != null) result.focusArea = focusArea;
    return result;
  }

  GetAISpendingInsightsRequest._();

  factory GetAISpendingInsightsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAISpendingInsightsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAISpendingInsightsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(3, _omitFieldNames ? '' : 'focusArea')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAISpendingInsightsRequest clone() =>
      GetAISpendingInsightsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAISpendingInsightsRequest copyWith(
          void Function(GetAISpendingInsightsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAISpendingInsightsRequest))
          as GetAISpendingInsightsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAISpendingInsightsRequest create() =>
      GetAISpendingInsightsRequest._();
  @$core.override
  GetAISpendingInsightsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAISpendingInsightsRequest> createRepeated() =>
      $pb.PbList<GetAISpendingInsightsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAISpendingInsightsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAISpendingInsightsRequest>(create);
  static GetAISpendingInsightsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get focusArea => $_getSZ(2);
  @$pb.TagNumber(3)
  set focusArea($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFocusArea() => $_has(2);
  @$pb.TagNumber(3)
  void clearFocusArea() => $_clearField(3);
}

/// AI Spending Insights Response
class GetAISpendingInsightsResponse extends $pb.GeneratedMessage {
  factory GetAISpendingInsightsResponse({
    $core.bool? success,
    $core.String? summary,
    $core.Iterable<AIInsight>? insights,
    $core.Iterable<AIRecommendation>? recommendations,
    $core.Iterable<AnomalyDetection>? anomalies,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (summary != null) result.summary = summary;
    if (insights != null) result.insights.addAll(insights);
    if (recommendations != null) result.recommendations.addAll(recommendations);
    if (anomalies != null) result.anomalies.addAll(anomalies);
    return result;
  }

  GetAISpendingInsightsResponse._();

  factory GetAISpendingInsightsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAISpendingInsightsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAISpendingInsightsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'summary')
    ..pc<AIInsight>(3, _omitFieldNames ? '' : 'insights', $pb.PbFieldType.PM,
        subBuilder: AIInsight.create)
    ..pc<AIRecommendation>(
        4, _omitFieldNames ? '' : 'recommendations', $pb.PbFieldType.PM,
        subBuilder: AIRecommendation.create)
    ..pc<AnomalyDetection>(
        5, _omitFieldNames ? '' : 'anomalies', $pb.PbFieldType.PM,
        subBuilder: AnomalyDetection.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAISpendingInsightsResponse clone() =>
      GetAISpendingInsightsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAISpendingInsightsResponse copyWith(
          void Function(GetAISpendingInsightsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAISpendingInsightsResponse))
          as GetAISpendingInsightsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAISpendingInsightsResponse create() =>
      GetAISpendingInsightsResponse._();
  @$core.override
  GetAISpendingInsightsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAISpendingInsightsResponse> createRepeated() =>
      $pb.PbList<GetAISpendingInsightsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAISpendingInsightsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAISpendingInsightsResponse>(create);
  static GetAISpendingInsightsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get summary => $_getSZ(1);
  @$pb.TagNumber(2)
  set summary($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSummary() => $_has(1);
  @$pb.TagNumber(2)
  void clearSummary() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<AIInsight> get insights => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<AIRecommendation> get recommendations => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<AnomalyDetection> get anomalies => $_getList(4);
}

/// Individual AI Insight
class AIInsight extends $pb.GeneratedMessage {
  factory AIInsight({
    $core.String? title,
    $core.String? description,
    $core.String? insightType,
    $core.double? impactAmount,
    $core.Iterable<$core.String>? supportingData,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (insightType != null) result.insightType = insightType;
    if (impactAmount != null) result.impactAmount = impactAmount;
    if (supportingData != null) result.supportingData.addAll(supportingData);
    return result;
  }

  AIInsight._();

  factory AIInsight.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AIInsight.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AIInsight',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'insightType')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'impactAmount', $pb.PbFieldType.OD)
    ..pPS(5, _omitFieldNames ? '' : 'supportingData')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AIInsight clone() => AIInsight()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AIInsight copyWith(void Function(AIInsight) updates) =>
      super.copyWith((message) => updates(message as AIInsight)) as AIInsight;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AIInsight create() => AIInsight._();
  @$core.override
  AIInsight createEmptyInstance() => create();
  static $pb.PbList<AIInsight> createRepeated() => $pb.PbList<AIInsight>();
  @$core.pragma('dart2js:noInline')
  static AIInsight getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AIInsight>(create);
  static AIInsight? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get insightType => $_getSZ(2);
  @$pb.TagNumber(3)
  set insightType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInsightType() => $_has(2);
  @$pb.TagNumber(3)
  void clearInsightType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get impactAmount => $_getN(3);
  @$pb.TagNumber(4)
  set impactAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasImpactAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearImpactAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get supportingData => $_getList(4);
}

/// AI Recommendation
class AIRecommendation extends $pb.GeneratedMessage {
  factory AIRecommendation({
    $core.String? title,
    $core.String? description,
    $core.String? action,
    $core.double? potentialSavings,
    $core.String? priority,
    ExpenseCategory? affectedCategory,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (action != null) result.action = action;
    if (potentialSavings != null) result.potentialSavings = potentialSavings;
    if (priority != null) result.priority = priority;
    if (affectedCategory != null) result.affectedCategory = affectedCategory;
    return result;
  }

  AIRecommendation._();

  factory AIRecommendation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AIRecommendation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AIRecommendation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'action')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'potentialSavings', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'priority')
    ..e<ExpenseCategory>(
        6, _omitFieldNames ? '' : 'affectedCategory', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AIRecommendation clone() => AIRecommendation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AIRecommendation copyWith(void Function(AIRecommendation) updates) =>
      super.copyWith((message) => updates(message as AIRecommendation))
          as AIRecommendation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AIRecommendation create() => AIRecommendation._();
  @$core.override
  AIRecommendation createEmptyInstance() => create();
  static $pb.PbList<AIRecommendation> createRepeated() =>
      $pb.PbList<AIRecommendation>();
  @$core.pragma('dart2js:noInline')
  static AIRecommendation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AIRecommendation>(create);
  static AIRecommendation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get action => $_getSZ(2);
  @$pb.TagNumber(3)
  set action($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAction() => $_has(2);
  @$pb.TagNumber(3)
  void clearAction() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get potentialSavings => $_getN(3);
  @$pb.TagNumber(4)
  set potentialSavings($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPotentialSavings() => $_has(3);
  @$pb.TagNumber(4)
  void clearPotentialSavings() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get priority => $_getSZ(4);
  @$pb.TagNumber(5)
  set priority($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPriority() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriority() => $_clearField(5);

  @$pb.TagNumber(6)
  ExpenseCategory get affectedCategory => $_getN(5);
  @$pb.TagNumber(6)
  set affectedCategory(ExpenseCategory value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasAffectedCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearAffectedCategory() => $_clearField(6);
}

/// Anomaly Detection
class AnomalyDetection extends $pb.GeneratedMessage {
  factory AnomalyDetection({
    $core.String? anomalyType,
    $core.String? description,
    $1.Timestamp? detectedDate,
    $core.double? amount,
    ExpenseCategory? category,
    $core.String? severity,
  }) {
    final result = create();
    if (anomalyType != null) result.anomalyType = anomalyType;
    if (description != null) result.description = description;
    if (detectedDate != null) result.detectedDate = detectedDate;
    if (amount != null) result.amount = amount;
    if (category != null) result.category = category;
    if (severity != null) result.severity = severity;
    return result;
  }

  AnomalyDetection._();

  factory AnomalyDetection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AnomalyDetection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AnomalyDetection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'anomalyType')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'detectedDate',
        subBuilder: $1.Timestamp.create)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..e<ExpenseCategory>(
        5, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..aOS(6, _omitFieldNames ? '' : 'severity')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnomalyDetection clone() => AnomalyDetection()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnomalyDetection copyWith(void Function(AnomalyDetection) updates) =>
      super.copyWith((message) => updates(message as AnomalyDetection))
          as AnomalyDetection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnomalyDetection create() => AnomalyDetection._();
  @$core.override
  AnomalyDetection createEmptyInstance() => create();
  static $pb.PbList<AnomalyDetection> createRepeated() =>
      $pb.PbList<AnomalyDetection>();
  @$core.pragma('dart2js:noInline')
  static AnomalyDetection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnomalyDetection>(create);
  static AnomalyDetection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get anomalyType => $_getSZ(0);
  @$pb.TagNumber(1)
  set anomalyType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAnomalyType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnomalyType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get detectedDate => $_getN(2);
  @$pb.TagNumber(3)
  set detectedDate($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDetectedDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDetectedDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureDetectedDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  ExpenseCategory get category => $_getN(4);
  @$pb.TagNumber(5)
  set category(ExpenseCategory value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get severity => $_getSZ(5);
  @$pb.TagNumber(6)
  set severity($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSeverity() => $_has(5);
  @$pb.TagNumber(6)
  void clearSeverity() => $_clearField(6);
}

/// AI Budgeting Recommendations Request
class GetAIBudgetingRecommendationsRequest extends $pb.GeneratedMessage {
  factory GetAIBudgetingRecommendationsRequest({
    $core.double? monthlyIncome,
    $core.Iterable<$core.String>? financialGoals,
    $core.String? riskTolerance,
  }) {
    final result = create();
    if (monthlyIncome != null) result.monthlyIncome = monthlyIncome;
    if (financialGoals != null) result.financialGoals.addAll(financialGoals);
    if (riskTolerance != null) result.riskTolerance = riskTolerance;
    return result;
  }

  GetAIBudgetingRecommendationsRequest._();

  factory GetAIBudgetingRecommendationsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAIBudgetingRecommendationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAIBudgetingRecommendationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'monthlyIncome', $pb.PbFieldType.OD)
    ..pPS(2, _omitFieldNames ? '' : 'financialGoals')
    ..aOS(3, _omitFieldNames ? '' : 'riskTolerance')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIBudgetingRecommendationsRequest clone() =>
      GetAIBudgetingRecommendationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIBudgetingRecommendationsRequest copyWith(
          void Function(GetAIBudgetingRecommendationsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetAIBudgetingRecommendationsRequest))
          as GetAIBudgetingRecommendationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAIBudgetingRecommendationsRequest create() =>
      GetAIBudgetingRecommendationsRequest._();
  @$core.override
  GetAIBudgetingRecommendationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAIBudgetingRecommendationsRequest> createRepeated() =>
      $pb.PbList<GetAIBudgetingRecommendationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAIBudgetingRecommendationsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetAIBudgetingRecommendationsRequest>(create);
  static GetAIBudgetingRecommendationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get monthlyIncome => $_getN(0);
  @$pb.TagNumber(1)
  set monthlyIncome($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMonthlyIncome() => $_has(0);
  @$pb.TagNumber(1)
  void clearMonthlyIncome() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get financialGoals => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get riskTolerance => $_getSZ(2);
  @$pb.TagNumber(3)
  set riskTolerance($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRiskTolerance() => $_has(2);
  @$pb.TagNumber(3)
  void clearRiskTolerance() => $_clearField(3);
}

/// AI Budgeting Recommendations Response
class GetAIBudgetingRecommendationsResponse extends $pb.GeneratedMessage {
  factory GetAIBudgetingRecommendationsResponse({
    $core.bool? success,
    $core.String? summary,
    $core.Iterable<BudgetRecommendation>? budgetRecommendations,
    $core.double? recommendedSavingsRate,
    $core.String? rationale,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (summary != null) result.summary = summary;
    if (budgetRecommendations != null)
      result.budgetRecommendations.addAll(budgetRecommendations);
    if (recommendedSavingsRate != null)
      result.recommendedSavingsRate = recommendedSavingsRate;
    if (rationale != null) result.rationale = rationale;
    return result;
  }

  GetAIBudgetingRecommendationsResponse._();

  factory GetAIBudgetingRecommendationsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAIBudgetingRecommendationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAIBudgetingRecommendationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'summary')
    ..pc<BudgetRecommendation>(
        3, _omitFieldNames ? '' : 'budgetRecommendations', $pb.PbFieldType.PM,
        subBuilder: BudgetRecommendation.create)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'recommendedSavingsRate', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'rationale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIBudgetingRecommendationsResponse clone() =>
      GetAIBudgetingRecommendationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIBudgetingRecommendationsResponse copyWith(
          void Function(GetAIBudgetingRecommendationsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetAIBudgetingRecommendationsResponse))
          as GetAIBudgetingRecommendationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAIBudgetingRecommendationsResponse create() =>
      GetAIBudgetingRecommendationsResponse._();
  @$core.override
  GetAIBudgetingRecommendationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAIBudgetingRecommendationsResponse> createRepeated() =>
      $pb.PbList<GetAIBudgetingRecommendationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAIBudgetingRecommendationsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetAIBudgetingRecommendationsResponse>(create);
  static GetAIBudgetingRecommendationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get summary => $_getSZ(1);
  @$pb.TagNumber(2)
  set summary($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSummary() => $_has(1);
  @$pb.TagNumber(2)
  void clearSummary() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<BudgetRecommendation> get budgetRecommendations => $_getList(2);

  @$pb.TagNumber(4)
  $core.double get recommendedSavingsRate => $_getN(3);
  @$pb.TagNumber(4)
  set recommendedSavingsRate($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecommendedSavingsRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecommendedSavingsRate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get rationale => $_getSZ(4);
  @$pb.TagNumber(5)
  set rationale($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRationale() => $_has(4);
  @$pb.TagNumber(5)
  void clearRationale() => $_clearField(5);
}

/// Individual Budget Recommendation
class BudgetRecommendation extends $pb.GeneratedMessage {
  factory BudgetRecommendation({
    ExpenseCategory? category,
    $core.String? categoryName,
    $core.double? recommendedAmount,
    $core.double? currentAmount,
    $core.double? difference,
    $core.String? reasoning,
    BudgetPeriod? recommendedPeriod,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (categoryName != null) result.categoryName = categoryName;
    if (recommendedAmount != null) result.recommendedAmount = recommendedAmount;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (difference != null) result.difference = difference;
    if (reasoning != null) result.reasoning = reasoning;
    if (recommendedPeriod != null) result.recommendedPeriod = recommendedPeriod;
    return result;
  }

  BudgetRecommendation._();

  factory BudgetRecommendation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BudgetRecommendation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BudgetRecommendation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<ExpenseCategory>(
        1, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..aOS(2, _omitFieldNames ? '' : 'categoryName')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'recommendedAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'difference', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'reasoning')
    ..e<BudgetPeriod>(
        7, _omitFieldNames ? '' : 'recommendedPeriod', $pb.PbFieldType.OE,
        defaultOrMaker: BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED,
        valueOf: BudgetPeriod.valueOf,
        enumValues: BudgetPeriod.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BudgetRecommendation clone() =>
      BudgetRecommendation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BudgetRecommendation copyWith(void Function(BudgetRecommendation) updates) =>
      super.copyWith((message) => updates(message as BudgetRecommendation))
          as BudgetRecommendation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BudgetRecommendation create() => BudgetRecommendation._();
  @$core.override
  BudgetRecommendation createEmptyInstance() => create();
  static $pb.PbList<BudgetRecommendation> createRepeated() =>
      $pb.PbList<BudgetRecommendation>();
  @$core.pragma('dart2js:noInline')
  static BudgetRecommendation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BudgetRecommendation>(create);
  static BudgetRecommendation? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(ExpenseCategory value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get categoryName => $_getSZ(1);
  @$pb.TagNumber(2)
  set categoryName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategoryName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategoryName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get recommendedAmount => $_getN(2);
  @$pb.TagNumber(3)
  set recommendedAmount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecommendedAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecommendedAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get currentAmount => $_getN(3);
  @$pb.TagNumber(4)
  set currentAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get difference => $_getN(4);
  @$pb.TagNumber(5)
  set difference($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDifference() => $_has(4);
  @$pb.TagNumber(5)
  void clearDifference() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get reasoning => $_getSZ(5);
  @$pb.TagNumber(6)
  set reasoning($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReasoning() => $_has(5);
  @$pb.TagNumber(6)
  void clearReasoning() => $_clearField(6);

  @$pb.TagNumber(7)
  BudgetPeriod get recommendedPeriod => $_getN(6);
  @$pb.TagNumber(7)
  set recommendedPeriod(BudgetPeriod value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasRecommendedPeriod() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecommendedPeriod() => $_clearField(7);
}

/// Auto Categorize Expense Request
class AutoCategorizeExpenseRequest extends $pb.GeneratedMessage {
  factory AutoCategorizeExpenseRequest({
    $core.String? description,
    $core.String? merchant,
    $core.double? amount,
    $core.String? notes,
  }) {
    final result = create();
    if (description != null) result.description = description;
    if (merchant != null) result.merchant = merchant;
    if (amount != null) result.amount = amount;
    if (notes != null) result.notes = notes;
    return result;
  }

  AutoCategorizeExpenseRequest._();

  factory AutoCategorizeExpenseRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AutoCategorizeExpenseRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AutoCategorizeExpenseRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..aOS(2, _omitFieldNames ? '' : 'merchant')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoCategorizeExpenseRequest clone() =>
      AutoCategorizeExpenseRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoCategorizeExpenseRequest copyWith(
          void Function(AutoCategorizeExpenseRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AutoCategorizeExpenseRequest))
          as AutoCategorizeExpenseRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutoCategorizeExpenseRequest create() =>
      AutoCategorizeExpenseRequest._();
  @$core.override
  AutoCategorizeExpenseRequest createEmptyInstance() => create();
  static $pb.PbList<AutoCategorizeExpenseRequest> createRepeated() =>
      $pb.PbList<AutoCategorizeExpenseRequest>();
  @$core.pragma('dart2js:noInline')
  static AutoCategorizeExpenseRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AutoCategorizeExpenseRequest>(create);
  static AutoCategorizeExpenseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get merchant => $_getSZ(1);
  @$pb.TagNumber(2)
  set merchant($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMerchant() => $_has(1);
  @$pb.TagNumber(2)
  void clearMerchant() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get notes => $_getSZ(3);
  @$pb.TagNumber(4)
  set notes($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNotes() => $_has(3);
  @$pb.TagNumber(4)
  void clearNotes() => $_clearField(4);
}

/// Auto Categorize Expense Response
class AutoCategorizeExpenseResponse extends $pb.GeneratedMessage {
  factory AutoCategorizeExpenseResponse({
    $core.bool? success,
    ExpenseCategory? suggestedCategory,
    $core.String? categoryName,
    $core.double? confidenceScore,
    $core.Iterable<CategorySuggestion>? alternativeCategories,
    $core.String? reasoning,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (suggestedCategory != null) result.suggestedCategory = suggestedCategory;
    if (categoryName != null) result.categoryName = categoryName;
    if (confidenceScore != null) result.confidenceScore = confidenceScore;
    if (alternativeCategories != null)
      result.alternativeCategories.addAll(alternativeCategories);
    if (reasoning != null) result.reasoning = reasoning;
    return result;
  }

  AutoCategorizeExpenseResponse._();

  factory AutoCategorizeExpenseResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AutoCategorizeExpenseResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AutoCategorizeExpenseResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<ExpenseCategory>(
        2, _omitFieldNames ? '' : 'suggestedCategory', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..aOS(3, _omitFieldNames ? '' : 'categoryName')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'confidenceScore', $pb.PbFieldType.OD)
    ..pc<CategorySuggestion>(
        5, _omitFieldNames ? '' : 'alternativeCategories', $pb.PbFieldType.PM,
        subBuilder: CategorySuggestion.create)
    ..aOS(6, _omitFieldNames ? '' : 'reasoning')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoCategorizeExpenseResponse clone() =>
      AutoCategorizeExpenseResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoCategorizeExpenseResponse copyWith(
          void Function(AutoCategorizeExpenseResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AutoCategorizeExpenseResponse))
          as AutoCategorizeExpenseResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutoCategorizeExpenseResponse create() =>
      AutoCategorizeExpenseResponse._();
  @$core.override
  AutoCategorizeExpenseResponse createEmptyInstance() => create();
  static $pb.PbList<AutoCategorizeExpenseResponse> createRepeated() =>
      $pb.PbList<AutoCategorizeExpenseResponse>();
  @$core.pragma('dart2js:noInline')
  static AutoCategorizeExpenseResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AutoCategorizeExpenseResponse>(create);
  static AutoCategorizeExpenseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  ExpenseCategory get suggestedCategory => $_getN(1);
  @$pb.TagNumber(2)
  set suggestedCategory(ExpenseCategory value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSuggestedCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuggestedCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get categoryName => $_getSZ(2);
  @$pb.TagNumber(3)
  set categoryName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCategoryName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategoryName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get confidenceScore => $_getN(3);
  @$pb.TagNumber(4)
  set confidenceScore($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasConfidenceScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearConfidenceScore() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<CategorySuggestion> get alternativeCategories => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get reasoning => $_getSZ(5);
  @$pb.TagNumber(6)
  set reasoning($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReasoning() => $_has(5);
  @$pb.TagNumber(6)
  void clearReasoning() => $_clearField(6);
}

/// Category Suggestion
class CategorySuggestion extends $pb.GeneratedMessage {
  factory CategorySuggestion({
    ExpenseCategory? category,
    $core.String? categoryName,
    $core.double? confidenceScore,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (categoryName != null) result.categoryName = categoryName;
    if (confidenceScore != null) result.confidenceScore = confidenceScore;
    return result;
  }

  CategorySuggestion._();

  factory CategorySuggestion.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CategorySuggestion.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CategorySuggestion',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<ExpenseCategory>(
        1, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..aOS(2, _omitFieldNames ? '' : 'categoryName')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'confidenceScore', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategorySuggestion clone() => CategorySuggestion()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategorySuggestion copyWith(void Function(CategorySuggestion) updates) =>
      super.copyWith((message) => updates(message as CategorySuggestion))
          as CategorySuggestion;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CategorySuggestion create() => CategorySuggestion._();
  @$core.override
  CategorySuggestion createEmptyInstance() => create();
  static $pb.PbList<CategorySuggestion> createRepeated() =>
      $pb.PbList<CategorySuggestion>();
  @$core.pragma('dart2js:noInline')
  static CategorySuggestion getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CategorySuggestion>(create);
  static CategorySuggestion? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(ExpenseCategory value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get categoryName => $_getSZ(1);
  @$pb.TagNumber(2)
  set categoryName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategoryName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategoryName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get confidenceScore => $_getN(2);
  @$pb.TagNumber(3)
  set confidenceScore($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConfidenceScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfidenceScore() => $_clearField(3);
}

/// AI Financial Advice Request
class GetAIFinancialAdviceRequest extends $pb.GeneratedMessage {
  factory GetAIFinancialAdviceRequest({
    $core.String? query,
    $core.Iterable<$core.String>? contextAreas,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (contextAreas != null) result.contextAreas.addAll(contextAreas);
    return result;
  }

  GetAIFinancialAdviceRequest._();

  factory GetAIFinancialAdviceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAIFinancialAdviceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAIFinancialAdviceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..pPS(2, _omitFieldNames ? '' : 'contextAreas')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIFinancialAdviceRequest clone() =>
      GetAIFinancialAdviceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIFinancialAdviceRequest copyWith(
          void Function(GetAIFinancialAdviceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAIFinancialAdviceRequest))
          as GetAIFinancialAdviceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAIFinancialAdviceRequest create() =>
      GetAIFinancialAdviceRequest._();
  @$core.override
  GetAIFinancialAdviceRequest createEmptyInstance() => create();
  static $pb.PbList<GetAIFinancialAdviceRequest> createRepeated() =>
      $pb.PbList<GetAIFinancialAdviceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAIFinancialAdviceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAIFinancialAdviceRequest>(create);
  static GetAIFinancialAdviceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get contextAreas => $_getList(1);
}

/// AI Financial Advice Response
class GetAIFinancialAdviceResponse extends $pb.GeneratedMessage {
  factory GetAIFinancialAdviceResponse({
    $core.bool? success,
    $core.String? query,
    $core.String? advice,
    $core.Iterable<ActionStep>? actionSteps,
    $core.Iterable<$core.String>? relevantResources,
    $core.String? disclaimer,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (query != null) result.query = query;
    if (advice != null) result.advice = advice;
    if (actionSteps != null) result.actionSteps.addAll(actionSteps);
    if (relevantResources != null)
      result.relevantResources.addAll(relevantResources);
    if (disclaimer != null) result.disclaimer = disclaimer;
    return result;
  }

  GetAIFinancialAdviceResponse._();

  factory GetAIFinancialAdviceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAIFinancialAdviceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAIFinancialAdviceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..aOS(3, _omitFieldNames ? '' : 'advice')
    ..pc<ActionStep>(
        4, _omitFieldNames ? '' : 'actionSteps', $pb.PbFieldType.PM,
        subBuilder: ActionStep.create)
    ..pPS(5, _omitFieldNames ? '' : 'relevantResources')
    ..aOS(6, _omitFieldNames ? '' : 'disclaimer')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIFinancialAdviceResponse clone() =>
      GetAIFinancialAdviceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIFinancialAdviceResponse copyWith(
          void Function(GetAIFinancialAdviceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAIFinancialAdviceResponse))
          as GetAIFinancialAdviceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAIFinancialAdviceResponse create() =>
      GetAIFinancialAdviceResponse._();
  @$core.override
  GetAIFinancialAdviceResponse createEmptyInstance() => create();
  static $pb.PbList<GetAIFinancialAdviceResponse> createRepeated() =>
      $pb.PbList<GetAIFinancialAdviceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAIFinancialAdviceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAIFinancialAdviceResponse>(create);
  static GetAIFinancialAdviceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get advice => $_getSZ(2);
  @$pb.TagNumber(3)
  set advice($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAdvice() => $_has(2);
  @$pb.TagNumber(3)
  void clearAdvice() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<ActionStep> get actionSteps => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get relevantResources => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get disclaimer => $_getSZ(5);
  @$pb.TagNumber(6)
  set disclaimer($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDisclaimer() => $_has(5);
  @$pb.TagNumber(6)
  void clearDisclaimer() => $_clearField(6);
}

/// Action Step
class ActionStep extends $pb.GeneratedMessage {
  factory ActionStep({
    $core.int? stepNumber,
    $core.String? title,
    $core.String? description,
    $core.String? estimatedImpact,
    $core.bool? isCompleted,
  }) {
    final result = create();
    if (stepNumber != null) result.stepNumber = stepNumber;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (estimatedImpact != null) result.estimatedImpact = estimatedImpact;
    if (isCompleted != null) result.isCompleted = isCompleted;
    return result;
  }

  ActionStep._();

  factory ActionStep.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ActionStep.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ActionStep',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'stepNumber', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'estimatedImpact')
    ..aOB(5, _omitFieldNames ? '' : 'isCompleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActionStep clone() => ActionStep()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActionStep copyWith(void Function(ActionStep) updates) =>
      super.copyWith((message) => updates(message as ActionStep)) as ActionStep;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActionStep create() => ActionStep._();
  @$core.override
  ActionStep createEmptyInstance() => create();
  static $pb.PbList<ActionStep> createRepeated() => $pb.PbList<ActionStep>();
  @$core.pragma('dart2js:noInline')
  static ActionStep getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ActionStep>(create);
  static ActionStep? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get stepNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set stepNumber($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStepNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearStepNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get estimatedImpact => $_getSZ(3);
  @$pb.TagNumber(4)
  set estimatedImpact($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEstimatedImpact() => $_has(3);
  @$pb.TagNumber(4)
  void clearEstimatedImpact() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isCompleted => $_getBF(4);
  @$pb.TagNumber(5)
  set isCompleted($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsCompleted() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsCompleted() => $_clearField(5);
}

class IncomeSource extends $pb.GeneratedMessage {
  factory IncomeSource({
    $core.String? id,
    $core.String? userId,
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    IncomeCategory? category,
    $core.bool? isRecurring,
    $core.String? recurrencePattern,
    $1.Timestamp? lastReceived,
    $1.Timestamp? nextExpected,
    $core.bool? isActive,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (isRecurring != null) result.isRecurring = isRecurring;
    if (recurrencePattern != null) result.recurrencePattern = recurrencePattern;
    if (lastReceived != null) result.lastReceived = lastReceived;
    if (nextExpected != null) result.nextExpected = nextExpected;
    if (isActive != null) result.isActive = isActive;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  IncomeSource._();

  factory IncomeSource.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IncomeSource.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IncomeSource',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..e<IncomeCategory>(
        6, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: IncomeCategory.INCOME_CATEGORY_UNSPECIFIED,
        valueOf: IncomeCategory.valueOf,
        enumValues: IncomeCategory.values)
    ..aOB(7, _omitFieldNames ? '' : 'isRecurring')
    ..aOS(8, _omitFieldNames ? '' : 'recurrencePattern')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'lastReceived',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'nextExpected',
        subBuilder: $1.Timestamp.create)
    ..aOB(11, _omitFieldNames ? '' : 'isActive')
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncomeSource clone() => IncomeSource()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncomeSource copyWith(void Function(IncomeSource) updates) =>
      super.copyWith((message) => updates(message as IncomeSource))
          as IncomeSource;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IncomeSource create() => IncomeSource._();
  @$core.override
  IncomeSource createEmptyInstance() => create();
  static $pb.PbList<IncomeSource> createRepeated() =>
      $pb.PbList<IncomeSource>();
  @$core.pragma('dart2js:noInline')
  static IncomeSource getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IncomeSource>(create);
  static IncomeSource? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

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
  IncomeCategory get category => $_getN(5);
  @$pb.TagNumber(6)
  set category(IncomeCategory value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isRecurring => $_getBF(6);
  @$pb.TagNumber(7)
  set isRecurring($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsRecurring() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsRecurring() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get recurrencePattern => $_getSZ(7);
  @$pb.TagNumber(8)
  set recurrencePattern($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRecurrencePattern() => $_has(7);
  @$pb.TagNumber(8)
  void clearRecurrencePattern() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get lastReceived => $_getN(8);
  @$pb.TagNumber(9)
  set lastReceived($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasLastReceived() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastReceived() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureLastReceived() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get nextExpected => $_getN(9);
  @$pb.TagNumber(10)
  set nextExpected($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasNextExpected() => $_has(9);
  @$pb.TagNumber(10)
  void clearNextExpected() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureNextExpected() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.bool get isActive => $_getBF(10);
  @$pb.TagNumber(11)
  set isActive($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsActive() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsActive() => $_clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCreatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $1.Timestamp get updatedAt => $_getN(12);
  @$pb.TagNumber(13)
  set updatedAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureUpdatedAt() => $_ensure(12);
}

class IncomeBreakdown extends $pb.GeneratedMessage {
  factory IncomeBreakdown({
    $core.Iterable<IncomeCategoryData>? categories,
    $core.double? totalIncome,
    $core.String? period,
  }) {
    final result = create();
    if (categories != null) result.categories.addAll(categories);
    if (totalIncome != null) result.totalIncome = totalIncome;
    if (period != null) result.period = period;
    return result;
  }

  IncomeBreakdown._();

  factory IncomeBreakdown.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IncomeBreakdown.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IncomeBreakdown',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<IncomeCategoryData>(
        1, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM,
        subBuilder: IncomeCategoryData.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'period')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncomeBreakdown clone() => IncomeBreakdown()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncomeBreakdown copyWith(void Function(IncomeBreakdown) updates) =>
      super.copyWith((message) => updates(message as IncomeBreakdown))
          as IncomeBreakdown;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IncomeBreakdown create() => IncomeBreakdown._();
  @$core.override
  IncomeBreakdown createEmptyInstance() => create();
  static $pb.PbList<IncomeBreakdown> createRepeated() =>
      $pb.PbList<IncomeBreakdown>();
  @$core.pragma('dart2js:noInline')
  static IncomeBreakdown getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IncomeBreakdown>(create);
  static IncomeBreakdown? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<IncomeCategoryData> get categories => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalIncome => $_getN(1);
  @$pb.TagNumber(2)
  set totalIncome($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalIncome() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get period => $_getSZ(2);
  @$pb.TagNumber(3)
  set period($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPeriod() => $_has(2);
  @$pb.TagNumber(3)
  void clearPeriod() => $_clearField(3);
}

class IncomeCategoryData extends $pb.GeneratedMessage {
  factory IncomeCategoryData({
    IncomeCategory? category,
    $core.String? categoryName,
    $core.double? amount,
    $core.double? percentage,
    $core.int? sourceCount,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (categoryName != null) result.categoryName = categoryName;
    if (amount != null) result.amount = amount;
    if (percentage != null) result.percentage = percentage;
    if (sourceCount != null) result.sourceCount = sourceCount;
    return result;
  }

  IncomeCategoryData._();

  factory IncomeCategoryData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IncomeCategoryData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IncomeCategoryData',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<IncomeCategory>(
        1, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: IncomeCategory.INCOME_CATEGORY_UNSPECIFIED,
        valueOf: IncomeCategory.valueOf,
        enumValues: IncomeCategory.values)
    ..aOS(2, _omitFieldNames ? '' : 'categoryName')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.OD)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'sourceCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncomeCategoryData clone() => IncomeCategoryData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncomeCategoryData copyWith(void Function(IncomeCategoryData) updates) =>
      super.copyWith((message) => updates(message as IncomeCategoryData))
          as IncomeCategoryData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IncomeCategoryData create() => IncomeCategoryData._();
  @$core.override
  IncomeCategoryData createEmptyInstance() => create();
  static $pb.PbList<IncomeCategoryData> createRepeated() =>
      $pb.PbList<IncomeCategoryData>();
  @$core.pragma('dart2js:noInline')
  static IncomeCategoryData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IncomeCategoryData>(create);
  static IncomeCategoryData? _defaultInstance;

  @$pb.TagNumber(1)
  IncomeCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(IncomeCategory value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get categoryName => $_getSZ(1);
  @$pb.TagNumber(2)
  set categoryName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategoryName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategoryName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get percentage => $_getN(3);
  @$pb.TagNumber(4)
  set percentage($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPercentage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get sourceCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set sourceCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSourceCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceCount() => $_clearField(5);
}

class Investment extends $pb.GeneratedMessage {
  factory Investment({
    $core.String? id,
    $core.String? userId,
    $core.String? name,
    InvestmentType? investmentType,
    $core.double? currentValue,
    $core.double? initialInvestment,
    $core.double? gainLoss,
    $core.double? gainLossPercentage,
    $core.String? currency,
    $1.Timestamp? purchaseDate,
    $1.Timestamp? lastUpdated,
    $core.String? tickerSymbol,
    $core.int? quantity,
    $core.double? currentPrice,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (investmentType != null) result.investmentType = investmentType;
    if (currentValue != null) result.currentValue = currentValue;
    if (initialInvestment != null) result.initialInvestment = initialInvestment;
    if (gainLoss != null) result.gainLoss = gainLoss;
    if (gainLossPercentage != null)
      result.gainLossPercentage = gainLossPercentage;
    if (currency != null) result.currency = currency;
    if (purchaseDate != null) result.purchaseDate = purchaseDate;
    if (lastUpdated != null) result.lastUpdated = lastUpdated;
    if (tickerSymbol != null) result.tickerSymbol = tickerSymbol;
    if (quantity != null) result.quantity = quantity;
    if (currentPrice != null) result.currentPrice = currentPrice;
    return result;
  }

  Investment._();

  factory Investment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Investment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Investment',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..e<InvestmentType>(
        4, _omitFieldNames ? '' : 'investmentType', $pb.PbFieldType.OE,
        defaultOrMaker: InvestmentType.INVESTMENT_TYPE_UNSPECIFIED,
        valueOf: InvestmentType.valueOf,
        enumValues: InvestmentType.values)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'currentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'initialInvestment', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'gainLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'gainLossPercentage', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'purchaseDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'lastUpdated',
        subBuilder: $1.Timestamp.create)
    ..aOS(12, _omitFieldNames ? '' : 'tickerSymbol')
    ..a<$core.int>(13, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..a<$core.double>(
        14, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Investment clone() => Investment()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Investment copyWith(void Function(Investment) updates) =>
      super.copyWith((message) => updates(message as Investment)) as Investment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Investment create() => Investment._();
  @$core.override
  Investment createEmptyInstance() => create();
  static $pb.PbList<Investment> createRepeated() => $pb.PbList<Investment>();
  @$core.pragma('dart2js:noInline')
  static Investment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Investment>(create);
  static Investment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  InvestmentType get investmentType => $_getN(3);
  @$pb.TagNumber(4)
  set investmentType(InvestmentType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasInvestmentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearInvestmentType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentValue => $_getN(4);
  @$pb.TagNumber(5)
  set currentValue($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrentValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentValue() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get initialInvestment => $_getN(5);
  @$pb.TagNumber(6)
  set initialInvestment($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasInitialInvestment() => $_has(5);
  @$pb.TagNumber(6)
  void clearInitialInvestment() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get gainLoss => $_getN(6);
  @$pb.TagNumber(7)
  set gainLoss($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasGainLoss() => $_has(6);
  @$pb.TagNumber(7)
  void clearGainLoss() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get gainLossPercentage => $_getN(7);
  @$pb.TagNumber(8)
  set gainLossPercentage($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasGainLossPercentage() => $_has(7);
  @$pb.TagNumber(8)
  void clearGainLossPercentage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get purchaseDate => $_getN(9);
  @$pb.TagNumber(10)
  set purchaseDate($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasPurchaseDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearPurchaseDate() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensurePurchaseDate() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get lastUpdated => $_getN(10);
  @$pb.TagNumber(11)
  set lastUpdated($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasLastUpdated() => $_has(10);
  @$pb.TagNumber(11)
  void clearLastUpdated() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureLastUpdated() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get tickerSymbol => $_getSZ(11);
  @$pb.TagNumber(12)
  set tickerSymbol($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTickerSymbol() => $_has(11);
  @$pb.TagNumber(12)
  void clearTickerSymbol() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get quantity => $_getIZ(12);
  @$pb.TagNumber(13)
  set quantity($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasQuantity() => $_has(12);
  @$pb.TagNumber(13)
  void clearQuantity() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.double get currentPrice => $_getN(13);
  @$pb.TagNumber(14)
  set currentPrice($core.double value) => $_setDouble(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCurrentPrice() => $_has(13);
  @$pb.TagNumber(14)
  void clearCurrentPrice() => $_clearField(14);
}

class InvestmentPortfolio extends $pb.GeneratedMessage {
  factory InvestmentPortfolio({
    $core.Iterable<InvestmentTypeData>? investments,
    $core.double? totalValue,
    $core.double? totalInvested,
    $core.double? totalGainLoss,
    $core.double? totalGainLossPercentage,
  }) {
    final result = create();
    if (investments != null) result.investments.addAll(investments);
    if (totalValue != null) result.totalValue = totalValue;
    if (totalInvested != null) result.totalInvested = totalInvested;
    if (totalGainLoss != null) result.totalGainLoss = totalGainLoss;
    if (totalGainLossPercentage != null)
      result.totalGainLossPercentage = totalGainLossPercentage;
    return result;
  }

  InvestmentPortfolio._();

  factory InvestmentPortfolio.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvestmentPortfolio.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InvestmentPortfolio',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InvestmentTypeData>(
        1, _omitFieldNames ? '' : 'investments', $pb.PbFieldType.PM,
        subBuilder: InvestmentTypeData.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalGainLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalGainLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvestmentPortfolio clone() => InvestmentPortfolio()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvestmentPortfolio copyWith(void Function(InvestmentPortfolio) updates) =>
      super.copyWith((message) => updates(message as InvestmentPortfolio))
          as InvestmentPortfolio;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvestmentPortfolio create() => InvestmentPortfolio._();
  @$core.override
  InvestmentPortfolio createEmptyInstance() => create();
  static $pb.PbList<InvestmentPortfolio> createRepeated() =>
      $pb.PbList<InvestmentPortfolio>();
  @$core.pragma('dart2js:noInline')
  static InvestmentPortfolio getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvestmentPortfolio>(create);
  static InvestmentPortfolio? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InvestmentTypeData> get investments => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalValue => $_getN(1);
  @$pb.TagNumber(2)
  set totalValue($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalInvested => $_getN(2);
  @$pb.TagNumber(3)
  set totalInvested($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalInvested() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalInvested() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalGainLoss => $_getN(3);
  @$pb.TagNumber(4)
  set totalGainLoss($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalGainLoss() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalGainLoss() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalGainLossPercentage => $_getN(4);
  @$pb.TagNumber(5)
  set totalGainLossPercentage($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalGainLossPercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalGainLossPercentage() => $_clearField(5);
}

class InvestmentTypeData extends $pb.GeneratedMessage {
  factory InvestmentTypeData({
    InvestmentType? investmentType,
    $core.String? typeName,
    $core.double? currentValue,
    $core.double? gainLoss,
    $core.double? gainLossPercentage,
    $core.int? assetCount,
  }) {
    final result = create();
    if (investmentType != null) result.investmentType = investmentType;
    if (typeName != null) result.typeName = typeName;
    if (currentValue != null) result.currentValue = currentValue;
    if (gainLoss != null) result.gainLoss = gainLoss;
    if (gainLossPercentage != null)
      result.gainLossPercentage = gainLossPercentage;
    if (assetCount != null) result.assetCount = assetCount;
    return result;
  }

  InvestmentTypeData._();

  factory InvestmentTypeData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvestmentTypeData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InvestmentTypeData',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<InvestmentType>(
        1, _omitFieldNames ? '' : 'investmentType', $pb.PbFieldType.OE,
        defaultOrMaker: InvestmentType.INVESTMENT_TYPE_UNSPECIFIED,
        valueOf: InvestmentType.valueOf,
        enumValues: InvestmentType.values)
    ..aOS(2, _omitFieldNames ? '' : 'typeName')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'currentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'gainLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'gainLossPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'assetCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvestmentTypeData clone() => InvestmentTypeData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvestmentTypeData copyWith(void Function(InvestmentTypeData) updates) =>
      super.copyWith((message) => updates(message as InvestmentTypeData))
          as InvestmentTypeData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvestmentTypeData create() => InvestmentTypeData._();
  @$core.override
  InvestmentTypeData createEmptyInstance() => create();
  static $pb.PbList<InvestmentTypeData> createRepeated() =>
      $pb.PbList<InvestmentTypeData>();
  @$core.pragma('dart2js:noInline')
  static InvestmentTypeData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvestmentTypeData>(create);
  static InvestmentTypeData? _defaultInstance;

  @$pb.TagNumber(1)
  InvestmentType get investmentType => $_getN(0);
  @$pb.TagNumber(1)
  set investmentType(InvestmentType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestmentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get typeName => $_getSZ(1);
  @$pb.TagNumber(2)
  set typeName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTypeName() => $_has(1);
  @$pb.TagNumber(2)
  void clearTypeName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get currentValue => $_getN(2);
  @$pb.TagNumber(3)
  set currentValue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get gainLoss => $_getN(3);
  @$pb.TagNumber(4)
  set gainLoss($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasGainLoss() => $_has(3);
  @$pb.TagNumber(4)
  void clearGainLoss() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get gainLossPercentage => $_getN(4);
  @$pb.TagNumber(5)
  set gainLossPercentage($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGainLossPercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearGainLossPercentage() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get assetCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set assetCount($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAssetCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAssetCount() => $_clearField(6);
}

class FinancialGoal extends $pb.GeneratedMessage {
  factory FinancialGoal({
    $core.String? id,
    $core.String? userId,
    $core.String? name,
    GoalType? goalType,
    $core.double? targetAmount,
    $core.double? currentAmount,
    $core.double? monthlyContribution,
    $core.String? currency,
    $1.Timestamp? targetDate,
    GoalStatus? status,
    $core.double? percentageComplete,
    $core.int? monthsRemaining,
    $core.String? icon,
    $core.String? color,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (goalType != null) result.goalType = goalType;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (monthlyContribution != null)
      result.monthlyContribution = monthlyContribution;
    if (currency != null) result.currency = currency;
    if (targetDate != null) result.targetDate = targetDate;
    if (status != null) result.status = status;
    if (percentageComplete != null)
      result.percentageComplete = percentageComplete;
    if (monthsRemaining != null) result.monthsRemaining = monthsRemaining;
    if (icon != null) result.icon = icon;
    if (color != null) result.color = color;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  FinancialGoal._();

  factory FinancialGoal.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FinancialGoal.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FinancialGoal',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..e<GoalType>(4, _omitFieldNames ? '' : 'goalType', $pb.PbFieldType.OE,
        defaultOrMaker: GoalType.GOAL_TYPE_UNSPECIFIED,
        valueOf: GoalType.valueOf,
        enumValues: GoalType.values)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'monthlyContribution', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'targetDate',
        subBuilder: $1.Timestamp.create)
    ..e<GoalStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: GoalStatus.GOAL_STATUS_UNSPECIFIED,
        valueOf: GoalStatus.valueOf,
        enumValues: GoalStatus.values)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'percentageComplete', $pb.PbFieldType.OD)
    ..a<$core.int>(
        12, _omitFieldNames ? '' : 'monthsRemaining', $pb.PbFieldType.O3)
    ..aOS(13, _omitFieldNames ? '' : 'icon')
    ..aOS(14, _omitFieldNames ? '' : 'color')
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinancialGoal clone() => FinancialGoal()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinancialGoal copyWith(void Function(FinancialGoal) updates) =>
      super.copyWith((message) => updates(message as FinancialGoal))
          as FinancialGoal;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinancialGoal create() => FinancialGoal._();
  @$core.override
  FinancialGoal createEmptyInstance() => create();
  static $pb.PbList<FinancialGoal> createRepeated() =>
      $pb.PbList<FinancialGoal>();
  @$core.pragma('dart2js:noInline')
  static FinancialGoal getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FinancialGoal>(create);
  static FinancialGoal? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  GoalType get goalType => $_getN(3);
  @$pb.TagNumber(4)
  set goalType(GoalType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasGoalType() => $_has(3);
  @$pb.TagNumber(4)
  void clearGoalType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get targetAmount => $_getN(4);
  @$pb.TagNumber(5)
  set targetAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get currentAmount => $_getN(5);
  @$pb.TagNumber(6)
  set currentAmount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrentAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get monthlyContribution => $_getN(6);
  @$pb.TagNumber(7)
  set monthlyContribution($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMonthlyContribution() => $_has(6);
  @$pb.TagNumber(7)
  void clearMonthlyContribution() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get targetDate => $_getN(8);
  @$pb.TagNumber(9)
  set targetDate($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasTargetDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearTargetDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureTargetDate() => $_ensure(8);

  @$pb.TagNumber(10)
  GoalStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(GoalStatus value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get percentageComplete => $_getN(10);
  @$pb.TagNumber(11)
  set percentageComplete($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPercentageComplete() => $_has(10);
  @$pb.TagNumber(11)
  void clearPercentageComplete() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get monthsRemaining => $_getIZ(11);
  @$pb.TagNumber(12)
  set monthsRemaining($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMonthsRemaining() => $_has(11);
  @$pb.TagNumber(12)
  void clearMonthsRemaining() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get icon => $_getSZ(12);
  @$pb.TagNumber(13)
  set icon($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIcon() => $_has(12);
  @$pb.TagNumber(13)
  void clearIcon() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get color => $_getSZ(13);
  @$pb.TagNumber(14)
  set color($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasColor() => $_has(13);
  @$pb.TagNumber(14)
  void clearColor() => $_clearField(14);

  @$pb.TagNumber(15)
  $1.Timestamp get createdAt => $_getN(14);
  @$pb.TagNumber(15)
  set createdAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureCreatedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $1.Timestamp get updatedAt => $_getN(15);
  @$pb.TagNumber(16)
  set updatedAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearUpdatedAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureUpdatedAt() => $_ensure(15);
}

class FinancialGoalsList extends $pb.GeneratedMessage {
  factory FinancialGoalsList({
    $core.Iterable<FinancialGoal>? goals,
    $core.double? totalTarget,
    $core.double? totalSaved,
    $core.int? activeGoalsCount,
  }) {
    final result = create();
    if (goals != null) result.goals.addAll(goals);
    if (totalTarget != null) result.totalTarget = totalTarget;
    if (totalSaved != null) result.totalSaved = totalSaved;
    if (activeGoalsCount != null) result.activeGoalsCount = activeGoalsCount;
    return result;
  }

  FinancialGoalsList._();

  factory FinancialGoalsList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FinancialGoalsList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FinancialGoalsList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<FinancialGoal>(1, _omitFieldNames ? '' : 'goals', $pb.PbFieldType.PM,
        subBuilder: FinancialGoal.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalTarget', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalSaved', $pb.PbFieldType.OD)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'activeGoalsCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinancialGoalsList clone() => FinancialGoalsList()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinancialGoalsList copyWith(void Function(FinancialGoalsList) updates) =>
      super.copyWith((message) => updates(message as FinancialGoalsList))
          as FinancialGoalsList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinancialGoalsList create() => FinancialGoalsList._();
  @$core.override
  FinancialGoalsList createEmptyInstance() => create();
  static $pb.PbList<FinancialGoalsList> createRepeated() =>
      $pb.PbList<FinancialGoalsList>();
  @$core.pragma('dart2js:noInline')
  static FinancialGoalsList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FinancialGoalsList>(create);
  static FinancialGoalsList? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FinancialGoal> get goals => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalTarget => $_getN(1);
  @$pb.TagNumber(2)
  set totalTarget($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalTarget() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalTarget() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalSaved => $_getN(2);
  @$pb.TagNumber(3)
  set totalSaved($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalSaved() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSaved() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get activeGoalsCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set activeGoalsCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasActiveGoalsCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearActiveGoalsCount() => $_clearField(4);
}

/// Savings Goal (Primary/Main savings target)
class SavingsGoal extends $pb.GeneratedMessage {
  factory SavingsGoal({
    $core.String? id,
    $core.String? userId,
    $core.String? name,
    $core.double? targetAmount,
    $core.double? currentAmount,
    $core.double? percentageComplete,
    $1.Timestamp? targetDate,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (percentageComplete != null)
      result.percentageComplete = percentageComplete;
    if (targetDate != null) result.targetDate = targetDate;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  SavingsGoal._();

  factory SavingsGoal.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SavingsGoal.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SavingsGoal',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'percentageComplete', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'targetDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SavingsGoal clone() => SavingsGoal()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SavingsGoal copyWith(void Function(SavingsGoal) updates) =>
      super.copyWith((message) => updates(message as SavingsGoal))
          as SavingsGoal;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SavingsGoal create() => SavingsGoal._();
  @$core.override
  SavingsGoal createEmptyInstance() => create();
  static $pb.PbList<SavingsGoal> createRepeated() => $pb.PbList<SavingsGoal>();
  @$core.pragma('dart2js:noInline')
  static SavingsGoal getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SavingsGoal>(create);
  static SavingsGoal? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get targetAmount => $_getN(3);
  @$pb.TagNumber(4)
  set targetAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentAmount => $_getN(4);
  @$pb.TagNumber(5)
  set currentAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrentAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get percentageComplete => $_getN(5);
  @$pb.TagNumber(6)
  set percentageComplete($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPercentageComplete() => $_has(5);
  @$pb.TagNumber(6)
  void clearPercentageComplete() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get targetDate => $_getN(6);
  @$pb.TagNumber(7)
  set targetDate($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTargetDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetDate() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureTargetDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get updatedAt => $_getN(8);
  @$pb.TagNumber(9)
  set updatedAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureUpdatedAt() => $_ensure(8);
}

class RecurringBill extends $pb.GeneratedMessage {
  factory RecurringBill({
    $core.String? id,
    $core.String? userId,
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    $core.String? recurrencePattern,
    $1.Timestamp? nextDueDate,
    $1.Timestamp? lastPaidDate,
    BillStatus? status,
    $core.int? daysUntilDue,
    $core.String? merchant,
    $core.String? icon,
    $core.bool? autoPayEnabled,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (recurrencePattern != null) result.recurrencePattern = recurrencePattern;
    if (nextDueDate != null) result.nextDueDate = nextDueDate;
    if (lastPaidDate != null) result.lastPaidDate = lastPaidDate;
    if (status != null) result.status = status;
    if (daysUntilDue != null) result.daysUntilDue = daysUntilDue;
    if (merchant != null) result.merchant = merchant;
    if (icon != null) result.icon = icon;
    if (autoPayEnabled != null) result.autoPayEnabled = autoPayEnabled;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  RecurringBill._();

  factory RecurringBill.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecurringBill.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecurringBill',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..e<ExpenseCategory>(
        6, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..aOS(7, _omitFieldNames ? '' : 'recurrencePattern')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'nextDueDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'lastPaidDate',
        subBuilder: $1.Timestamp.create)
    ..e<BillStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: BillStatus.BILL_STATUS_UNSPECIFIED,
        valueOf: BillStatus.valueOf,
        enumValues: BillStatus.values)
    ..a<$core.int>(
        11, _omitFieldNames ? '' : 'daysUntilDue', $pb.PbFieldType.O3)
    ..aOS(12, _omitFieldNames ? '' : 'merchant')
    ..aOS(13, _omitFieldNames ? '' : 'icon')
    ..aOB(14, _omitFieldNames ? '' : 'autoPayEnabled')
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringBill clone() => RecurringBill()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringBill copyWith(void Function(RecurringBill) updates) =>
      super.copyWith((message) => updates(message as RecurringBill))
          as RecurringBill;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecurringBill create() => RecurringBill._();
  @$core.override
  RecurringBill createEmptyInstance() => create();
  static $pb.PbList<RecurringBill> createRepeated() =>
      $pb.PbList<RecurringBill>();
  @$core.pragma('dart2js:noInline')
  static RecurringBill getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecurringBill>(create);
  static RecurringBill? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

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
  ExpenseCategory get category => $_getN(5);
  @$pb.TagNumber(6)
  set category(ExpenseCategory value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get recurrencePattern => $_getSZ(6);
  @$pb.TagNumber(7)
  set recurrencePattern($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRecurrencePattern() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecurrencePattern() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get nextDueDate => $_getN(7);
  @$pb.TagNumber(8)
  set nextDueDate($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasNextDueDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearNextDueDate() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureNextDueDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get lastPaidDate => $_getN(8);
  @$pb.TagNumber(9)
  set lastPaidDate($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasLastPaidDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastPaidDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureLastPaidDate() => $_ensure(8);

  @$pb.TagNumber(10)
  BillStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(BillStatus value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get daysUntilDue => $_getIZ(10);
  @$pb.TagNumber(11)
  set daysUntilDue($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDaysUntilDue() => $_has(10);
  @$pb.TagNumber(11)
  void clearDaysUntilDue() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get merchant => $_getSZ(11);
  @$pb.TagNumber(12)
  set merchant($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMerchant() => $_has(11);
  @$pb.TagNumber(12)
  void clearMerchant() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get icon => $_getSZ(12);
  @$pb.TagNumber(13)
  set icon($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIcon() => $_has(12);
  @$pb.TagNumber(13)
  void clearIcon() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get autoPayEnabled => $_getBF(13);
  @$pb.TagNumber(14)
  set autoPayEnabled($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasAutoPayEnabled() => $_has(13);
  @$pb.TagNumber(14)
  void clearAutoPayEnabled() => $_clearField(14);

  @$pb.TagNumber(15)
  $1.Timestamp get createdAt => $_getN(14);
  @$pb.TagNumber(15)
  set createdAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureCreatedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $1.Timestamp get updatedAt => $_getN(15);
  @$pb.TagNumber(16)
  set updatedAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearUpdatedAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureUpdatedAt() => $_ensure(15);
}

class UpcomingBillsList extends $pb.GeneratedMessage {
  factory UpcomingBillsList({
    $core.Iterable<RecurringBill>? bills,
    $core.double? totalUpcoming,
    $core.int? billsCount,
  }) {
    final result = create();
    if (bills != null) result.bills.addAll(bills);
    if (totalUpcoming != null) result.totalUpcoming = totalUpcoming;
    if (billsCount != null) result.billsCount = billsCount;
    return result;
  }

  UpcomingBillsList._();

  factory UpcomingBillsList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpcomingBillsList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpcomingBillsList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<RecurringBill>(1, _omitFieldNames ? '' : 'bills', $pb.PbFieldType.PM,
        subBuilder: RecurringBill.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalUpcoming', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'billsCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpcomingBillsList clone() => UpcomingBillsList()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpcomingBillsList copyWith(void Function(UpcomingBillsList) updates) =>
      super.copyWith((message) => updates(message as UpcomingBillsList))
          as UpcomingBillsList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpcomingBillsList create() => UpcomingBillsList._();
  @$core.override
  UpcomingBillsList createEmptyInstance() => create();
  static $pb.PbList<UpcomingBillsList> createRepeated() =>
      $pb.PbList<UpcomingBillsList>();
  @$core.pragma('dart2js:noInline')
  static UpcomingBillsList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpcomingBillsList>(create);
  static UpcomingBillsList? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RecurringBill> get bills => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalUpcoming => $_getN(1);
  @$pb.TagNumber(2)
  set totalUpcoming($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalUpcoming() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalUpcoming() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get billsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set billsCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBillsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearBillsCount() => $_clearField(3);
}

/// Add to StatisticsService:
/// Income Management
class CreateIncomeSourceRequest extends $pb.GeneratedMessage {
  factory CreateIncomeSourceRequest({
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    IncomeCategory? category,
    $core.bool? isRecurring,
    $core.String? recurrencePattern,
    $1.Timestamp? lastReceived,
    $1.Timestamp? nextExpected,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (isRecurring != null) result.isRecurring = isRecurring;
    if (recurrencePattern != null) result.recurrencePattern = recurrencePattern;
    if (lastReceived != null) result.lastReceived = lastReceived;
    if (nextExpected != null) result.nextExpected = nextExpected;
    return result;
  }

  CreateIncomeSourceRequest._();

  factory CreateIncomeSourceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateIncomeSourceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateIncomeSourceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..e<IncomeCategory>(
        4, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: IncomeCategory.INCOME_CATEGORY_UNSPECIFIED,
        valueOf: IncomeCategory.valueOf,
        enumValues: IncomeCategory.values)
    ..aOB(5, _omitFieldNames ? '' : 'isRecurring')
    ..aOS(6, _omitFieldNames ? '' : 'recurrencePattern')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'lastReceived',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'nextExpected',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateIncomeSourceRequest clone() =>
      CreateIncomeSourceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateIncomeSourceRequest copyWith(
          void Function(CreateIncomeSourceRequest) updates) =>
      super.copyWith((message) => updates(message as CreateIncomeSourceRequest))
          as CreateIncomeSourceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateIncomeSourceRequest create() => CreateIncomeSourceRequest._();
  @$core.override
  CreateIncomeSourceRequest createEmptyInstance() => create();
  static $pb.PbList<CreateIncomeSourceRequest> createRepeated() =>
      $pb.PbList<CreateIncomeSourceRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateIncomeSourceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateIncomeSourceRequest>(create);
  static CreateIncomeSourceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

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
  IncomeCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(IncomeCategory value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isRecurring => $_getBF(4);
  @$pb.TagNumber(5)
  set isRecurring($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsRecurring() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsRecurring() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get recurrencePattern => $_getSZ(5);
  @$pb.TagNumber(6)
  set recurrencePattern($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRecurrencePattern() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecurrencePattern() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get lastReceived => $_getN(6);
  @$pb.TagNumber(7)
  set lastReceived($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasLastReceived() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastReceived() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureLastReceived() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get nextExpected => $_getN(7);
  @$pb.TagNumber(8)
  set nextExpected($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasNextExpected() => $_has(7);
  @$pb.TagNumber(8)
  void clearNextExpected() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureNextExpected() => $_ensure(7);
}

class CreateIncomeSourceResponse extends $pb.GeneratedMessage {
  factory CreateIncomeSourceResponse({
    IncomeSource? incomeSource,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (incomeSource != null) result.incomeSource = incomeSource;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  CreateIncomeSourceResponse._();

  factory CreateIncomeSourceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateIncomeSourceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateIncomeSourceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<IncomeSource>(1, _omitFieldNames ? '' : 'incomeSource',
        subBuilder: IncomeSource.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateIncomeSourceResponse clone() =>
      CreateIncomeSourceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateIncomeSourceResponse copyWith(
          void Function(CreateIncomeSourceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateIncomeSourceResponse))
          as CreateIncomeSourceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateIncomeSourceResponse create() => CreateIncomeSourceResponse._();
  @$core.override
  CreateIncomeSourceResponse createEmptyInstance() => create();
  static $pb.PbList<CreateIncomeSourceResponse> createRepeated() =>
      $pb.PbList<CreateIncomeSourceResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateIncomeSourceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateIncomeSourceResponse>(create);
  static CreateIncomeSourceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IncomeSource get incomeSource => $_getN(0);
  @$pb.TagNumber(1)
  set incomeSource(IncomeSource value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasIncomeSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncomeSource() => $_clearField(1);
  @$pb.TagNumber(1)
  IncomeSource ensureIncomeSource() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class GetIncomeSourcesRequest extends $pb.GeneratedMessage {
  factory GetIncomeSourcesRequest({
    $core.bool? activeOnly,
  }) {
    final result = create();
    if (activeOnly != null) result.activeOnly = activeOnly;
    return result;
  }

  GetIncomeSourcesRequest._();

  factory GetIncomeSourcesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIncomeSourcesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIncomeSourcesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'activeOnly')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeSourcesRequest clone() =>
      GetIncomeSourcesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeSourcesRequest copyWith(
          void Function(GetIncomeSourcesRequest) updates) =>
      super.copyWith((message) => updates(message as GetIncomeSourcesRequest))
          as GetIncomeSourcesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomeSourcesRequest create() => GetIncomeSourcesRequest._();
  @$core.override
  GetIncomeSourcesRequest createEmptyInstance() => create();
  static $pb.PbList<GetIncomeSourcesRequest> createRepeated() =>
      $pb.PbList<GetIncomeSourcesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeSourcesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIncomeSourcesRequest>(create);
  static GetIncomeSourcesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get activeOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set activeOnly($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasActiveOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearActiveOnly() => $_clearField(1);
}

class GetIncomeSourcesResponse extends $pb.GeneratedMessage {
  factory GetIncomeSourcesResponse({
    $core.Iterable<IncomeSource>? incomeSources,
    $core.double? totalMonthlyIncome,
  }) {
    final result = create();
    if (incomeSources != null) result.incomeSources.addAll(incomeSources);
    if (totalMonthlyIncome != null)
      result.totalMonthlyIncome = totalMonthlyIncome;
    return result;
  }

  GetIncomeSourcesResponse._();

  factory GetIncomeSourcesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIncomeSourcesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIncomeSourcesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<IncomeSource>(
        1, _omitFieldNames ? '' : 'incomeSources', $pb.PbFieldType.PM,
        subBuilder: IncomeSource.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalMonthlyIncome', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeSourcesResponse clone() =>
      GetIncomeSourcesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeSourcesResponse copyWith(
          void Function(GetIncomeSourcesResponse) updates) =>
      super.copyWith((message) => updates(message as GetIncomeSourcesResponse))
          as GetIncomeSourcesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomeSourcesResponse create() => GetIncomeSourcesResponse._();
  @$core.override
  GetIncomeSourcesResponse createEmptyInstance() => create();
  static $pb.PbList<GetIncomeSourcesResponse> createRepeated() =>
      $pb.PbList<GetIncomeSourcesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeSourcesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIncomeSourcesResponse>(create);
  static GetIncomeSourcesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<IncomeSource> get incomeSources => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalMonthlyIncome => $_getN(1);
  @$pb.TagNumber(2)
  set totalMonthlyIncome($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalMonthlyIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalMonthlyIncome() => $_clearField(2);
}

class GetIncomeBreakdownRequest extends $pb.GeneratedMessage {
  factory GetIncomeBreakdownRequest({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetIncomeBreakdownRequest._();

  factory GetIncomeBreakdownRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIncomeBreakdownRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIncomeBreakdownRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeBreakdownRequest clone() =>
      GetIncomeBreakdownRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeBreakdownRequest copyWith(
          void Function(GetIncomeBreakdownRequest) updates) =>
      super.copyWith((message) => updates(message as GetIncomeBreakdownRequest))
          as GetIncomeBreakdownRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomeBreakdownRequest create() => GetIncomeBreakdownRequest._();
  @$core.override
  GetIncomeBreakdownRequest createEmptyInstance() => create();
  static $pb.PbList<GetIncomeBreakdownRequest> createRepeated() =>
      $pb.PbList<GetIncomeBreakdownRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeBreakdownRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIncomeBreakdownRequest>(create);
  static GetIncomeBreakdownRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);
}

class GetIncomeBreakdownResponse extends $pb.GeneratedMessage {
  factory GetIncomeBreakdownResponse({
    IncomeBreakdown? breakdown,
  }) {
    final result = create();
    if (breakdown != null) result.breakdown = breakdown;
    return result;
  }

  GetIncomeBreakdownResponse._();

  factory GetIncomeBreakdownResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIncomeBreakdownResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIncomeBreakdownResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<IncomeBreakdown>(1, _omitFieldNames ? '' : 'breakdown',
        subBuilder: IncomeBreakdown.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeBreakdownResponse clone() =>
      GetIncomeBreakdownResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeBreakdownResponse copyWith(
          void Function(GetIncomeBreakdownResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetIncomeBreakdownResponse))
          as GetIncomeBreakdownResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomeBreakdownResponse create() => GetIncomeBreakdownResponse._();
  @$core.override
  GetIncomeBreakdownResponse createEmptyInstance() => create();
  static $pb.PbList<GetIncomeBreakdownResponse> createRepeated() =>
      $pb.PbList<GetIncomeBreakdownResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeBreakdownResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIncomeBreakdownResponse>(create);
  static GetIncomeBreakdownResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IncomeBreakdown get breakdown => $_getN(0);
  @$pb.TagNumber(1)
  set breakdown(IncomeBreakdown value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBreakdown() => $_has(0);
  @$pb.TagNumber(1)
  void clearBreakdown() => $_clearField(1);
  @$pb.TagNumber(1)
  IncomeBreakdown ensureBreakdown() => $_ensure(0);
}

/// Investment Management
class GetInvestmentPortfolioRequest extends $pb.GeneratedMessage {
  factory GetInvestmentPortfolioRequest() => create();

  GetInvestmentPortfolioRequest._();

  factory GetInvestmentPortfolioRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInvestmentPortfolioRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInvestmentPortfolioRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentPortfolioRequest clone() =>
      GetInvestmentPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentPortfolioRequest copyWith(
          void Function(GetInvestmentPortfolioRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInvestmentPortfolioRequest))
          as GetInvestmentPortfolioRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentPortfolioRequest create() =>
      GetInvestmentPortfolioRequest._();
  @$core.override
  GetInvestmentPortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentPortfolioRequest> createRepeated() =>
      $pb.PbList<GetInvestmentPortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentPortfolioRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInvestmentPortfolioRequest>(create);
  static GetInvestmentPortfolioRequest? _defaultInstance;
}

class GetInvestmentPortfolioResponse extends $pb.GeneratedMessage {
  factory GetInvestmentPortfolioResponse({
    InvestmentPortfolio? portfolio,
    $core.Iterable<Investment>? individualInvestments,
  }) {
    final result = create();
    if (portfolio != null) result.portfolio = portfolio;
    if (individualInvestments != null)
      result.individualInvestments.addAll(individualInvestments);
    return result;
  }

  GetInvestmentPortfolioResponse._();

  factory GetInvestmentPortfolioResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInvestmentPortfolioResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInvestmentPortfolioResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InvestmentPortfolio>(1, _omitFieldNames ? '' : 'portfolio',
        subBuilder: InvestmentPortfolio.create)
    ..pc<Investment>(
        2, _omitFieldNames ? '' : 'individualInvestments', $pb.PbFieldType.PM,
        subBuilder: Investment.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentPortfolioResponse clone() =>
      GetInvestmentPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentPortfolioResponse copyWith(
          void Function(GetInvestmentPortfolioResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInvestmentPortfolioResponse))
          as GetInvestmentPortfolioResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentPortfolioResponse create() =>
      GetInvestmentPortfolioResponse._();
  @$core.override
  GetInvestmentPortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentPortfolioResponse> createRepeated() =>
      $pb.PbList<GetInvestmentPortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentPortfolioResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInvestmentPortfolioResponse>(create);
  static GetInvestmentPortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InvestmentPortfolio get portfolio => $_getN(0);
  @$pb.TagNumber(1)
  set portfolio(InvestmentPortfolio value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPortfolio() => $_has(0);
  @$pb.TagNumber(1)
  void clearPortfolio() => $_clearField(1);
  @$pb.TagNumber(1)
  InvestmentPortfolio ensurePortfolio() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<Investment> get individualInvestments => $_getList(1);
}

class CreateInvestmentRequest extends $pb.GeneratedMessage {
  factory CreateInvestmentRequest({
    $core.String? name,
    InvestmentType? investmentType,
    $core.double? initialInvestment,
    $core.String? currency,
    $1.Timestamp? purchaseDate,
    $core.String? tickerSymbol,
    $core.int? quantity,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (investmentType != null) result.investmentType = investmentType;
    if (initialInvestment != null) result.initialInvestment = initialInvestment;
    if (currency != null) result.currency = currency;
    if (purchaseDate != null) result.purchaseDate = purchaseDate;
    if (tickerSymbol != null) result.tickerSymbol = tickerSymbol;
    if (quantity != null) result.quantity = quantity;
    return result;
  }

  CreateInvestmentRequest._();

  factory CreateInvestmentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateInvestmentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInvestmentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<InvestmentType>(
        2, _omitFieldNames ? '' : 'investmentType', $pb.PbFieldType.OE,
        defaultOrMaker: InvestmentType.INVESTMENT_TYPE_UNSPECIFIED,
        valueOf: InvestmentType.valueOf,
        enumValues: InvestmentType.values)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'initialInvestment', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'purchaseDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(6, _omitFieldNames ? '' : 'tickerSymbol')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInvestmentRequest clone() =>
      CreateInvestmentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInvestmentRequest copyWith(
          void Function(CreateInvestmentRequest) updates) =>
      super.copyWith((message) => updates(message as CreateInvestmentRequest))
          as CreateInvestmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInvestmentRequest create() => CreateInvestmentRequest._();
  @$core.override
  CreateInvestmentRequest createEmptyInstance() => create();
  static $pb.PbList<CreateInvestmentRequest> createRepeated() =>
      $pb.PbList<CreateInvestmentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateInvestmentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInvestmentRequest>(create);
  static CreateInvestmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  InvestmentType get investmentType => $_getN(1);
  @$pb.TagNumber(2)
  set investmentType(InvestmentType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasInvestmentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvestmentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get initialInvestment => $_getN(2);
  @$pb.TagNumber(3)
  set initialInvestment($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInitialInvestment() => $_has(2);
  @$pb.TagNumber(3)
  void clearInitialInvestment() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get purchaseDate => $_getN(4);
  @$pb.TagNumber(5)
  set purchaseDate($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPurchaseDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearPurchaseDate() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensurePurchaseDate() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get tickerSymbol => $_getSZ(5);
  @$pb.TagNumber(6)
  set tickerSymbol($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTickerSymbol() => $_has(5);
  @$pb.TagNumber(6)
  void clearTickerSymbol() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get quantity => $_getIZ(6);
  @$pb.TagNumber(7)
  set quantity($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasQuantity() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuantity() => $_clearField(7);
}

class CreateInvestmentResponse extends $pb.GeneratedMessage {
  factory CreateInvestmentResponse({
    Investment? investment,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (investment != null) result.investment = investment;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  CreateInvestmentResponse._();

  factory CreateInvestmentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateInvestmentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInvestmentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment',
        subBuilder: Investment.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInvestmentResponse clone() =>
      CreateInvestmentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInvestmentResponse copyWith(
          void Function(CreateInvestmentResponse) updates) =>
      super.copyWith((message) => updates(message as CreateInvestmentResponse))
          as CreateInvestmentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInvestmentResponse create() => CreateInvestmentResponse._();
  @$core.override
  CreateInvestmentResponse createEmptyInstance() => create();
  static $pb.PbList<CreateInvestmentResponse> createRepeated() =>
      $pb.PbList<CreateInvestmentResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateInvestmentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInvestmentResponse>(create);
  static CreateInvestmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => $_clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Financial Goals Management
class CreateFinancialGoalRequest extends $pb.GeneratedMessage {
  factory CreateFinancialGoalRequest({
    $core.String? name,
    GoalType? goalType,
    $core.double? targetAmount,
    $core.double? currentAmount,
    $core.double? monthlyContribution,
    $core.String? currency,
    $1.Timestamp? targetDate,
    $core.String? icon,
    $core.String? color,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (goalType != null) result.goalType = goalType;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (monthlyContribution != null)
      result.monthlyContribution = monthlyContribution;
    if (currency != null) result.currency = currency;
    if (targetDate != null) result.targetDate = targetDate;
    if (icon != null) result.icon = icon;
    if (color != null) result.color = color;
    return result;
  }

  CreateFinancialGoalRequest._();

  factory CreateFinancialGoalRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateFinancialGoalRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateFinancialGoalRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<GoalType>(2, _omitFieldNames ? '' : 'goalType', $pb.PbFieldType.OE,
        defaultOrMaker: GoalType.GOAL_TYPE_UNSPECIFIED,
        valueOf: GoalType.valueOf,
        enumValues: GoalType.values)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'monthlyContribution', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'targetDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(8, _omitFieldNames ? '' : 'icon')
    ..aOS(9, _omitFieldNames ? '' : 'color')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFinancialGoalRequest clone() =>
      CreateFinancialGoalRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFinancialGoalRequest copyWith(
          void Function(CreateFinancialGoalRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateFinancialGoalRequest))
          as CreateFinancialGoalRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalRequest create() => CreateFinancialGoalRequest._();
  @$core.override
  CreateFinancialGoalRequest createEmptyInstance() => create();
  static $pb.PbList<CreateFinancialGoalRequest> createRepeated() =>
      $pb.PbList<CreateFinancialGoalRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateFinancialGoalRequest>(create);
  static CreateFinancialGoalRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  GoalType get goalType => $_getN(1);
  @$pb.TagNumber(2)
  set goalType(GoalType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasGoalType() => $_has(1);
  @$pb.TagNumber(2)
  void clearGoalType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get targetAmount => $_getN(2);
  @$pb.TagNumber(3)
  set targetAmount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTargetAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get currentAmount => $_getN(3);
  @$pb.TagNumber(4)
  set currentAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get monthlyContribution => $_getN(4);
  @$pb.TagNumber(5)
  set monthlyContribution($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMonthlyContribution() => $_has(4);
  @$pb.TagNumber(5)
  void clearMonthlyContribution() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get targetDate => $_getN(6);
  @$pb.TagNumber(7)
  set targetDate($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTargetDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetDate() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureTargetDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get icon => $_getSZ(7);
  @$pb.TagNumber(8)
  set icon($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIcon() => $_has(7);
  @$pb.TagNumber(8)
  void clearIcon() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get color => $_getSZ(8);
  @$pb.TagNumber(9)
  set color($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasColor() => $_has(8);
  @$pb.TagNumber(9)
  void clearColor() => $_clearField(9);
}

class CreateFinancialGoalResponse extends $pb.GeneratedMessage {
  factory CreateFinancialGoalResponse({
    FinancialGoal? goal,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (goal != null) result.goal = goal;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  CreateFinancialGoalResponse._();

  factory CreateFinancialGoalResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateFinancialGoalResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateFinancialGoalResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<FinancialGoal>(1, _omitFieldNames ? '' : 'goal',
        subBuilder: FinancialGoal.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFinancialGoalResponse clone() =>
      CreateFinancialGoalResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFinancialGoalResponse copyWith(
          void Function(CreateFinancialGoalResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateFinancialGoalResponse))
          as CreateFinancialGoalResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalResponse create() =>
      CreateFinancialGoalResponse._();
  @$core.override
  CreateFinancialGoalResponse createEmptyInstance() => create();
  static $pb.PbList<CreateFinancialGoalResponse> createRepeated() =>
      $pb.PbList<CreateFinancialGoalResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateFinancialGoalResponse>(create);
  static CreateFinancialGoalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FinancialGoal get goal => $_getN(0);
  @$pb.TagNumber(1)
  set goal(FinancialGoal value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearGoal() => $_clearField(1);
  @$pb.TagNumber(1)
  FinancialGoal ensureGoal() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class GetFinancialGoalsRequest extends $pb.GeneratedMessage {
  factory GetFinancialGoalsRequest({
    GoalStatus? status,
  }) {
    final result = create();
    if (status != null) result.status = status;
    return result;
  }

  GetFinancialGoalsRequest._();

  factory GetFinancialGoalsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFinancialGoalsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFinancialGoalsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<GoalStatus>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: GoalStatus.GOAL_STATUS_UNSPECIFIED,
        valueOf: GoalStatus.valueOf,
        enumValues: GoalStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFinancialGoalsRequest clone() =>
      GetFinancialGoalsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFinancialGoalsRequest copyWith(
          void Function(GetFinancialGoalsRequest) updates) =>
      super.copyWith((message) => updates(message as GetFinancialGoalsRequest))
          as GetFinancialGoalsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalsRequest create() => GetFinancialGoalsRequest._();
  @$core.override
  GetFinancialGoalsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFinancialGoalsRequest> createRepeated() =>
      $pb.PbList<GetFinancialGoalsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFinancialGoalsRequest>(create);
  static GetFinancialGoalsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  GoalStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(GoalStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class GetFinancialGoalsResponse extends $pb.GeneratedMessage {
  factory GetFinancialGoalsResponse({
    FinancialGoalsList? goalsList,
  }) {
    final result = create();
    if (goalsList != null) result.goalsList = goalsList;
    return result;
  }

  GetFinancialGoalsResponse._();

  factory GetFinancialGoalsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFinancialGoalsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFinancialGoalsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<FinancialGoalsList>(1, _omitFieldNames ? '' : 'goalsList',
        subBuilder: FinancialGoalsList.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFinancialGoalsResponse clone() =>
      GetFinancialGoalsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFinancialGoalsResponse copyWith(
          void Function(GetFinancialGoalsResponse) updates) =>
      super.copyWith((message) => updates(message as GetFinancialGoalsResponse))
          as GetFinancialGoalsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalsResponse create() => GetFinancialGoalsResponse._();
  @$core.override
  GetFinancialGoalsResponse createEmptyInstance() => create();
  static $pb.PbList<GetFinancialGoalsResponse> createRepeated() =>
      $pb.PbList<GetFinancialGoalsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFinancialGoalsResponse>(create);
  static GetFinancialGoalsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FinancialGoalsList get goalsList => $_getN(0);
  @$pb.TagNumber(1)
  set goalsList(FinancialGoalsList value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGoalsList() => $_has(0);
  @$pb.TagNumber(1)
  void clearGoalsList() => $_clearField(1);
  @$pb.TagNumber(1)
  FinancialGoalsList ensureGoalsList() => $_ensure(0);
}

class UpdateFinancialGoalProgressRequest extends $pb.GeneratedMessage {
  factory UpdateFinancialGoalProgressRequest({
    $core.String? goalId,
    $core.double? amountToAdd,
  }) {
    final result = create();
    if (goalId != null) result.goalId = goalId;
    if (amountToAdd != null) result.amountToAdd = amountToAdd;
    return result;
  }

  UpdateFinancialGoalProgressRequest._();

  factory UpdateFinancialGoalProgressRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFinancialGoalProgressRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFinancialGoalProgressRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'goalId')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'amountToAdd', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFinancialGoalProgressRequest clone() =>
      UpdateFinancialGoalProgressRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFinancialGoalProgressRequest copyWith(
          void Function(UpdateFinancialGoalProgressRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateFinancialGoalProgressRequest))
          as UpdateFinancialGoalProgressRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalProgressRequest create() =>
      UpdateFinancialGoalProgressRequest._();
  @$core.override
  UpdateFinancialGoalProgressRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateFinancialGoalProgressRequest> createRepeated() =>
      $pb.PbList<UpdateFinancialGoalProgressRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalProgressRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFinancialGoalProgressRequest>(
          create);
  static UpdateFinancialGoalProgressRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get goalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set goalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGoalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGoalId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amountToAdd => $_getN(1);
  @$pb.TagNumber(2)
  set amountToAdd($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountToAdd() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountToAdd() => $_clearField(2);
}

class UpdateFinancialGoalProgressResponse extends $pb.GeneratedMessage {
  factory UpdateFinancialGoalProgressResponse({
    FinancialGoal? goal,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (goal != null) result.goal = goal;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  UpdateFinancialGoalProgressResponse._();

  factory UpdateFinancialGoalProgressResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFinancialGoalProgressResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFinancialGoalProgressResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<FinancialGoal>(1, _omitFieldNames ? '' : 'goal',
        subBuilder: FinancialGoal.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFinancialGoalProgressResponse clone() =>
      UpdateFinancialGoalProgressResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFinancialGoalProgressResponse copyWith(
          void Function(UpdateFinancialGoalProgressResponse) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateFinancialGoalProgressResponse))
          as UpdateFinancialGoalProgressResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalProgressResponse create() =>
      UpdateFinancialGoalProgressResponse._();
  @$core.override
  UpdateFinancialGoalProgressResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateFinancialGoalProgressResponse> createRepeated() =>
      $pb.PbList<UpdateFinancialGoalProgressResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalProgressResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateFinancialGoalProgressResponse>(create);
  static UpdateFinancialGoalProgressResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FinancialGoal get goal => $_getN(0);
  @$pb.TagNumber(1)
  set goal(FinancialGoal value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearGoal() => $_clearField(1);
  @$pb.TagNumber(1)
  FinancialGoal ensureGoal() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Savings Goal Management
class GetSavingsGoalRequest extends $pb.GeneratedMessage {
  factory GetSavingsGoalRequest() => create();

  GetSavingsGoalRequest._();

  factory GetSavingsGoalRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSavingsGoalRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSavingsGoalRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSavingsGoalRequest clone() =>
      GetSavingsGoalRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSavingsGoalRequest copyWith(
          void Function(GetSavingsGoalRequest) updates) =>
      super.copyWith((message) => updates(message as GetSavingsGoalRequest))
          as GetSavingsGoalRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSavingsGoalRequest create() => GetSavingsGoalRequest._();
  @$core.override
  GetSavingsGoalRequest createEmptyInstance() => create();
  static $pb.PbList<GetSavingsGoalRequest> createRepeated() =>
      $pb.PbList<GetSavingsGoalRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSavingsGoalRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSavingsGoalRequest>(create);
  static GetSavingsGoalRequest? _defaultInstance;
}

class GetSavingsGoalResponse extends $pb.GeneratedMessage {
  factory GetSavingsGoalResponse({
    SavingsGoal? savingsGoal,
    $core.bool? hasGoal,
  }) {
    final result = create();
    if (savingsGoal != null) result.savingsGoal = savingsGoal;
    if (hasGoal != null) result.hasGoal = hasGoal;
    return result;
  }

  GetSavingsGoalResponse._();

  factory GetSavingsGoalResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSavingsGoalResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSavingsGoalResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<SavingsGoal>(1, _omitFieldNames ? '' : 'savingsGoal',
        subBuilder: SavingsGoal.create)
    ..aOB(2, _omitFieldNames ? '' : 'hasGoal')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSavingsGoalResponse clone() =>
      GetSavingsGoalResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSavingsGoalResponse copyWith(
          void Function(GetSavingsGoalResponse) updates) =>
      super.copyWith((message) => updates(message as GetSavingsGoalResponse))
          as GetSavingsGoalResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSavingsGoalResponse create() => GetSavingsGoalResponse._();
  @$core.override
  GetSavingsGoalResponse createEmptyInstance() => create();
  static $pb.PbList<GetSavingsGoalResponse> createRepeated() =>
      $pb.PbList<GetSavingsGoalResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSavingsGoalResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSavingsGoalResponse>(create);
  static GetSavingsGoalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SavingsGoal get savingsGoal => $_getN(0);
  @$pb.TagNumber(1)
  set savingsGoal(SavingsGoal value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSavingsGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearSavingsGoal() => $_clearField(1);
  @$pb.TagNumber(1)
  SavingsGoal ensureSavingsGoal() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get hasGoal => $_getBF(1);
  @$pb.TagNumber(2)
  set hasGoal($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHasGoal() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasGoal() => $_clearField(2);
}

class CreateOrUpdateSavingsGoalRequest extends $pb.GeneratedMessage {
  factory CreateOrUpdateSavingsGoalRequest({
    $core.String? name,
    $core.double? targetAmount,
    $core.double? currentAmount,
    $1.Timestamp? targetDate,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (targetDate != null) result.targetDate = targetDate;
    return result;
  }

  CreateOrUpdateSavingsGoalRequest._();

  factory CreateOrUpdateSavingsGoalRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateOrUpdateSavingsGoalRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateOrUpdateSavingsGoalRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'targetDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrUpdateSavingsGoalRequest clone() =>
      CreateOrUpdateSavingsGoalRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrUpdateSavingsGoalRequest copyWith(
          void Function(CreateOrUpdateSavingsGoalRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateOrUpdateSavingsGoalRequest))
          as CreateOrUpdateSavingsGoalRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOrUpdateSavingsGoalRequest create() =>
      CreateOrUpdateSavingsGoalRequest._();
  @$core.override
  CreateOrUpdateSavingsGoalRequest createEmptyInstance() => create();
  static $pb.PbList<CreateOrUpdateSavingsGoalRequest> createRepeated() =>
      $pb.PbList<CreateOrUpdateSavingsGoalRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateOrUpdateSavingsGoalRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateOrUpdateSavingsGoalRequest>(
          create);
  static CreateOrUpdateSavingsGoalRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get targetAmount => $_getN(1);
  @$pb.TagNumber(2)
  set targetAmount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTargetAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get currentAmount => $_getN(2);
  @$pb.TagNumber(3)
  set currentAmount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get targetDate => $_getN(3);
  @$pb.TagNumber(4)
  set targetDate($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetDate() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureTargetDate() => $_ensure(3);
}

class CreateOrUpdateSavingsGoalResponse extends $pb.GeneratedMessage {
  factory CreateOrUpdateSavingsGoalResponse({
    SavingsGoal? savingsGoal,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (savingsGoal != null) result.savingsGoal = savingsGoal;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  CreateOrUpdateSavingsGoalResponse._();

  factory CreateOrUpdateSavingsGoalResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateOrUpdateSavingsGoalResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateOrUpdateSavingsGoalResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<SavingsGoal>(1, _omitFieldNames ? '' : 'savingsGoal',
        subBuilder: SavingsGoal.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrUpdateSavingsGoalResponse clone() =>
      CreateOrUpdateSavingsGoalResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrUpdateSavingsGoalResponse copyWith(
          void Function(CreateOrUpdateSavingsGoalResponse) updates) =>
      super.copyWith((message) =>
              updates(message as CreateOrUpdateSavingsGoalResponse))
          as CreateOrUpdateSavingsGoalResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOrUpdateSavingsGoalResponse create() =>
      CreateOrUpdateSavingsGoalResponse._();
  @$core.override
  CreateOrUpdateSavingsGoalResponse createEmptyInstance() => create();
  static $pb.PbList<CreateOrUpdateSavingsGoalResponse> createRepeated() =>
      $pb.PbList<CreateOrUpdateSavingsGoalResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateOrUpdateSavingsGoalResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateOrUpdateSavingsGoalResponse>(
          create);
  static CreateOrUpdateSavingsGoalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SavingsGoal get savingsGoal => $_getN(0);
  @$pb.TagNumber(1)
  set savingsGoal(SavingsGoal value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSavingsGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearSavingsGoal() => $_clearField(1);
  @$pb.TagNumber(1)
  SavingsGoal ensureSavingsGoal() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Recurring Bills Management
class CreateRecurringBillRequest extends $pb.GeneratedMessage {
  factory CreateRecurringBillRequest({
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    $core.String? recurrencePattern,
    $1.Timestamp? nextDueDate,
    $core.String? merchant,
    $core.String? icon,
    $core.bool? autoPayEnabled,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (recurrencePattern != null) result.recurrencePattern = recurrencePattern;
    if (nextDueDate != null) result.nextDueDate = nextDueDate;
    if (merchant != null) result.merchant = merchant;
    if (icon != null) result.icon = icon;
    if (autoPayEnabled != null) result.autoPayEnabled = autoPayEnabled;
    return result;
  }

  CreateRecurringBillRequest._();

  factory CreateRecurringBillRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateRecurringBillRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateRecurringBillRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..e<ExpenseCategory>(
        4, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED,
        valueOf: ExpenseCategory.valueOf,
        enumValues: ExpenseCategory.values)
    ..aOS(5, _omitFieldNames ? '' : 'recurrencePattern')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'nextDueDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(7, _omitFieldNames ? '' : 'merchant')
    ..aOS(8, _omitFieldNames ? '' : 'icon')
    ..aOB(9, _omitFieldNames ? '' : 'autoPayEnabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringBillRequest clone() =>
      CreateRecurringBillRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringBillRequest copyWith(
          void Function(CreateRecurringBillRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateRecurringBillRequest))
          as CreateRecurringBillRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRecurringBillRequest create() => CreateRecurringBillRequest._();
  @$core.override
  CreateRecurringBillRequest createEmptyInstance() => create();
  static $pb.PbList<CreateRecurringBillRequest> createRepeated() =>
      $pb.PbList<CreateRecurringBillRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateRecurringBillRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateRecurringBillRequest>(create);
  static CreateRecurringBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

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
  ExpenseCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(ExpenseCategory value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get recurrencePattern => $_getSZ(4);
  @$pb.TagNumber(5)
  set recurrencePattern($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRecurrencePattern() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecurrencePattern() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get nextDueDate => $_getN(5);
  @$pb.TagNumber(6)
  set nextDueDate($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasNextDueDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearNextDueDate() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureNextDueDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get merchant => $_getSZ(6);
  @$pb.TagNumber(7)
  set merchant($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMerchant() => $_has(6);
  @$pb.TagNumber(7)
  void clearMerchant() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get icon => $_getSZ(7);
  @$pb.TagNumber(8)
  set icon($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIcon() => $_has(7);
  @$pb.TagNumber(8)
  void clearIcon() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get autoPayEnabled => $_getBF(8);
  @$pb.TagNumber(9)
  set autoPayEnabled($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAutoPayEnabled() => $_has(8);
  @$pb.TagNumber(9)
  void clearAutoPayEnabled() => $_clearField(9);
}

class CreateRecurringBillResponse extends $pb.GeneratedMessage {
  factory CreateRecurringBillResponse({
    RecurringBill? bill,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (bill != null) result.bill = bill;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  CreateRecurringBillResponse._();

  factory CreateRecurringBillResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateRecurringBillResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateRecurringBillResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<RecurringBill>(1, _omitFieldNames ? '' : 'bill',
        subBuilder: RecurringBill.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringBillResponse clone() =>
      CreateRecurringBillResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringBillResponse copyWith(
          void Function(CreateRecurringBillResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateRecurringBillResponse))
          as CreateRecurringBillResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRecurringBillResponse create() =>
      CreateRecurringBillResponse._();
  @$core.override
  CreateRecurringBillResponse createEmptyInstance() => create();
  static $pb.PbList<CreateRecurringBillResponse> createRepeated() =>
      $pb.PbList<CreateRecurringBillResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateRecurringBillResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateRecurringBillResponse>(create);
  static CreateRecurringBillResponse? _defaultInstance;

  @$pb.TagNumber(1)
  RecurringBill get bill => $_getN(0);
  @$pb.TagNumber(1)
  set bill(RecurringBill value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBill() => $_has(0);
  @$pb.TagNumber(1)
  void clearBill() => $_clearField(1);
  @$pb.TagNumber(1)
  RecurringBill ensureBill() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class GetUpcomingBillsRequest extends $pb.GeneratedMessage {
  factory GetUpcomingBillsRequest({
    $core.int? daysAhead,
  }) {
    final result = create();
    if (daysAhead != null) result.daysAhead = daysAhead;
    return result;
  }

  GetUpcomingBillsRequest._();

  factory GetUpcomingBillsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpcomingBillsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpcomingBillsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'daysAhead', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpcomingBillsRequest clone() =>
      GetUpcomingBillsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpcomingBillsRequest copyWith(
          void Function(GetUpcomingBillsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUpcomingBillsRequest))
          as GetUpcomingBillsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpcomingBillsRequest create() => GetUpcomingBillsRequest._();
  @$core.override
  GetUpcomingBillsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUpcomingBillsRequest> createRepeated() =>
      $pb.PbList<GetUpcomingBillsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUpcomingBillsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpcomingBillsRequest>(create);
  static GetUpcomingBillsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get daysAhead => $_getIZ(0);
  @$pb.TagNumber(1)
  set daysAhead($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDaysAhead() => $_has(0);
  @$pb.TagNumber(1)
  void clearDaysAhead() => $_clearField(1);
}

class GetUpcomingBillsResponse extends $pb.GeneratedMessage {
  factory GetUpcomingBillsResponse({
    UpcomingBillsList? billsList,
  }) {
    final result = create();
    if (billsList != null) result.billsList = billsList;
    return result;
  }

  GetUpcomingBillsResponse._();

  factory GetUpcomingBillsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpcomingBillsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpcomingBillsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpcomingBillsList>(1, _omitFieldNames ? '' : 'billsList',
        subBuilder: UpcomingBillsList.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpcomingBillsResponse clone() =>
      GetUpcomingBillsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpcomingBillsResponse copyWith(
          void Function(GetUpcomingBillsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUpcomingBillsResponse))
          as GetUpcomingBillsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpcomingBillsResponse create() => GetUpcomingBillsResponse._();
  @$core.override
  GetUpcomingBillsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUpcomingBillsResponse> createRepeated() =>
      $pb.PbList<GetUpcomingBillsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUpcomingBillsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpcomingBillsResponse>(create);
  static GetUpcomingBillsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpcomingBillsList get billsList => $_getN(0);
  @$pb.TagNumber(1)
  set billsList(UpcomingBillsList value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBillsList() => $_has(0);
  @$pb.TagNumber(1)
  void clearBillsList() => $_clearField(1);
  @$pb.TagNumber(1)
  UpcomingBillsList ensureBillsList() => $_ensure(0);
}

/// Tracked Transaction Models
class TrackedIncomeTransaction extends $pb.GeneratedMessage {
  factory TrackedIncomeTransaction({
    $core.String? id,
    $core.String? userId,
    $core.double? amount,
    $core.String? currency,
    $core.String? sourceType,
    $core.String? sourceId,
    $core.String? sourceReference,
    $core.String? category,
    $core.String? description,
    $core.String? senderId,
    $core.String? senderName,
    $1.Timestamp? transactionDate,
    $core.String? metadata,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (sourceType != null) result.sourceType = sourceType;
    if (sourceId != null) result.sourceId = sourceId;
    if (sourceReference != null) result.sourceReference = sourceReference;
    if (category != null) result.category = category;
    if (description != null) result.description = description;
    if (senderId != null) result.senderId = senderId;
    if (senderName != null) result.senderName = senderName;
    if (transactionDate != null) result.transactionDate = transactionDate;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  TrackedIncomeTransaction._();

  factory TrackedIncomeTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackedIncomeTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackedIncomeTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'sourceType')
    ..aOS(6, _omitFieldNames ? '' : 'sourceId')
    ..aOS(7, _omitFieldNames ? '' : 'sourceReference')
    ..aOS(8, _omitFieldNames ? '' : 'category')
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..aOS(10, _omitFieldNames ? '' : 'senderId')
    ..aOS(11, _omitFieldNames ? '' : 'senderName')
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'transactionDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'metadata')
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackedIncomeTransaction clone() =>
      TrackedIncomeTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackedIncomeTransaction copyWith(
          void Function(TrackedIncomeTransaction) updates) =>
      super.copyWith((message) => updates(message as TrackedIncomeTransaction))
          as TrackedIncomeTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackedIncomeTransaction create() => TrackedIncomeTransaction._();
  @$core.override
  TrackedIncomeTransaction createEmptyInstance() => create();
  static $pb.PbList<TrackedIncomeTransaction> createRepeated() =>
      $pb.PbList<TrackedIncomeTransaction>();
  @$core.pragma('dart2js:noInline')
  static TrackedIncomeTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackedIncomeTransaction>(create);
  static TrackedIncomeTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sourceType => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSourceType() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get sourceId => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSourceId() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get sourceReference => $_getSZ(6);
  @$pb.TagNumber(7)
  set sourceReference($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSourceReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearSourceReference() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get category => $_getSZ(7);
  @$pb.TagNumber(8)
  set category($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCategory() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategory() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get senderId => $_getSZ(9);
  @$pb.TagNumber(10)
  set senderId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSenderId() => $_has(9);
  @$pb.TagNumber(10)
  void clearSenderId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get senderName => $_getSZ(10);
  @$pb.TagNumber(11)
  set senderName($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSenderName() => $_has(10);
  @$pb.TagNumber(11)
  void clearSenderName() => $_clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get transactionDate => $_getN(11);
  @$pb.TagNumber(12)
  set transactionDate($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasTransactionDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearTransactionDate() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureTransactionDate() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get metadata => $_getSZ(12);
  @$pb.TagNumber(13)
  set metadata($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearMetadata() => $_clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureCreatedAt() => $_ensure(13);
}

class TrackedExpenditureTransaction extends $pb.GeneratedMessage {
  factory TrackedExpenditureTransaction({
    $core.String? id,
    $core.String? userId,
    $core.double? amount,
    $core.String? currency,
    $core.String? expenseType,
    $core.String? expenseId,
    $core.String? expenseReference,
    $core.String? category,
    $core.String? recipientId,
    $core.String? recipientName,
    $core.String? merchant,
    $core.String? description,
    $1.Timestamp? transactionDate,
    $core.String? metadata,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (expenseType != null) result.expenseType = expenseType;
    if (expenseId != null) result.expenseId = expenseId;
    if (expenseReference != null) result.expenseReference = expenseReference;
    if (category != null) result.category = category;
    if (recipientId != null) result.recipientId = recipientId;
    if (recipientName != null) result.recipientName = recipientName;
    if (merchant != null) result.merchant = merchant;
    if (description != null) result.description = description;
    if (transactionDate != null) result.transactionDate = transactionDate;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  TrackedExpenditureTransaction._();

  factory TrackedExpenditureTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackedExpenditureTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackedExpenditureTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'expenseType')
    ..aOS(6, _omitFieldNames ? '' : 'expenseId')
    ..aOS(7, _omitFieldNames ? '' : 'expenseReference')
    ..aOS(8, _omitFieldNames ? '' : 'category')
    ..aOS(9, _omitFieldNames ? '' : 'recipientId')
    ..aOS(10, _omitFieldNames ? '' : 'recipientName')
    ..aOS(11, _omitFieldNames ? '' : 'merchant')
    ..aOS(12, _omitFieldNames ? '' : 'description')
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'transactionDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(14, _omitFieldNames ? '' : 'metadata')
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackedExpenditureTransaction clone() =>
      TrackedExpenditureTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackedExpenditureTransaction copyWith(
          void Function(TrackedExpenditureTransaction) updates) =>
      super.copyWith(
              (message) => updates(message as TrackedExpenditureTransaction))
          as TrackedExpenditureTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackedExpenditureTransaction create() =>
      TrackedExpenditureTransaction._();
  @$core.override
  TrackedExpenditureTransaction createEmptyInstance() => create();
  static $pb.PbList<TrackedExpenditureTransaction> createRepeated() =>
      $pb.PbList<TrackedExpenditureTransaction>();
  @$core.pragma('dart2js:noInline')
  static TrackedExpenditureTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackedExpenditureTransaction>(create);
  static TrackedExpenditureTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get expenseType => $_getSZ(4);
  @$pb.TagNumber(5)
  set expenseType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExpenseType() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpenseType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get expenseId => $_getSZ(5);
  @$pb.TagNumber(6)
  set expenseId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasExpenseId() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpenseId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get expenseReference => $_getSZ(6);
  @$pb.TagNumber(7)
  set expenseReference($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasExpenseReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearExpenseReference() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get category => $_getSZ(7);
  @$pb.TagNumber(8)
  set category($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCategory() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategory() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get recipientId => $_getSZ(8);
  @$pb.TagNumber(9)
  set recipientId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRecipientId() => $_has(8);
  @$pb.TagNumber(9)
  void clearRecipientId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get recipientName => $_getSZ(9);
  @$pb.TagNumber(10)
  set recipientName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRecipientName() => $_has(9);
  @$pb.TagNumber(10)
  void clearRecipientName() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get merchant => $_getSZ(10);
  @$pb.TagNumber(11)
  set merchant($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMerchant() => $_has(10);
  @$pb.TagNumber(11)
  void clearMerchant() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get description => $_getSZ(11);
  @$pb.TagNumber(12)
  set description($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDescription() => $_has(11);
  @$pb.TagNumber(12)
  void clearDescription() => $_clearField(12);

  @$pb.TagNumber(13)
  $1.Timestamp get transactionDate => $_getN(12);
  @$pb.TagNumber(13)
  set transactionDate($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasTransactionDate() => $_has(12);
  @$pb.TagNumber(13)
  void clearTransactionDate() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureTransactionDate() => $_ensure(12);

  @$pb.TagNumber(14)
  $core.String get metadata => $_getSZ(13);
  @$pb.TagNumber(14)
  set metadata($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasMetadata() => $_has(13);
  @$pb.TagNumber(14)
  void clearMetadata() => $_clearField(14);

  @$pb.TagNumber(15)
  $1.Timestamp get createdAt => $_getN(14);
  @$pb.TagNumber(15)
  set createdAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureCreatedAt() => $_ensure(14);
}

/// Tracked Income Request/Response
class GetTrackedIncomeRequest extends $pb.GeneratedMessage {
  factory GetTrackedIncomeRequest({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetTrackedIncomeRequest._();

  factory GetTrackedIncomeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedIncomeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedIncomeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeRequest clone() =>
      GetTrackedIncomeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeRequest copyWith(
          void Function(GetTrackedIncomeRequest) updates) =>
      super.copyWith((message) => updates(message as GetTrackedIncomeRequest))
          as GetTrackedIncomeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeRequest create() => GetTrackedIncomeRequest._();
  @$core.override
  GetTrackedIncomeRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeRequest> createRepeated() =>
      $pb.PbList<GetTrackedIncomeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTrackedIncomeRequest>(create);
  static GetTrackedIncomeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);
}

class GetTrackedIncomeResponse extends $pb.GeneratedMessage {
  factory GetTrackedIncomeResponse({
    $core.double? totalIncome,
    $core.bool? success,
  }) {
    final result = create();
    if (totalIncome != null) result.totalIncome = totalIncome;
    if (success != null) result.success = success;
    return result;
  }

  GetTrackedIncomeResponse._();

  factory GetTrackedIncomeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedIncomeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedIncomeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeResponse clone() =>
      GetTrackedIncomeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeResponse copyWith(
          void Function(GetTrackedIncomeResponse) updates) =>
      super.copyWith((message) => updates(message as GetTrackedIncomeResponse))
          as GetTrackedIncomeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeResponse create() => GetTrackedIncomeResponse._();
  @$core.override
  GetTrackedIncomeResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeResponse> createRepeated() =>
      $pb.PbList<GetTrackedIncomeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTrackedIncomeResponse>(create);
  static GetTrackedIncomeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalIncome => $_getN(0);
  @$pb.TagNumber(1)
  set totalIncome($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalIncome() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalIncome() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);
}

/// Tracked Expenditure Request/Response
class GetTrackedExpenditureRequest extends $pb.GeneratedMessage {
  factory GetTrackedExpenditureRequest({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetTrackedExpenditureRequest._();

  factory GetTrackedExpenditureRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedExpenditureRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedExpenditureRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureRequest clone() =>
      GetTrackedExpenditureRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureRequest copyWith(
          void Function(GetTrackedExpenditureRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTrackedExpenditureRequest))
          as GetTrackedExpenditureRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureRequest create() =>
      GetTrackedExpenditureRequest._();
  @$core.override
  GetTrackedExpenditureRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureRequest> createRepeated() =>
      $pb.PbList<GetTrackedExpenditureRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTrackedExpenditureRequest>(create);
  static GetTrackedExpenditureRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);
}

class GetTrackedExpenditureResponse extends $pb.GeneratedMessage {
  factory GetTrackedExpenditureResponse({
    $core.double? totalExpenditure,
    $core.bool? success,
  }) {
    final result = create();
    if (totalExpenditure != null) result.totalExpenditure = totalExpenditure;
    if (success != null) result.success = success;
    return result;
  }

  GetTrackedExpenditureResponse._();

  factory GetTrackedExpenditureResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedExpenditureResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedExpenditureResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'totalExpenditure', $pb.PbFieldType.OD)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureResponse clone() =>
      GetTrackedExpenditureResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureResponse copyWith(
          void Function(GetTrackedExpenditureResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetTrackedExpenditureResponse))
          as GetTrackedExpenditureResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureResponse create() =>
      GetTrackedExpenditureResponse._();
  @$core.override
  GetTrackedExpenditureResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureResponse> createRepeated() =>
      $pb.PbList<GetTrackedExpenditureResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTrackedExpenditureResponse>(create);
  static GetTrackedExpenditureResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalExpenditure => $_getN(0);
  @$pb.TagNumber(1)
  set totalExpenditure($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalExpenditure() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalExpenditure() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);
}

/// Tracked Income Breakdown Request/Response
class GetTrackedIncomeBreakdownRequest extends $pb.GeneratedMessage {
  factory GetTrackedIncomeBreakdownRequest({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetTrackedIncomeBreakdownRequest._();

  factory GetTrackedIncomeBreakdownRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedIncomeBreakdownRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedIncomeBreakdownRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeBreakdownRequest clone() =>
      GetTrackedIncomeBreakdownRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeBreakdownRequest copyWith(
          void Function(GetTrackedIncomeBreakdownRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTrackedIncomeBreakdownRequest))
          as GetTrackedIncomeBreakdownRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeBreakdownRequest create() =>
      GetTrackedIncomeBreakdownRequest._();
  @$core.override
  GetTrackedIncomeBreakdownRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeBreakdownRequest> createRepeated() =>
      $pb.PbList<GetTrackedIncomeBreakdownRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeBreakdownRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTrackedIncomeBreakdownRequest>(
          create);
  static GetTrackedIncomeBreakdownRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);
}

class GetTrackedIncomeBreakdownResponse extends $pb.GeneratedMessage {
  factory GetTrackedIncomeBreakdownResponse({
    $core.Iterable<$core.MapEntry<$core.String, $core.double>>?
        breakdownBySource,
    $core.double? totalIncome,
    $core.bool? success,
  }) {
    final result = create();
    if (breakdownBySource != null)
      result.breakdownBySource.addEntries(breakdownBySource);
    if (totalIncome != null) result.totalIncome = totalIncome;
    if (success != null) result.success = success;
    return result;
  }

  GetTrackedIncomeBreakdownResponse._();

  factory GetTrackedIncomeBreakdownResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedIncomeBreakdownResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedIncomeBreakdownResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..m<$core.String, $core.double>(
        1, _omitFieldNames ? '' : 'breakdownBySource',
        entryClassName:
            'GetTrackedIncomeBreakdownResponse.BreakdownBySourceEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('pb'))
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeBreakdownResponse clone() =>
      GetTrackedIncomeBreakdownResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeBreakdownResponse copyWith(
          void Function(GetTrackedIncomeBreakdownResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetTrackedIncomeBreakdownResponse))
          as GetTrackedIncomeBreakdownResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeBreakdownResponse create() =>
      GetTrackedIncomeBreakdownResponse._();
  @$core.override
  GetTrackedIncomeBreakdownResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeBreakdownResponse> createRepeated() =>
      $pb.PbList<GetTrackedIncomeBreakdownResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeBreakdownResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTrackedIncomeBreakdownResponse>(
          create);
  static GetTrackedIncomeBreakdownResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $core.double> get breakdownBySource => $_getMap(0);

  @$pb.TagNumber(2)
  $core.double get totalIncome => $_getN(1);
  @$pb.TagNumber(2)
  set totalIncome($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalIncome() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);
}

/// Tracked Expenditure Breakdown Request/Response
class GetTrackedExpenditureBreakdownRequest extends $pb.GeneratedMessage {
  factory GetTrackedExpenditureBreakdownRequest({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetTrackedExpenditureBreakdownRequest._();

  factory GetTrackedExpenditureBreakdownRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedExpenditureBreakdownRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedExpenditureBreakdownRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureBreakdownRequest clone() =>
      GetTrackedExpenditureBreakdownRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureBreakdownRequest copyWith(
          void Function(GetTrackedExpenditureBreakdownRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetTrackedExpenditureBreakdownRequest))
          as GetTrackedExpenditureBreakdownRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureBreakdownRequest create() =>
      GetTrackedExpenditureBreakdownRequest._();
  @$core.override
  GetTrackedExpenditureBreakdownRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureBreakdownRequest> createRepeated() =>
      $pb.PbList<GetTrackedExpenditureBreakdownRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureBreakdownRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetTrackedExpenditureBreakdownRequest>(create);
  static GetTrackedExpenditureBreakdownRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);
}

class GetTrackedExpenditureBreakdownResponse extends $pb.GeneratedMessage {
  factory GetTrackedExpenditureBreakdownResponse({
    $core.Iterable<$core.MapEntry<$core.String, $core.double>>? breakdownByType,
    $core.double? totalExpenditure,
    $core.bool? success,
  }) {
    final result = create();
    if (breakdownByType != null)
      result.breakdownByType.addEntries(breakdownByType);
    if (totalExpenditure != null) result.totalExpenditure = totalExpenditure;
    if (success != null) result.success = success;
    return result;
  }

  GetTrackedExpenditureBreakdownResponse._();

  factory GetTrackedExpenditureBreakdownResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedExpenditureBreakdownResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedExpenditureBreakdownResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..m<$core.String, $core.double>(1, _omitFieldNames ? '' : 'breakdownByType',
        entryClassName:
            'GetTrackedExpenditureBreakdownResponse.BreakdownByTypeEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('pb'))
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalExpenditure', $pb.PbFieldType.OD)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureBreakdownResponse clone() =>
      GetTrackedExpenditureBreakdownResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureBreakdownResponse copyWith(
          void Function(GetTrackedExpenditureBreakdownResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetTrackedExpenditureBreakdownResponse))
          as GetTrackedExpenditureBreakdownResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureBreakdownResponse create() =>
      GetTrackedExpenditureBreakdownResponse._();
  @$core.override
  GetTrackedExpenditureBreakdownResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureBreakdownResponse> createRepeated() =>
      $pb.PbList<GetTrackedExpenditureBreakdownResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureBreakdownResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetTrackedExpenditureBreakdownResponse>(create);
  static GetTrackedExpenditureBreakdownResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $core.double> get breakdownByType => $_getMap(0);

  @$pb.TagNumber(2)
  $core.double get totalExpenditure => $_getN(1);
  @$pb.TagNumber(2)
  set totalExpenditure($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalExpenditure() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalExpenditure() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);
}

/// Tracked Income Transactions Request/Response
class GetTrackedIncomeTransactionsRequest extends $pb.GeneratedMessage {
  factory GetTrackedIncomeTransactionsRequest({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
    $core.int? limit,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetTrackedIncomeTransactionsRequest._();

  factory GetTrackedIncomeTransactionsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedIncomeTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedIncomeTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeTransactionsRequest clone() =>
      GetTrackedIncomeTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeTransactionsRequest copyWith(
          void Function(GetTrackedIncomeTransactionsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetTrackedIncomeTransactionsRequest))
          as GetTrackedIncomeTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeTransactionsRequest create() =>
      GetTrackedIncomeTransactionsRequest._();
  @$core.override
  GetTrackedIncomeTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeTransactionsRequest> createRepeated() =>
      $pb.PbList<GetTrackedIncomeTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeTransactionsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetTrackedIncomeTransactionsRequest>(create);
  static GetTrackedIncomeTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetTrackedIncomeTransactionsResponse extends $pb.GeneratedMessage {
  factory GetTrackedIncomeTransactionsResponse({
    $core.Iterable<TrackedIncomeTransaction>? transactions,
    $core.int? totalCount,
    $core.bool? success,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (totalCount != null) result.totalCount = totalCount;
    if (success != null) result.success = success;
    return result;
  }

  GetTrackedIncomeTransactionsResponse._();

  factory GetTrackedIncomeTransactionsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedIncomeTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedIncomeTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TrackedIncomeTransaction>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: TrackedIncomeTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeTransactionsResponse clone() =>
      GetTrackedIncomeTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedIncomeTransactionsResponse copyWith(
          void Function(GetTrackedIncomeTransactionsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetTrackedIncomeTransactionsResponse))
          as GetTrackedIncomeTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeTransactionsResponse create() =>
      GetTrackedIncomeTransactionsResponse._();
  @$core.override
  GetTrackedIncomeTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeTransactionsResponse> createRepeated() =>
      $pb.PbList<GetTrackedIncomeTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeTransactionsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetTrackedIncomeTransactionsResponse>(create);
  static GetTrackedIncomeTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TrackedIncomeTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);
}

/// Tracked Expenditure Transactions Request/Response
class GetTrackedExpenditureTransactionsRequest extends $pb.GeneratedMessage {
  factory GetTrackedExpenditureTransactionsRequest({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
    $core.int? limit,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetTrackedExpenditureTransactionsRequest._();

  factory GetTrackedExpenditureTransactionsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedExpenditureTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedExpenditureTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureTransactionsRequest clone() =>
      GetTrackedExpenditureTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureTransactionsRequest copyWith(
          void Function(GetTrackedExpenditureTransactionsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetTrackedExpenditureTransactionsRequest))
          as GetTrackedExpenditureTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureTransactionsRequest create() =>
      GetTrackedExpenditureTransactionsRequest._();
  @$core.override
  GetTrackedExpenditureTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureTransactionsRequest>
      createRepeated() =>
          $pb.PbList<GetTrackedExpenditureTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureTransactionsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetTrackedExpenditureTransactionsRequest>(create);
  static GetTrackedExpenditureTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetTrackedExpenditureTransactionsResponse extends $pb.GeneratedMessage {
  factory GetTrackedExpenditureTransactionsResponse({
    $core.Iterable<TrackedExpenditureTransaction>? transactions,
    $core.int? totalCount,
    $core.bool? success,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (totalCount != null) result.totalCount = totalCount;
    if (success != null) result.success = success;
    return result;
  }

  GetTrackedExpenditureTransactionsResponse._();

  factory GetTrackedExpenditureTransactionsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackedExpenditureTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackedExpenditureTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TrackedExpenditureTransaction>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: TrackedExpenditureTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureTransactionsResponse clone() =>
      GetTrackedExpenditureTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackedExpenditureTransactionsResponse copyWith(
          void Function(GetTrackedExpenditureTransactionsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetTrackedExpenditureTransactionsResponse))
          as GetTrackedExpenditureTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureTransactionsResponse create() =>
      GetTrackedExpenditureTransactionsResponse._();
  @$core.override
  GetTrackedExpenditureTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureTransactionsResponse>
      createRepeated() =>
          $pb.PbList<GetTrackedExpenditureTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureTransactionsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetTrackedExpenditureTransactionsResponse>(create);
  static GetTrackedExpenditureTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TrackedExpenditureTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);
}

/// Comprehensive Financial Summary Request/Response
class GetComprehensiveFinancialSummaryRequest extends $pb.GeneratedMessage {
  factory GetComprehensiveFinancialSummaryRequest({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetComprehensiveFinancialSummaryRequest._();

  factory GetComprehensiveFinancialSummaryRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetComprehensiveFinancialSummaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetComprehensiveFinancialSummaryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetComprehensiveFinancialSummaryRequest clone() =>
      GetComprehensiveFinancialSummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetComprehensiveFinancialSummaryRequest copyWith(
          void Function(GetComprehensiveFinancialSummaryRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetComprehensiveFinancialSummaryRequest))
          as GetComprehensiveFinancialSummaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetComprehensiveFinancialSummaryRequest create() =>
      GetComprehensiveFinancialSummaryRequest._();
  @$core.override
  GetComprehensiveFinancialSummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetComprehensiveFinancialSummaryRequest> createRepeated() =>
      $pb.PbList<GetComprehensiveFinancialSummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetComprehensiveFinancialSummaryRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetComprehensiveFinancialSummaryRequest>(create);
  static GetComprehensiveFinancialSummaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);
}

class GetComprehensiveFinancialSummaryResponse extends $pb.GeneratedMessage {
  factory GetComprehensiveFinancialSummaryResponse({
    ComprehensiveFinancialSummary? summary,
    $core.bool? success,
  }) {
    final result = create();
    if (summary != null) result.summary = summary;
    if (success != null) result.success = success;
    return result;
  }

  GetComprehensiveFinancialSummaryResponse._();

  factory GetComprehensiveFinancialSummaryResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetComprehensiveFinancialSummaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetComprehensiveFinancialSummaryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ComprehensiveFinancialSummary>(1, _omitFieldNames ? '' : 'summary',
        subBuilder: ComprehensiveFinancialSummary.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetComprehensiveFinancialSummaryResponse clone() =>
      GetComprehensiveFinancialSummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetComprehensiveFinancialSummaryResponse copyWith(
          void Function(GetComprehensiveFinancialSummaryResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetComprehensiveFinancialSummaryResponse))
          as GetComprehensiveFinancialSummaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetComprehensiveFinancialSummaryResponse create() =>
      GetComprehensiveFinancialSummaryResponse._();
  @$core.override
  GetComprehensiveFinancialSummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetComprehensiveFinancialSummaryResponse>
      createRepeated() =>
          $pb.PbList<GetComprehensiveFinancialSummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetComprehensiveFinancialSummaryResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetComprehensiveFinancialSummaryResponse>(create);
  static GetComprehensiveFinancialSummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ComprehensiveFinancialSummary get summary => $_getN(0);
  @$pb.TagNumber(1)
  set summary(ComprehensiveFinancialSummary value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSummary() => $_has(0);
  @$pb.TagNumber(1)
  void clearSummary() => $_clearField(1);
  @$pb.TagNumber(1)
  ComprehensiveFinancialSummary ensureSummary() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);
}

class ComprehensiveFinancialSummary extends $pb.GeneratedMessage {
  factory ComprehensiveFinancialSummary({
    ComprehensivePeriod? period,
    ComprehensiveIncomeData? income,
    ComprehensiveExpenditureData? expenditure,
    $core.double? netIncome,
    $core.double? savingsRate,
  }) {
    final result = create();
    if (period != null) result.period = period;
    if (income != null) result.income = income;
    if (expenditure != null) result.expenditure = expenditure;
    if (netIncome != null) result.netIncome = netIncome;
    if (savingsRate != null) result.savingsRate = savingsRate;
    return result;
  }

  ComprehensiveFinancialSummary._();

  factory ComprehensiveFinancialSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ComprehensiveFinancialSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ComprehensiveFinancialSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ComprehensivePeriod>(1, _omitFieldNames ? '' : 'period',
        subBuilder: ComprehensivePeriod.create)
    ..aOM<ComprehensiveIncomeData>(2, _omitFieldNames ? '' : 'income',
        subBuilder: ComprehensiveIncomeData.create)
    ..aOM<ComprehensiveExpenditureData>(3, _omitFieldNames ? '' : 'expenditure',
        subBuilder: ComprehensiveExpenditureData.create)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'netIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'savingsRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComprehensiveFinancialSummary clone() =>
      ComprehensiveFinancialSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComprehensiveFinancialSummary copyWith(
          void Function(ComprehensiveFinancialSummary) updates) =>
      super.copyWith(
              (message) => updates(message as ComprehensiveFinancialSummary))
          as ComprehensiveFinancialSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ComprehensiveFinancialSummary create() =>
      ComprehensiveFinancialSummary._();
  @$core.override
  ComprehensiveFinancialSummary createEmptyInstance() => create();
  static $pb.PbList<ComprehensiveFinancialSummary> createRepeated() =>
      $pb.PbList<ComprehensiveFinancialSummary>();
  @$core.pragma('dart2js:noInline')
  static ComprehensiveFinancialSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComprehensiveFinancialSummary>(create);
  static ComprehensiveFinancialSummary? _defaultInstance;

  @$pb.TagNumber(1)
  ComprehensivePeriod get period => $_getN(0);
  @$pb.TagNumber(1)
  set period(ComprehensivePeriod value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => $_clearField(1);
  @$pb.TagNumber(1)
  ComprehensivePeriod ensurePeriod() => $_ensure(0);

  @$pb.TagNumber(2)
  ComprehensiveIncomeData get income => $_getN(1);
  @$pb.TagNumber(2)
  set income(ComprehensiveIncomeData value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncome() => $_clearField(2);
  @$pb.TagNumber(2)
  ComprehensiveIncomeData ensureIncome() => $_ensure(1);

  @$pb.TagNumber(3)
  ComprehensiveExpenditureData get expenditure => $_getN(2);
  @$pb.TagNumber(3)
  set expenditure(ComprehensiveExpenditureData value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasExpenditure() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpenditure() => $_clearField(3);
  @$pb.TagNumber(3)
  ComprehensiveExpenditureData ensureExpenditure() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get netIncome => $_getN(3);
  @$pb.TagNumber(4)
  set netIncome($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNetIncome() => $_has(3);
  @$pb.TagNumber(4)
  void clearNetIncome() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get savingsRate => $_getN(4);
  @$pb.TagNumber(5)
  set savingsRate($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSavingsRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearSavingsRate() => $_clearField(5);
}

class ComprehensivePeriod extends $pb.GeneratedMessage {
  factory ComprehensivePeriod({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  ComprehensivePeriod._();

  factory ComprehensivePeriod.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ComprehensivePeriod.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ComprehensivePeriod',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComprehensivePeriod clone() => ComprehensivePeriod()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComprehensivePeriod copyWith(void Function(ComprehensivePeriod) updates) =>
      super.copyWith((message) => updates(message as ComprehensivePeriod))
          as ComprehensivePeriod;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ComprehensivePeriod create() => ComprehensivePeriod._();
  @$core.override
  ComprehensivePeriod createEmptyInstance() => create();
  static $pb.PbList<ComprehensivePeriod> createRepeated() =>
      $pb.PbList<ComprehensivePeriod>();
  @$core.pragma('dart2js:noInline')
  static ComprehensivePeriod getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComprehensivePeriod>(create);
  static ComprehensivePeriod? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);
}

class ComprehensiveIncomeData extends $pb.GeneratedMessage {
  factory ComprehensiveIncomeData({
    $core.double? manualIncome,
    $core.double? trackedIncome,
    $core.double? totalIncome,
    $core.Iterable<$core.MapEntry<$core.String, $core.double>>? incomeBreakdown,
  }) {
    final result = create();
    if (manualIncome != null) result.manualIncome = manualIncome;
    if (trackedIncome != null) result.trackedIncome = trackedIncome;
    if (totalIncome != null) result.totalIncome = totalIncome;
    if (incomeBreakdown != null)
      result.incomeBreakdown.addEntries(incomeBreakdown);
    return result;
  }

  ComprehensiveIncomeData._();

  factory ComprehensiveIncomeData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ComprehensiveIncomeData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ComprehensiveIncomeData',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'manualIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'trackedIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..m<$core.String, $core.double>(4, _omitFieldNames ? '' : 'incomeBreakdown',
        entryClassName: 'ComprehensiveIncomeData.IncomeBreakdownEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComprehensiveIncomeData clone() =>
      ComprehensiveIncomeData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComprehensiveIncomeData copyWith(
          void Function(ComprehensiveIncomeData) updates) =>
      super.copyWith((message) => updates(message as ComprehensiveIncomeData))
          as ComprehensiveIncomeData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ComprehensiveIncomeData create() => ComprehensiveIncomeData._();
  @$core.override
  ComprehensiveIncomeData createEmptyInstance() => create();
  static $pb.PbList<ComprehensiveIncomeData> createRepeated() =>
      $pb.PbList<ComprehensiveIncomeData>();
  @$core.pragma('dart2js:noInline')
  static ComprehensiveIncomeData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComprehensiveIncomeData>(create);
  static ComprehensiveIncomeData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get manualIncome => $_getN(0);
  @$pb.TagNumber(1)
  set manualIncome($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasManualIncome() => $_has(0);
  @$pb.TagNumber(1)
  void clearManualIncome() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get trackedIncome => $_getN(1);
  @$pb.TagNumber(2)
  set trackedIncome($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTrackedIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearTrackedIncome() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalIncome => $_getN(2);
  @$pb.TagNumber(3)
  set totalIncome($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalIncome() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalIncome() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.double> get incomeBreakdown => $_getMap(3);
}

class ComprehensiveExpenditureData extends $pb.GeneratedMessage {
  factory ComprehensiveExpenditureData({
    $core.double? manualExpenses,
    $core.double? trackedExpenditure,
    $core.double? totalExpenditure,
    $core.Iterable<$core.MapEntry<$core.String, $core.double>>?
        expenditureBreakdown,
  }) {
    final result = create();
    if (manualExpenses != null) result.manualExpenses = manualExpenses;
    if (trackedExpenditure != null)
      result.trackedExpenditure = trackedExpenditure;
    if (totalExpenditure != null) result.totalExpenditure = totalExpenditure;
    if (expenditureBreakdown != null)
      result.expenditureBreakdown.addEntries(expenditureBreakdown);
    return result;
  }

  ComprehensiveExpenditureData._();

  factory ComprehensiveExpenditureData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ComprehensiveExpenditureData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ComprehensiveExpenditureData',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'manualExpenses', $pb.PbFieldType.OD)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'trackedExpenditure', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalExpenditure', $pb.PbFieldType.OD)
    ..m<$core.String, $core.double>(
        4, _omitFieldNames ? '' : 'expenditureBreakdown',
        entryClassName:
            'ComprehensiveExpenditureData.ExpenditureBreakdownEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComprehensiveExpenditureData clone() =>
      ComprehensiveExpenditureData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComprehensiveExpenditureData copyWith(
          void Function(ComprehensiveExpenditureData) updates) =>
      super.copyWith(
              (message) => updates(message as ComprehensiveExpenditureData))
          as ComprehensiveExpenditureData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ComprehensiveExpenditureData create() =>
      ComprehensiveExpenditureData._();
  @$core.override
  ComprehensiveExpenditureData createEmptyInstance() => create();
  static $pb.PbList<ComprehensiveExpenditureData> createRepeated() =>
      $pb.PbList<ComprehensiveExpenditureData>();
  @$core.pragma('dart2js:noInline')
  static ComprehensiveExpenditureData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComprehensiveExpenditureData>(create);
  static ComprehensiveExpenditureData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get manualExpenses => $_getN(0);
  @$pb.TagNumber(1)
  set manualExpenses($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasManualExpenses() => $_has(0);
  @$pb.TagNumber(1)
  void clearManualExpenses() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get trackedExpenditure => $_getN(1);
  @$pb.TagNumber(2)
  set trackedExpenditure($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTrackedExpenditure() => $_has(1);
  @$pb.TagNumber(2)
  void clearTrackedExpenditure() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalExpenditure => $_getN(2);
  @$pb.TagNumber(3)
  set totalExpenditure($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalExpenditure() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalExpenditure() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.double> get expenditureBreakdown => $_getMap(3);
}

/// Validate Category Budget Request/Response
class ValidateCategoryBudgetRequest extends $pb.GeneratedMessage {
  factory ValidateCategoryBudgetRequest({
    $core.String? userId,
    $core.int? budgetCategory,
    $fixnum.Int64? amountMinor,
    $core.String? currency,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (budgetCategory != null) result.budgetCategory = budgetCategory;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (currency != null) result.currency = currency;
    return result;
  }

  ValidateCategoryBudgetRequest._();

  factory ValidateCategoryBudgetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidateCategoryBudgetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidateCategoryBudgetRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'budgetCategory', $pb.PbFieldType.O3)
    ..aInt64(3, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateCategoryBudgetRequest clone() =>
      ValidateCategoryBudgetRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateCategoryBudgetRequest copyWith(
          void Function(ValidateCategoryBudgetRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ValidateCategoryBudgetRequest))
          as ValidateCategoryBudgetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateCategoryBudgetRequest create() =>
      ValidateCategoryBudgetRequest._();
  @$core.override
  ValidateCategoryBudgetRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateCategoryBudgetRequest> createRepeated() =>
      $pb.PbList<ValidateCategoryBudgetRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateCategoryBudgetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidateCategoryBudgetRequest>(create);
  static ValidateCategoryBudgetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get budgetCategory => $_getIZ(1);
  @$pb.TagNumber(2)
  set budgetCategory($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBudgetCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearBudgetCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amountMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set amountMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmountMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);
}

class ValidateCategoryBudgetResponse extends $pb.GeneratedMessage {
  factory ValidateCategoryBudgetResponse({
    $core.bool? allowed,
    $core.String? reason,
    $core.double? currentSpent,
    $core.double? budgetLimit,
    $core.double? percentageUsed,
    $core.double? remaining,
    $core.Iterable<BudgetInfo>? matchingBudgets,
  }) {
    final result = create();
    if (allowed != null) result.allowed = allowed;
    if (reason != null) result.reason = reason;
    if (currentSpent != null) result.currentSpent = currentSpent;
    if (budgetLimit != null) result.budgetLimit = budgetLimit;
    if (percentageUsed != null) result.percentageUsed = percentageUsed;
    if (remaining != null) result.remaining = remaining;
    if (matchingBudgets != null) result.matchingBudgets.addAll(matchingBudgets);
    return result;
  }

  ValidateCategoryBudgetResponse._();

  factory ValidateCategoryBudgetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidateCategoryBudgetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidateCategoryBudgetResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'allowed')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'currentSpent', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'budgetLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'percentageUsed', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'remaining', $pb.PbFieldType.OD)
    ..pc<BudgetInfo>(
        7, _omitFieldNames ? '' : 'matchingBudgets', $pb.PbFieldType.PM,
        subBuilder: BudgetInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateCategoryBudgetResponse clone() =>
      ValidateCategoryBudgetResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateCategoryBudgetResponse copyWith(
          void Function(ValidateCategoryBudgetResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ValidateCategoryBudgetResponse))
          as ValidateCategoryBudgetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateCategoryBudgetResponse create() =>
      ValidateCategoryBudgetResponse._();
  @$core.override
  ValidateCategoryBudgetResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateCategoryBudgetResponse> createRepeated() =>
      $pb.PbList<ValidateCategoryBudgetResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateCategoryBudgetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidateCategoryBudgetResponse>(create);
  static ValidateCategoryBudgetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get allowed => $_getBF(0);
  @$pb.TagNumber(1)
  set allowed($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAllowed() => $_has(0);
  @$pb.TagNumber(1)
  void clearAllowed() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get currentSpent => $_getN(2);
  @$pb.TagNumber(3)
  set currentSpent($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentSpent() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentSpent() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get budgetLimit => $_getN(3);
  @$pb.TagNumber(4)
  set budgetLimit($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBudgetLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearBudgetLimit() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get percentageUsed => $_getN(4);
  @$pb.TagNumber(5)
  set percentageUsed($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPercentageUsed() => $_has(4);
  @$pb.TagNumber(5)
  void clearPercentageUsed() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get remaining => $_getN(5);
  @$pb.TagNumber(6)
  set remaining($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRemaining() => $_has(5);
  @$pb.TagNumber(6)
  void clearRemaining() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<BudgetInfo> get matchingBudgets => $_getList(6);
}

class BudgetInfo extends $pb.GeneratedMessage {
  factory BudgetInfo({
    $core.String? budgetId,
    $core.String? budgetName,
    $core.double? amount,
    $core.double? spent,
    $core.double? percentage,
    $core.int? daysRemaining,
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
    $core.String? currency,
  }) {
    final result = create();
    if (budgetId != null) result.budgetId = budgetId;
    if (budgetName != null) result.budgetName = budgetName;
    if (amount != null) result.amount = amount;
    if (spent != null) result.spent = spent;
    if (percentage != null) result.percentage = percentage;
    if (daysRemaining != null) result.daysRemaining = daysRemaining;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (currency != null) result.currency = currency;
    return result;
  }

  BudgetInfo._();

  factory BudgetInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BudgetInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BudgetInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'budgetId')
    ..aOS(2, _omitFieldNames ? '' : 'budgetName')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'spent', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.OD)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BudgetInfo clone() => BudgetInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BudgetInfo copyWith(void Function(BudgetInfo) updates) =>
      super.copyWith((message) => updates(message as BudgetInfo)) as BudgetInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BudgetInfo create() => BudgetInfo._();
  @$core.override
  BudgetInfo createEmptyInstance() => create();
  static $pb.PbList<BudgetInfo> createRepeated() => $pb.PbList<BudgetInfo>();
  @$core.pragma('dart2js:noInline')
  static BudgetInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BudgetInfo>(create);
  static BudgetInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get budgetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set budgetId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBudgetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudgetId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get budgetName => $_getSZ(1);
  @$pb.TagNumber(2)
  set budgetName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBudgetName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBudgetName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get spent => $_getN(3);
  @$pb.TagNumber(4)
  set spent($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSpent() => $_has(3);
  @$pb.TagNumber(4)
  void clearSpent() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get percentage => $_getN(4);
  @$pb.TagNumber(5)
  set percentage($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearPercentage() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get daysRemaining => $_getIZ(5);
  @$pb.TagNumber(6)
  set daysRemaining($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDaysRemaining() => $_has(5);
  @$pb.TagNumber(6)
  void clearDaysRemaining() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get startDate => $_getN(6);
  @$pb.TagNumber(7)
  set startDate($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStartDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearStartDate() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureStartDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get endDate => $_getN(7);
  @$pb.TagNumber(8)
  set endDate($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasEndDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearEndDate() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureEndDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);
}

/// Get Service Categories Request/Response
class GetServiceCategoriesRequest extends $pb.GeneratedMessage {
  factory GetServiceCategoriesRequest({
    $core.String? serviceName,
    $core.bool? activeOnly,
  }) {
    final result = create();
    if (serviceName != null) result.serviceName = serviceName;
    if (activeOnly != null) result.activeOnly = activeOnly;
    return result;
  }

  GetServiceCategoriesRequest._();

  factory GetServiceCategoriesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetServiceCategoriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetServiceCategoriesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOB(2, _omitFieldNames ? '' : 'activeOnly')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetServiceCategoriesRequest clone() =>
      GetServiceCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetServiceCategoriesRequest copyWith(
          void Function(GetServiceCategoriesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetServiceCategoriesRequest))
          as GetServiceCategoriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetServiceCategoriesRequest create() =>
      GetServiceCategoriesRequest._();
  @$core.override
  GetServiceCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<GetServiceCategoriesRequest> createRepeated() =>
      $pb.PbList<GetServiceCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetServiceCategoriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetServiceCategoriesRequest>(create);
  static GetServiceCategoriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get activeOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set activeOnly($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActiveOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveOnly() => $_clearField(2);
}

class GetServiceCategoriesResponse extends $pb.GeneratedMessage {
  factory GetServiceCategoriesResponse({
    $core.Iterable<ServiceCategoryItem>? categories,
    $core.bool? success,
  }) {
    final result = create();
    if (categories != null) result.categories.addAll(categories);
    if (success != null) result.success = success;
    return result;
  }

  GetServiceCategoriesResponse._();

  factory GetServiceCategoriesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetServiceCategoriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetServiceCategoriesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<ServiceCategoryItem>(
        1, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM,
        subBuilder: ServiceCategoryItem.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetServiceCategoriesResponse clone() =>
      GetServiceCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetServiceCategoriesResponse copyWith(
          void Function(GetServiceCategoriesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetServiceCategoriesResponse))
          as GetServiceCategoriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetServiceCategoriesResponse create() =>
      GetServiceCategoriesResponse._();
  @$core.override
  GetServiceCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<GetServiceCategoriesResponse> createRepeated() =>
      $pb.PbList<GetServiceCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetServiceCategoriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetServiceCategoriesResponse>(create);
  static GetServiceCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ServiceCategoryItem> get categories => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);
}

class ServiceCategoryItem extends $pb.GeneratedMessage {
  factory ServiceCategoryItem({
    $core.String? id,
    $core.String? serviceName,
    $core.String? subCategoryName,
    $core.int? budgetCategory,
    $core.String? displayName,
    $core.String? icon,
    $core.String? color,
    $core.bool? isActive,
    $core.bool? isCustom,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (serviceName != null) result.serviceName = serviceName;
    if (subCategoryName != null) result.subCategoryName = subCategoryName;
    if (budgetCategory != null) result.budgetCategory = budgetCategory;
    if (displayName != null) result.displayName = displayName;
    if (icon != null) result.icon = icon;
    if (color != null) result.color = color;
    if (isActive != null) result.isActive = isActive;
    if (isCustom != null) result.isCustom = isCustom;
    return result;
  }

  ServiceCategoryItem._();

  factory ServiceCategoryItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServiceCategoryItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceCategoryItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'serviceName')
    ..aOS(3, _omitFieldNames ? '' : 'subCategoryName')
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'budgetCategory', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'displayName')
    ..aOS(6, _omitFieldNames ? '' : 'icon')
    ..aOS(7, _omitFieldNames ? '' : 'color')
    ..aOB(8, _omitFieldNames ? '' : 'isActive')
    ..aOB(9, _omitFieldNames ? '' : 'isCustom')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceCategoryItem clone() => ServiceCategoryItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceCategoryItem copyWith(void Function(ServiceCategoryItem) updates) =>
      super.copyWith((message) => updates(message as ServiceCategoryItem))
          as ServiceCategoryItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceCategoryItem create() => ServiceCategoryItem._();
  @$core.override
  ServiceCategoryItem createEmptyInstance() => create();
  static $pb.PbList<ServiceCategoryItem> createRepeated() =>
      $pb.PbList<ServiceCategoryItem>();
  @$core.pragma('dart2js:noInline')
  static ServiceCategoryItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceCategoryItem>(create);
  static ServiceCategoryItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get serviceName => $_getSZ(1);
  @$pb.TagNumber(2)
  set serviceName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServiceName() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get subCategoryName => $_getSZ(2);
  @$pb.TagNumber(3)
  set subCategoryName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSubCategoryName() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubCategoryName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get budgetCategory => $_getIZ(3);
  @$pb.TagNumber(4)
  set budgetCategory($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBudgetCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearBudgetCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get displayName => $_getSZ(4);
  @$pb.TagNumber(5)
  set displayName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDisplayName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisplayName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get icon => $_getSZ(5);
  @$pb.TagNumber(6)
  set icon($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIcon() => $_has(5);
  @$pb.TagNumber(6)
  void clearIcon() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get color => $_getSZ(6);
  @$pb.TagNumber(7)
  set color($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasColor() => $_has(6);
  @$pb.TagNumber(7)
  void clearColor() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isActive => $_getBF(7);
  @$pb.TagNumber(8)
  set isActive($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIsActive() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsActive() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isCustom => $_getBF(8);
  @$pb.TagNumber(9)
  set isCustom($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsCustom() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsCustom() => $_clearField(9);
}

/// Custom Category Messages
class CreateCustomCategoryRequest extends $pb.GeneratedMessage {
  factory CreateCustomCategoryRequest({
    $core.String? serviceName,
    $core.String? displayName,
    $core.int? budgetCategory,
    $core.String? icon,
    $core.String? color,
  }) {
    final result = create();
    if (serviceName != null) result.serviceName = serviceName;
    if (displayName != null) result.displayName = displayName;
    if (budgetCategory != null) result.budgetCategory = budgetCategory;
    if (icon != null) result.icon = icon;
    if (color != null) result.color = color;
    return result;
  }

  CreateCustomCategoryRequest._();

  factory CreateCustomCategoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateCustomCategoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateCustomCategoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'budgetCategory', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'icon')
    ..aOS(5, _omitFieldNames ? '' : 'color')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCustomCategoryRequest clone() =>
      CreateCustomCategoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCustomCategoryRequest copyWith(
          void Function(CreateCustomCategoryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateCustomCategoryRequest))
          as CreateCustomCategoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateCustomCategoryRequest create() =>
      CreateCustomCategoryRequest._();
  @$core.override
  CreateCustomCategoryRequest createEmptyInstance() => create();
  static $pb.PbList<CreateCustomCategoryRequest> createRepeated() =>
      $pb.PbList<CreateCustomCategoryRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateCustomCategoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCustomCategoryRequest>(create);
  static CreateCustomCategoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get budgetCategory => $_getIZ(2);
  @$pb.TagNumber(3)
  set budgetCategory($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBudgetCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearBudgetCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get icon => $_getSZ(3);
  @$pb.TagNumber(4)
  set icon($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIcon() => $_has(3);
  @$pb.TagNumber(4)
  void clearIcon() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get color => $_getSZ(4);
  @$pb.TagNumber(5)
  set color($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasColor() => $_has(4);
  @$pb.TagNumber(5)
  void clearColor() => $_clearField(5);
}

class CreateCustomCategoryResponse extends $pb.GeneratedMessage {
  factory CreateCustomCategoryResponse({
    $core.bool? success,
    $core.String? message,
    ServiceCategoryItem? category,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (category != null) result.category = category;
    return result;
  }

  CreateCustomCategoryResponse._();

  factory CreateCustomCategoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateCustomCategoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateCustomCategoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<ServiceCategoryItem>(3, _omitFieldNames ? '' : 'category',
        subBuilder: ServiceCategoryItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCustomCategoryResponse clone() =>
      CreateCustomCategoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCustomCategoryResponse copyWith(
          void Function(CreateCustomCategoryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateCustomCategoryResponse))
          as CreateCustomCategoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateCustomCategoryResponse create() =>
      CreateCustomCategoryResponse._();
  @$core.override
  CreateCustomCategoryResponse createEmptyInstance() => create();
  static $pb.PbList<CreateCustomCategoryResponse> createRepeated() =>
      $pb.PbList<CreateCustomCategoryResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateCustomCategoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCustomCategoryResponse>(create);
  static CreateCustomCategoryResponse? _defaultInstance;

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
  ServiceCategoryItem get category => $_getN(2);
  @$pb.TagNumber(3)
  set category(ServiceCategoryItem value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);
  @$pb.TagNumber(3)
  ServiceCategoryItem ensureCategory() => $_ensure(2);
}

class DeleteCustomCategoryRequest extends $pb.GeneratedMessage {
  factory DeleteCustomCategoryRequest({
    $core.String? categoryId,
  }) {
    final result = create();
    if (categoryId != null) result.categoryId = categoryId;
    return result;
  }

  DeleteCustomCategoryRequest._();

  factory DeleteCustomCategoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteCustomCategoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteCustomCategoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'categoryId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCustomCategoryRequest clone() =>
      DeleteCustomCategoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCustomCategoryRequest copyWith(
          void Function(DeleteCustomCategoryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteCustomCategoryRequest))
          as DeleteCustomCategoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteCustomCategoryRequest create() =>
      DeleteCustomCategoryRequest._();
  @$core.override
  DeleteCustomCategoryRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteCustomCategoryRequest> createRepeated() =>
      $pb.PbList<DeleteCustomCategoryRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteCustomCategoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCustomCategoryRequest>(create);
  static DeleteCustomCategoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get categoryId => $_getSZ(0);
  @$pb.TagNumber(1)
  set categoryId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategoryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategoryId() => $_clearField(1);
}

class DeleteCustomCategoryResponse extends $pb.GeneratedMessage {
  factory DeleteCustomCategoryResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteCustomCategoryResponse._();

  factory DeleteCustomCategoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteCustomCategoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteCustomCategoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCustomCategoryResponse clone() =>
      DeleteCustomCategoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCustomCategoryResponse copyWith(
          void Function(DeleteCustomCategoryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteCustomCategoryResponse))
          as DeleteCustomCategoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteCustomCategoryResponse create() =>
      DeleteCustomCategoryResponse._();
  @$core.override
  DeleteCustomCategoryResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteCustomCategoryResponse> createRepeated() =>
      $pb.PbList<DeleteCustomCategoryResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteCustomCategoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCustomCategoryResponse>(create);
  static DeleteCustomCategoryResponse? _defaultInstance;

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
