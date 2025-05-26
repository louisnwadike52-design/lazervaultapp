//
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $16;
import 'transfer.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'transfer.pbenum.dart';

/// Main Transfer Transaction message
class TransferTransaction extends $pb.GeneratedMessage {
  factory TransferTransaction({
    $core.String? transactionId,
    $fixnum.Int64? fromAccountId,
    $fixnum.Int64? toAccountId,
    $core.String? toRecipientId,
    $core.double? amount,
    $core.String? currency,
    TransferType? transferType,
    $core.String? category,
    $core.String? description,
    $16.Timestamp? createdAt,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (fromAccountId != null) {
      $result.fromAccountId = fromAccountId;
    }
    if (toAccountId != null) {
      $result.toAccountId = toAccountId;
    }
    if (toRecipientId != null) {
      $result.toRecipientId = toRecipientId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (transferType != null) {
      $result.transferType = transferType;
    }
    if (category != null) {
      $result.category = category;
    }
    if (description != null) {
      $result.description = description;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  TransferTransaction._() : super();
  factory TransferTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'fromAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'toAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'toRecipientId')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..e<TransferType>(7, _omitFieldNames ? '' : 'transferType', $pb.PbFieldType.OE, defaultOrMaker: TransferType.TRANSFER_TYPE_UNSPECIFIED, valueOf: TransferType.valueOf, enumValues: TransferType.values)
    ..aOS(8, _omitFieldNames ? '' : 'category')
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..aOM<$16.Timestamp>(10, _omitFieldNames ? '' : 'createdAt', subBuilder: $16.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferTransaction clone() => TransferTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferTransaction copyWith(void Function(TransferTransaction) updates) => super.copyWith((message) => updates(message as TransferTransaction)) as TransferTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferTransaction create() => TransferTransaction._();
  TransferTransaction createEmptyInstance() => create();
  static $pb.PbList<TransferTransaction> createRepeated() => $pb.PbList<TransferTransaction>();
  @$core.pragma('dart2js:noInline')
  static TransferTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferTransaction>(create);
  static TransferTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get fromAccountId => $_getI64(1);
  @$pb.TagNumber(2)
  set fromAccountId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get toAccountId => $_getI64(2);
  @$pb.TagNumber(3)
  set toAccountId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get toRecipientId => $_getSZ(3);
  @$pb.TagNumber(4)
  set toRecipientId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasToRecipientId() => $_has(3);
  @$pb.TagNumber(4)
  void clearToRecipientId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  TransferType get transferType => $_getN(6);
  @$pb.TagNumber(7)
  set transferType(TransferType v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasTransferType() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransferType() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get category => $_getSZ(7);
  @$pb.TagNumber(8)
  set category($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCategory() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategory() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => $_clearField(9);

  @$pb.TagNumber(10)
  $16.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($16.Timestamp v) { $_setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $16.Timestamp ensureCreatedAt() => $_ensure(9);
}

/// Request message for initiating a transfer
class InitiateTransferRequest extends $pb.GeneratedMessage {
  factory InitiateTransferRequest({
    $fixnum.Int64? fromAccountId,
    $fixnum.Int64? amount,
    $core.String? category,
    $core.String? reference,
    $16.Timestamp? scheduledAt,
    $fixnum.Int64? toAccountId,
    $fixnum.Int64? recipientId,
  }) {
    final $result = create();
    if (fromAccountId != null) {
      $result.fromAccountId = fromAccountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (category != null) {
      $result.category = category;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (scheduledAt != null) {
      $result.scheduledAt = scheduledAt;
    }
    if (toAccountId != null) {
      $result.toAccountId = toAccountId;
    }
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    return $result;
  }
  InitiateTransferRequest._() : super();
  factory InitiateTransferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateTransferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateTransferRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'from_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOM<$16.Timestamp>(5, _omitFieldNames ? '' : 'scheduledAt', subBuilder: $16.Timestamp.create)
    ..a<$fixnum.Int64>(10, _omitFieldNames ? '' : 'to_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(11, _omitFieldNames ? '' : 'recipient_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateTransferRequest clone() => InitiateTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateTransferRequest copyWith(void Function(InitiateTransferRequest) updates) => super.copyWith((message) => updates(message as InitiateTransferRequest)) as InitiateTransferRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateTransferRequest create() => InitiateTransferRequest._();
  InitiateTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateTransferRequest> createRepeated() => $pb.PbList<InitiateTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateTransferRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateTransferRequest>(create);
  static InitiateTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get fromAccountId => $_getI64(0);
  @$pb.TagNumber(1)
  set fromAccountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $16.Timestamp get scheduledAt => $_getN(4);
  @$pb.TagNumber(5)
  set scheduledAt($16.Timestamp v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasScheduledAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearScheduledAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $16.Timestamp ensureScheduledAt() => $_ensure(4);

  /// --- Destination (Use ONE of the following) ---
  @$pb.TagNumber(10)
  $fixnum.Int64 get toAccountId => $_getI64(5);
  @$pb.TagNumber(10)
  set toAccountId($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(10)
  $core.bool hasToAccountId() => $_has(5);
  @$pb.TagNumber(10)
  void clearToAccountId() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get recipientId => $_getI64(6);
  @$pb.TagNumber(11)
  set recipientId($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(11)
  $core.bool hasRecipientId() => $_has(6);
  @$pb.TagNumber(11)
  void clearRecipientId() => $_clearField(11);
}

/// Response message for initiating a transfer
class InitiateTransferResponse extends $pb.GeneratedMessage {
  factory InitiateTransferResponse({
    $fixnum.Int64? transferId,
    $core.String? status,
    $fixnum.Int64? amount,
    $fixnum.Int64? fee,
    $fixnum.Int64? totalAmount,
    $16.Timestamp? createdAt,
  }) {
    final $result = create();
    if (transferId != null) {
      $result.transferId = transferId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (amount != null) {
      $result.amount = amount;
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
    return $result;
  }
  InitiateTransferResponse._() : super();
  factory InitiateTransferResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateTransferResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateTransferResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'transferId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$16.Timestamp>(6, _omitFieldNames ? '' : 'createdAt', subBuilder: $16.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateTransferResponse clone() => InitiateTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateTransferResponse copyWith(void Function(InitiateTransferResponse) updates) => super.copyWith((message) => updates(message as InitiateTransferResponse)) as InitiateTransferResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateTransferResponse create() => InitiateTransferResponse._();
  InitiateTransferResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateTransferResponse> createRepeated() => $pb.PbList<InitiateTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateTransferResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateTransferResponse>(create);
  static InitiateTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get transferId => $_getI64(0);
  @$pb.TagNumber(1)
  set transferId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransferId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get fee => $_getI64(3);
  @$pb.TagNumber(4)
  set fee($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearFee() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalAmount => $_getI64(4);
  @$pb.TagNumber(5)
  set totalAmount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $16.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($16.Timestamp v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $16.Timestamp ensureCreatedAt() => $_ensure(5);
}

/// Represents a single point in a time series chart
class TimeSeriesPoint extends $pb.GeneratedMessage {
  factory TimeSeriesPoint({
    $16.Timestamp? timestamp,
    $core.double? amount,
  }) {
    final $result = create();
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    return $result;
  }
  TimeSeriesPoint._() : super();
  factory TimeSeriesPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimeSeriesPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TimeSeriesPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$16.Timestamp>(1, _omitFieldNames ? '' : 'timestamp', subBuilder: $16.Timestamp.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimeSeriesPoint clone() => TimeSeriesPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimeSeriesPoint copyWith(void Function(TimeSeriesPoint) updates) => super.copyWith((message) => updates(message as TimeSeriesPoint)) as TimeSeriesPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimeSeriesPoint create() => TimeSeriesPoint._();
  TimeSeriesPoint createEmptyInstance() => create();
  static $pb.PbList<TimeSeriesPoint> createRepeated() => $pb.PbList<TimeSeriesPoint>();
  @$core.pragma('dart2js:noInline')
  static TimeSeriesPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimeSeriesPoint>(create);
  static TimeSeriesPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $16.Timestamp get timestamp => $_getN(0);
  @$pb.TagNumber(1)
  set timestamp($16.Timestamp v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => $_clearField(1);
  @$pb.TagNumber(1)
  $16.Timestamp ensureTimestamp() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);
}

/// Represents summary data for a specific category
class CategorySummary extends $pb.GeneratedMessage {
  factory CategorySummary({
    $core.String? category,
    $core.double? amount,
    $core.double? percentage,
  }) {
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (percentage != null) {
      $result.percentage = percentage;
    }
    return $result;
  }
  CategorySummary._() : super();
  factory CategorySummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CategorySummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CategorySummary', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CategorySummary clone() => CategorySummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CategorySummary copyWith(void Function(CategorySummary) updates) => super.copyWith((message) => updates(message as CategorySummary)) as CategorySummary;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CategorySummary create() => CategorySummary._();
  CategorySummary createEmptyInstance() => create();
  static $pb.PbList<CategorySummary> createRepeated() => $pb.PbList<CategorySummary>();
  @$core.pragma('dart2js:noInline')
  static CategorySummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CategorySummary>(create);
  static CategorySummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  /// string subcategory = 2; // Optional: Add if subcategory breakdown is needed
  @$pb.TagNumber(3)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get percentage => $_getN(2);
  @$pb.TagNumber(4)
  set percentage($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(2);
  @$pb.TagNumber(4)
  void clearPercentage() => $_clearField(4);
}

/// Represents aggregated data for a single month
class MonthlyData extends $pb.GeneratedMessage {
  factory MonthlyData({
    $core.String? month,
    $core.double? income,
    $core.double? expenses,
  }) {
    final $result = create();
    if (month != null) {
      $result.month = month;
    }
    if (income != null) {
      $result.income = income;
    }
    if (expenses != null) {
      $result.expenses = expenses;
    }
    return $result;
  }
  MonthlyData._() : super();
  factory MonthlyData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonthlyData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonthlyData', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'month')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'income', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'expenses', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonthlyData clone() => MonthlyData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonthlyData copyWith(void Function(MonthlyData) updates) => super.copyWith((message) => updates(message as MonthlyData)) as MonthlyData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonthlyData create() => MonthlyData._();
  MonthlyData createEmptyInstance() => create();
  static $pb.PbList<MonthlyData> createRepeated() => $pb.PbList<MonthlyData>();
  @$core.pragma('dart2js:noInline')
  static MonthlyData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonthlyData>(create);
  static MonthlyData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get month => $_getSZ(0);
  @$pb.TagNumber(1)
  set month($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMonth() => $_has(0);
  @$pb.TagNumber(1)
  void clearMonth() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get income => $_getN(1);
  @$pb.TagNumber(2)
  set income($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncome() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get expenses => $_getN(2);
  @$pb.TagNumber(3)
  set expenses($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpenses() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpenses() => $_clearField(3);
}

/// Represents data for month-over-month comparison
class ComparisonData extends $pb.GeneratedMessage {
  factory ComparisonData({
    $core.double? currentIncome,
    $core.double? previousIncome,
    $core.double? currentExpenses,
    $core.double? previousExpenses,
    $core.double? currentSavings,
    $core.double? previousSavings,
  }) {
    final $result = create();
    if (currentIncome != null) {
      $result.currentIncome = currentIncome;
    }
    if (previousIncome != null) {
      $result.previousIncome = previousIncome;
    }
    if (currentExpenses != null) {
      $result.currentExpenses = currentExpenses;
    }
    if (previousExpenses != null) {
      $result.previousExpenses = previousExpenses;
    }
    if (currentSavings != null) {
      $result.currentSavings = currentSavings;
    }
    if (previousSavings != null) {
      $result.previousSavings = previousSavings;
    }
    return $result;
  }
  ComparisonData._() : super();
  factory ComparisonData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComparisonData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ComparisonData', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'currentIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'previousIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'currentExpenses', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'previousExpenses', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'currentSavings', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'previousSavings', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComparisonData clone() => ComparisonData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComparisonData copyWith(void Function(ComparisonData) updates) => super.copyWith((message) => updates(message as ComparisonData)) as ComparisonData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ComparisonData create() => ComparisonData._();
  ComparisonData createEmptyInstance() => create();
  static $pb.PbList<ComparisonData> createRepeated() => $pb.PbList<ComparisonData>();
  @$core.pragma('dart2js:noInline')
  static ComparisonData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComparisonData>(create);
  static ComparisonData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get currentIncome => $_getN(0);
  @$pb.TagNumber(1)
  set currentIncome($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentIncome() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentIncome() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get previousIncome => $_getN(1);
  @$pb.TagNumber(2)
  set previousIncome($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPreviousIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreviousIncome() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get currentExpenses => $_getN(2);
  @$pb.TagNumber(3)
  set currentExpenses($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentExpenses() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentExpenses() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get previousExpenses => $_getN(3);
  @$pb.TagNumber(4)
  set previousExpenses($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPreviousExpenses() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreviousExpenses() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentSavings => $_getN(4);
  @$pb.TagNumber(5)
  set currentSavings($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentSavings() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentSavings() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get previousSavings => $_getN(5);
  @$pb.TagNumber(6)
  set previousSavings($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPreviousSavings() => $_has(5);
  @$pb.TagNumber(6)
  void clearPreviousSavings() => $_clearField(6);
}

/// Request message for fetching statistics
class GetStatisticsRequest extends $pb.GeneratedMessage {
  factory GetStatisticsRequest({
    TimePeriod? timePeriod,
    $core.String? currency,
  }) {
    final $result = create();
    if (timePeriod != null) {
      $result.timePeriod = timePeriod;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    return $result;
  }
  GetStatisticsRequest._() : super();
  factory GetStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStatisticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..e<TimePeriod>(1, _omitFieldNames ? '' : 'timePeriod', $pb.PbFieldType.OE, defaultOrMaker: TimePeriod.TIME_PERIOD_UNSPECIFIED, valueOf: TimePeriod.valueOf, enumValues: TimePeriod.values)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStatisticsRequest clone() => GetStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStatisticsRequest copyWith(void Function(GetStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetStatisticsRequest)) as GetStatisticsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStatisticsRequest create() => GetStatisticsRequest._();
  GetStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetStatisticsRequest> createRepeated() => $pb.PbList<GetStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStatisticsRequest>(create);
  static GetStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TimePeriod get timePeriod => $_getN(0);
  @$pb.TagNumber(1)
  set timePeriod(TimePeriod v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimePeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimePeriod() => $_clearField(1);

  /// google.protobuf.Timestamp start_date = 2; // Alternative to TimePeriod
  /// google.protobuf.Timestamp end_date = 3;   // Alternative to TimePeriod
  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);
}

/// Response message containing calculated statistics
class GetStatisticsResponse extends $pb.GeneratedMessage {
  factory GetStatisticsResponse({
    $core.double? totalIncome,
    $core.double? totalExpenses,
    $core.Iterable<TimeSeriesPoint>? expenseTimeseries,
    $core.Iterable<CategorySummary>? expenseBreakdown,
    $core.Iterable<CategorySummary>? incomeBreakdown,
    $core.Iterable<MonthlyData>? monthlyOverview,
    ComparisonData? comparisonMetrics,
  }) {
    final $result = create();
    if (totalIncome != null) {
      $result.totalIncome = totalIncome;
    }
    if (totalExpenses != null) {
      $result.totalExpenses = totalExpenses;
    }
    if (expenseTimeseries != null) {
      $result.expenseTimeseries.addAll(expenseTimeseries);
    }
    if (expenseBreakdown != null) {
      $result.expenseBreakdown.addAll(expenseBreakdown);
    }
    if (incomeBreakdown != null) {
      $result.incomeBreakdown.addAll(incomeBreakdown);
    }
    if (monthlyOverview != null) {
      $result.monthlyOverview.addAll(monthlyOverview);
    }
    if (comparisonMetrics != null) {
      $result.comparisonMetrics = comparisonMetrics;
    }
    return $result;
  }
  GetStatisticsResponse._() : super();
  factory GetStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStatisticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalExpenses', $pb.PbFieldType.OD)
    ..pc<TimeSeriesPoint>(3, _omitFieldNames ? '' : 'expenseTimeseries', $pb.PbFieldType.PM, subBuilder: TimeSeriesPoint.create)
    ..pc<CategorySummary>(4, _omitFieldNames ? '' : 'expenseBreakdown', $pb.PbFieldType.PM, subBuilder: CategorySummary.create)
    ..pc<CategorySummary>(5, _omitFieldNames ? '' : 'incomeBreakdown', $pb.PbFieldType.PM, subBuilder: CategorySummary.create)
    ..pc<MonthlyData>(6, _omitFieldNames ? '' : 'monthlyOverview', $pb.PbFieldType.PM, subBuilder: MonthlyData.create)
    ..aOM<ComparisonData>(7, _omitFieldNames ? '' : 'comparisonMetrics', subBuilder: ComparisonData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStatisticsResponse clone() => GetStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStatisticsResponse copyWith(void Function(GetStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetStatisticsResponse)) as GetStatisticsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStatisticsResponse create() => GetStatisticsResponse._();
  GetStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetStatisticsResponse> createRepeated() => $pb.PbList<GetStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStatisticsResponse>(create);
  static GetStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalIncome => $_getN(0);
  @$pb.TagNumber(1)
  set totalIncome($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalIncome() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalIncome() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalExpenses => $_getN(1);
  @$pb.TagNumber(2)
  set totalExpenses($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalExpenses() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalExpenses() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<TimeSeriesPoint> get expenseTimeseries => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<CategorySummary> get expenseBreakdown => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<CategorySummary> get incomeBreakdown => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<MonthlyData> get monthlyOverview => $_getList(5);

  @$pb.TagNumber(7)
  ComparisonData get comparisonMetrics => $_getN(6);
  @$pb.TagNumber(7)
  set comparisonMetrics(ComparisonData v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasComparisonMetrics() => $_has(6);
  @$pb.TagNumber(7)
  void clearComparisonMetrics() => $_clearField(7);
  @$pb.TagNumber(7)
  ComparisonData ensureComparisonMetrics() => $_ensure(6);
}

class PaginationInfo extends $pb.GeneratedMessage {
  factory PaginationInfo({
    $core.int? currentPage,
    $core.int? pageSize,
    $core.int? totalPages,
    $fixnum.Int64? totalItems,
  }) {
    final $result = create();
    if (currentPage != null) {
      $result.currentPage = currentPage;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (totalPages != null) {
      $result.totalPages = totalPages;
    }
    if (totalItems != null) {
      $result.totalItems = totalItems;
    }
    return $result;
  }
  PaginationInfo._() : super();
  factory PaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaginationInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..aInt64(4, _omitFieldNames ? '' : 'totalItems')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginationInfo clone() => PaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginationInfo copyWith(void Function(PaginationInfo) updates) => super.copyWith((message) => updates(message as PaginationInfo)) as PaginationInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginationInfo create() => PaginationInfo._();
  PaginationInfo createEmptyInstance() => create();
  static $pb.PbList<PaginationInfo> createRepeated() => $pb.PbList<PaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static PaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaginationInfo>(create);
  static PaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalPages => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalPages($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalPages() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPages() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalItems => $_getI64(3);
  @$pb.TagNumber(4)
  set totalItems($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalItems() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalItems() => $_clearField(4);
}

/// Request message for fetching transaction history
class GetTransactionsRequest extends $pb.GeneratedMessage {
  factory GetTransactionsRequest({
    $fixnum.Int64? accountId,
    $core.String? cardId,
    $16.Timestamp? startDate,
    $16.Timestamp? endDate,
    TransferType? transferType,
    $core.String? category,
    $core.int? pageNumber,
    $core.int? pageSize,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (cardId != null) {
      $result.cardId = cardId;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (transferType != null) {
      $result.transferType = transferType;
    }
    if (category != null) {
      $result.category = category;
    }
    if (pageNumber != null) {
      $result.pageNumber = pageNumber;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  GetTransactionsRequest._() : super();
  factory GetTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'cardId')
    ..aOM<$16.Timestamp>(3, _omitFieldNames ? '' : 'startDate', subBuilder: $16.Timestamp.create)
    ..aOM<$16.Timestamp>(4, _omitFieldNames ? '' : 'endDate', subBuilder: $16.Timestamp.create)
    ..e<TransferType>(5, _omitFieldNames ? '' : 'transferType', $pb.PbFieldType.OE, defaultOrMaker: TransferType.TRANSFER_TYPE_UNSPECIFIED, valueOf: TransferType.valueOf, enumValues: TransferType.values)
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'pageNumber', $pb.PbFieldType.O3)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
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

  /// Filtering Options
  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardId() => $_clearField(2);

  @$pb.TagNumber(3)
  $16.Timestamp get startDate => $_getN(2);
  @$pb.TagNumber(3)
  set startDate($16.Timestamp v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $16.Timestamp ensureStartDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $16.Timestamp get endDate => $_getN(3);
  @$pb.TagNumber(4)
  set endDate($16.Timestamp v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => $_clearField(4);
  @$pb.TagNumber(4)
  $16.Timestamp ensureEndDate() => $_ensure(3);

  @$pb.TagNumber(5)
  TransferType get transferType => $_getN(4);
  @$pb.TagNumber(5)
  set transferType(TransferType v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransferType() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransferType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => $_clearField(6);

  /// Pagination Options
  @$pb.TagNumber(10)
  $core.int get pageNumber => $_getIZ(6);
  @$pb.TagNumber(10)
  set pageNumber($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(10)
  $core.bool hasPageNumber() => $_has(6);
  @$pb.TagNumber(10)
  void clearPageNumber() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get pageSize => $_getIZ(7);
  @$pb.TagNumber(11)
  set pageSize($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(11)
  $core.bool hasPageSize() => $_has(7);
  @$pb.TagNumber(11)
  void clearPageSize() => $_clearField(11);
}

/// Response message containing transaction history
class GetTransactionsResponse extends $pb.GeneratedMessage {
  factory GetTransactionsResponse({
    $core.Iterable<TransferTransaction>? transactions,
    PaginationInfo? pagination,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  GetTransactionsResponse._() : super();
  factory GetTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TransferTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: TransferTransaction.create)
    ..aOM<PaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: PaginationInfo.create)
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
  $pb.PbList<TransferTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaginationInfo v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PaginationInfo ensurePagination() => $_ensure(1);
}

/// Request message for getting transfer details
class GetTransferDetailsRequest extends $pb.GeneratedMessage {
  factory GetTransferDetailsRequest({
    $fixnum.Int64? transferId,
  }) {
    final $result = create();
    if (transferId != null) {
      $result.transferId = transferId;
    }
    return $result;
  }
  GetTransferDetailsRequest._() : super();
  factory GetTransferDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransferDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransferDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'transfer_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransferDetailsRequest clone() => GetTransferDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransferDetailsRequest copyWith(void Function(GetTransferDetailsRequest) updates) => super.copyWith((message) => updates(message as GetTransferDetailsRequest)) as GetTransferDetailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferDetailsRequest create() => GetTransferDetailsRequest._();
  GetTransferDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransferDetailsRequest> createRepeated() => $pb.PbList<GetTransferDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransferDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransferDetailsRequest>(create);
  static GetTransferDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get transferId => $_getI64(0);
  @$pb.TagNumber(1)
  set transferId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransferId() => $_clearField(1);
}

/// Response message containing transfer details
class GetTransferDetailsResponse extends $pb.GeneratedMessage {
  factory GetTransferDetailsResponse({
    $fixnum.Int64? transferId,
    $fixnum.Int64? fromAccountId,
    $fixnum.Int64? toAccountId,
    $fixnum.Int64? fromUserId,
    $fixnum.Int64? toUserId,
    $fixnum.Int64? amount,
    $fixnum.Int64? fee,
    $fixnum.Int64? totalAmount,
    $core.String? currency,
    $core.String? status,
    $core.String? reference,
    $core.String? category,
    $16.Timestamp? createdAt,
    $16.Timestamp? scheduledAt,
    $16.Timestamp? completedAt,
    $16.Timestamp? failedAt,
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
    if (fromUserId != null) {
      $result.fromUserId = fromUserId;
    }
    if (toUserId != null) {
      $result.toUserId = toUserId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (fee != null) {
      $result.fee = fee;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (status != null) {
      $result.status = status;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (category != null) {
      $result.category = category;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (scheduledAt != null) {
      $result.scheduledAt = scheduledAt;
    }
    if (completedAt != null) {
      $result.completedAt = completedAt;
    }
    if (failedAt != null) {
      $result.failedAt = failedAt;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    return $result;
  }
  GetTransferDetailsResponse._() : super();
  factory GetTransferDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransferDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransferDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'transfer_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'from_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'to_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'from_user_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'to_user_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..aOS(10, _omitFieldNames ? '' : 'status')
    ..aOS(11, _omitFieldNames ? '' : 'reference')
    ..aOS(12, _omitFieldNames ? '' : 'category')
    ..aOM<$16.Timestamp>(13, _omitFieldNames ? '' : 'created_at', subBuilder: $16.Timestamp.create)
    ..aOM<$16.Timestamp>(14, _omitFieldNames ? '' : 'scheduled_at', subBuilder: $16.Timestamp.create)
    ..aOM<$16.Timestamp>(15, _omitFieldNames ? '' : 'completed_at', subBuilder: $16.Timestamp.create)
    ..aOM<$16.Timestamp>(16, _omitFieldNames ? '' : 'failed_at', subBuilder: $16.Timestamp.create)
    ..aOS(17, _omitFieldNames ? '' : 'failure_reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransferDetailsResponse clone() => GetTransferDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransferDetailsResponse copyWith(void Function(GetTransferDetailsResponse) updates) => super.copyWith((message) => updates(message as GetTransferDetailsResponse)) as GetTransferDetailsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferDetailsResponse create() => GetTransferDetailsResponse._();
  GetTransferDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransferDetailsResponse> createRepeated() => $pb.PbList<GetTransferDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransferDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransferDetailsResponse>(create);
  static GetTransferDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get transferId => $_getI64(0);
  @$pb.TagNumber(1)
  set transferId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransferId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get fromAccountId => $_getI64(1);
  @$pb.TagNumber(2)
  set fromAccountId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get toAccountId => $_getI64(2);
  @$pb.TagNumber(3)
  set toAccountId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get fromUserId => $_getI64(3);
  @$pb.TagNumber(4)
  set fromUserId($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFromUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get toUserId => $_getI64(4);
  @$pb.TagNumber(5)
  set toUserId($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasToUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearToUserId() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amount => $_getI64(5);
  @$pb.TagNumber(6)
  set amount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get fee => $_getI64(6);
  @$pb.TagNumber(7)
  set fee($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFee() => $_has(6);
  @$pb.TagNumber(7)
  void clearFee() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalAmount => $_getI64(7);
  @$pb.TagNumber(8)
  set totalAmount($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get reference => $_getSZ(10);
  @$pb.TagNumber(11)
  set reference($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearReference() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get category => $_getSZ(11);
  @$pb.TagNumber(12)
  set category($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCategory() => $_has(11);
  @$pb.TagNumber(12)
  void clearCategory() => $_clearField(12);

  @$pb.TagNumber(13)
  $16.Timestamp get createdAt => $_getN(12);
  @$pb.TagNumber(13)
  set createdAt($16.Timestamp v) { $_setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $16.Timestamp ensureCreatedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $16.Timestamp get scheduledAt => $_getN(13);
  @$pb.TagNumber(14)
  set scheduledAt($16.Timestamp v) { $_setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasScheduledAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearScheduledAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $16.Timestamp ensureScheduledAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $16.Timestamp get completedAt => $_getN(14);
  @$pb.TagNumber(15)
  set completedAt($16.Timestamp v) { $_setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasCompletedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCompletedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $16.Timestamp ensureCompletedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $16.Timestamp get failedAt => $_getN(15);
  @$pb.TagNumber(16)
  set failedAt($16.Timestamp v) { $_setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasFailedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailedAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $16.Timestamp ensureFailedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.String get failureReason => $_getSZ(16);
  @$pb.TagNumber(17)
  set failureReason($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasFailureReason() => $_has(16);
  @$pb.TagNumber(17)
  void clearFailureReason() => $_clearField(17);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
