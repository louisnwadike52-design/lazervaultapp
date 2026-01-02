///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $34;

import 'transfer.pbenum.dart';

export 'transfer.pbenum.dart';

class TransferTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fromAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toRecipientId')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<TransferType>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferType', $pb.PbFieldType.OE, defaultOrMaker: TransferType.TRANSFER_TYPE_UNSPECIFIED, valueOf: TransferType.valueOf, enumValues: TransferType.values)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOM<$34.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $34.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TransferTransaction._() : super();
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
    $34.Timestamp? createdAt,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (fromAccountId != null) {
      _result.fromAccountId = fromAccountId;
    }
    if (toAccountId != null) {
      _result.toAccountId = toAccountId;
    }
    if (toRecipientId != null) {
      _result.toRecipientId = toRecipientId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (transferType != null) {
      _result.transferType = transferType;
    }
    if (category != null) {
      _result.category = category;
    }
    if (description != null) {
      _result.description = description;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory TransferTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferTransaction clone() => TransferTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferTransaction copyWith(void Function(TransferTransaction) updates) => super.copyWith((message) => updates(message as TransferTransaction)) as TransferTransaction; // ignore: deprecated_member_use
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
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get fromAccountId => $_getI64(1);
  @$pb.TagNumber(2)
  set fromAccountId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get toAccountId => $_getI64(2);
  @$pb.TagNumber(3)
  set toAccountId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get toRecipientId => $_getSZ(3);
  @$pb.TagNumber(4)
  set toRecipientId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasToRecipientId() => $_has(3);
  @$pb.TagNumber(4)
  void clearToRecipientId() => clearField(4);

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
  TransferType get transferType => $_getN(6);
  @$pb.TagNumber(7)
  set transferType(TransferType v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasTransferType() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransferType() => clearField(7);

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
  $34.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($34.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $34.Timestamp ensureCreatedAt() => $_ensure(9);
}

class InitiateTransferRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateTransferRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduledAt')
    ..a<$fixnum.Int64>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'to_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipient_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  InitiateTransferRequest._() : super();
  factory InitiateTransferRequest({
    $fixnum.Int64? fromAccountId,
    $fixnum.Int64? amount,
    $core.String? category,
    $core.String? reference,
    $core.String? scheduledAt,
    $fixnum.Int64? toAccountId,
    $fixnum.Int64? recipientId,
  }) {
    final _result = create();
    if (fromAccountId != null) {
      _result.fromAccountId = fromAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (category != null) {
      _result.category = category;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (scheduledAt != null) {
      _result.scheduledAt = scheduledAt;
    }
    if (toAccountId != null) {
      _result.toAccountId = toAccountId;
    }
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    return _result;
  }
  factory InitiateTransferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateTransferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateTransferRequest clone() => InitiateTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateTransferRequest copyWith(void Function(InitiateTransferRequest) updates) => super.copyWith((message) => updates(message as InitiateTransferRequest)) as InitiateTransferRequest; // ignore: deprecated_member_use
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
  void clearFromAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get scheduledAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set scheduledAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasScheduledAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearScheduledAt() => clearField(5);

  @$pb.TagNumber(10)
  $fixnum.Int64 get toAccountId => $_getI64(5);
  @$pb.TagNumber(10)
  set toAccountId($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(10)
  $core.bool hasToAccountId() => $_has(5);
  @$pb.TagNumber(10)
  void clearToAccountId() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get recipientId => $_getI64(6);
  @$pb.TagNumber(11)
  set recipientId($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(11)
  $core.bool hasRecipientId() => $_has(6);
  @$pb.TagNumber(11)
  void clearRecipientId() => clearField(11);
}

class InitiateTransferResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateTransferResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$34.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $34.Timestamp.create)
    ..hasRequiredFields = false
  ;

  InitiateTransferResponse._() : super();
  factory InitiateTransferResponse({
    $fixnum.Int64? transferId,
    $core.String? status,
    $fixnum.Int64? amount,
    $fixnum.Int64? fee,
    $fixnum.Int64? totalAmount,
    $34.Timestamp? createdAt,
  }) {
    final _result = create();
    if (transferId != null) {
      _result.transferId = transferId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory InitiateTransferResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateTransferResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateTransferResponse clone() => InitiateTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateTransferResponse copyWith(void Function(InitiateTransferResponse) updates) => super.copyWith((message) => updates(message as InitiateTransferResponse)) as InitiateTransferResponse; // ignore: deprecated_member_use
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
  void clearTransferId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get fee => $_getI64(3);
  @$pb.TagNumber(4)
  set fee($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearFee() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalAmount => $_getI64(4);
  @$pb.TagNumber(5)
  set totalAmount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => clearField(5);

  @$pb.TagNumber(6)
  $34.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($34.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $34.Timestamp ensureCreatedAt() => $_ensure(5);
}

class TimeSeriesPoint extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TimeSeriesPoint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$34.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', subBuilder: $34.Timestamp.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  TimeSeriesPoint._() : super();
  factory TimeSeriesPoint({
    $34.Timestamp? timestamp,
    $core.double? amount,
  }) {
    final _result = create();
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    return _result;
  }
  factory TimeSeriesPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimeSeriesPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimeSeriesPoint clone() => TimeSeriesPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimeSeriesPoint copyWith(void Function(TimeSeriesPoint) updates) => super.copyWith((message) => updates(message as TimeSeriesPoint)) as TimeSeriesPoint; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TimeSeriesPoint create() => TimeSeriesPoint._();
  TimeSeriesPoint createEmptyInstance() => create();
  static $pb.PbList<TimeSeriesPoint> createRepeated() => $pb.PbList<TimeSeriesPoint>();
  @$core.pragma('dart2js:noInline')
  static TimeSeriesPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimeSeriesPoint>(create);
  static TimeSeriesPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $34.Timestamp get timestamp => $_getN(0);
  @$pb.TagNumber(1)
  set timestamp($34.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);
  @$pb.TagNumber(1)
  $34.Timestamp ensureTimestamp() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);
}

class CategorySummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CategorySummary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'percentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CategorySummary._() : super();
  factory CategorySummary({
    $core.String? category,
    $core.double? amount,
    $core.double? percentage,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (percentage != null) {
      _result.percentage = percentage;
    }
    return _result;
  }
  factory CategorySummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CategorySummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CategorySummary clone() => CategorySummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CategorySummary copyWith(void Function(CategorySummary) updates) => super.copyWith((message) => updates(message as CategorySummary)) as CategorySummary; // ignore: deprecated_member_use
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
  void clearCategory() => clearField(1);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get percentage => $_getN(2);
  @$pb.TagNumber(4)
  set percentage($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(2);
  @$pb.TagNumber(4)
  void clearPercentage() => clearField(4);
}

class MonthlyData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonthlyData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'month')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'income', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenses', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  MonthlyData._() : super();
  factory MonthlyData({
    $core.String? month,
    $core.double? income,
    $core.double? expenses,
  }) {
    final _result = create();
    if (month != null) {
      _result.month = month;
    }
    if (income != null) {
      _result.income = income;
    }
    if (expenses != null) {
      _result.expenses = expenses;
    }
    return _result;
  }
  factory MonthlyData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonthlyData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonthlyData clone() => MonthlyData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonthlyData copyWith(void Function(MonthlyData) updates) => super.copyWith((message) => updates(message as MonthlyData)) as MonthlyData; // ignore: deprecated_member_use
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
  void clearMonth() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get income => $_getN(1);
  @$pb.TagNumber(2)
  set income($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncome() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get expenses => $_getN(2);
  @$pb.TagNumber(3)
  set expenses($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpenses() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpenses() => clearField(3);
}

class ComparisonData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComparisonData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'previousIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentExpenses', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'previousExpenses', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentSavings', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'previousSavings', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ComparisonData._() : super();
  factory ComparisonData({
    $core.double? currentIncome,
    $core.double? previousIncome,
    $core.double? currentExpenses,
    $core.double? previousExpenses,
    $core.double? currentSavings,
    $core.double? previousSavings,
  }) {
    final _result = create();
    if (currentIncome != null) {
      _result.currentIncome = currentIncome;
    }
    if (previousIncome != null) {
      _result.previousIncome = previousIncome;
    }
    if (currentExpenses != null) {
      _result.currentExpenses = currentExpenses;
    }
    if (previousExpenses != null) {
      _result.previousExpenses = previousExpenses;
    }
    if (currentSavings != null) {
      _result.currentSavings = currentSavings;
    }
    if (previousSavings != null) {
      _result.previousSavings = previousSavings;
    }
    return _result;
  }
  factory ComparisonData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComparisonData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComparisonData clone() => ComparisonData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComparisonData copyWith(void Function(ComparisonData) updates) => super.copyWith((message) => updates(message as ComparisonData)) as ComparisonData; // ignore: deprecated_member_use
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
  void clearCurrentIncome() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get previousIncome => $_getN(1);
  @$pb.TagNumber(2)
  set previousIncome($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPreviousIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreviousIncome() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get currentExpenses => $_getN(2);
  @$pb.TagNumber(3)
  set currentExpenses($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentExpenses() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentExpenses() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get previousExpenses => $_getN(3);
  @$pb.TagNumber(4)
  set previousExpenses($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPreviousExpenses() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreviousExpenses() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentSavings => $_getN(4);
  @$pb.TagNumber(5)
  set currentSavings($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentSavings() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentSavings() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get previousSavings => $_getN(5);
  @$pb.TagNumber(6)
  set previousSavings($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPreviousSavings() => $_has(5);
  @$pb.TagNumber(6)
  void clearPreviousSavings() => clearField(6);
}

class GetStatisticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetStatisticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<TimePeriod>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timePeriod', $pb.PbFieldType.OE, defaultOrMaker: TimePeriod.TIME_PERIOD_UNSPECIFIED, valueOf: TimePeriod.valueOf, enumValues: TimePeriod.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  GetStatisticsRequest._() : super();
  factory GetStatisticsRequest({
    TimePeriod? timePeriod,
    $core.String? currency,
  }) {
    final _result = create();
    if (timePeriod != null) {
      _result.timePeriod = timePeriod;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory GetStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStatisticsRequest clone() => GetStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStatisticsRequest copyWith(void Function(GetStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetStatisticsRequest)) as GetStatisticsRequest; // ignore: deprecated_member_use
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
  set timePeriod(TimePeriod v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimePeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimePeriod() => clearField(1);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);
}

class GetStatisticsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetStatisticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalExpenses', $pb.PbFieldType.OD)
    ..pc<TimeSeriesPoint>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenseTimeseries', $pb.PbFieldType.PM, subBuilder: TimeSeriesPoint.create)
    ..pc<CategorySummary>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenseBreakdown', $pb.PbFieldType.PM, subBuilder: CategorySummary.create)
    ..pc<CategorySummary>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incomeBreakdown', $pb.PbFieldType.PM, subBuilder: CategorySummary.create)
    ..pc<MonthlyData>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monthlyOverview', $pb.PbFieldType.PM, subBuilder: MonthlyData.create)
    ..aOM<ComparisonData>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'comparisonMetrics', subBuilder: ComparisonData.create)
    ..hasRequiredFields = false
  ;

  GetStatisticsResponse._() : super();
  factory GetStatisticsResponse({
    $core.double? totalIncome,
    $core.double? totalExpenses,
    $core.Iterable<TimeSeriesPoint>? expenseTimeseries,
    $core.Iterable<CategorySummary>? expenseBreakdown,
    $core.Iterable<CategorySummary>? incomeBreakdown,
    $core.Iterable<MonthlyData>? monthlyOverview,
    ComparisonData? comparisonMetrics,
  }) {
    final _result = create();
    if (totalIncome != null) {
      _result.totalIncome = totalIncome;
    }
    if (totalExpenses != null) {
      _result.totalExpenses = totalExpenses;
    }
    if (expenseTimeseries != null) {
      _result.expenseTimeseries.addAll(expenseTimeseries);
    }
    if (expenseBreakdown != null) {
      _result.expenseBreakdown.addAll(expenseBreakdown);
    }
    if (incomeBreakdown != null) {
      _result.incomeBreakdown.addAll(incomeBreakdown);
    }
    if (monthlyOverview != null) {
      _result.monthlyOverview.addAll(monthlyOverview);
    }
    if (comparisonMetrics != null) {
      _result.comparisonMetrics = comparisonMetrics;
    }
    return _result;
  }
  factory GetStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStatisticsResponse clone() => GetStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStatisticsResponse copyWith(void Function(GetStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetStatisticsResponse)) as GetStatisticsResponse; // ignore: deprecated_member_use
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
  $core.List<TimeSeriesPoint> get expenseTimeseries => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<CategorySummary> get expenseBreakdown => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<CategorySummary> get incomeBreakdown => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<MonthlyData> get monthlyOverview => $_getList(5);

  @$pb.TagNumber(7)
  ComparisonData get comparisonMetrics => $_getN(6);
  @$pb.TagNumber(7)
  set comparisonMetrics(ComparisonData v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasComparisonMetrics() => $_has(6);
  @$pb.TagNumber(7)
  void clearComparisonMetrics() => clearField(7);
  @$pb.TagNumber(7)
  ComparisonData ensureComparisonMetrics() => $_ensure(6);
}

class GetTransferDetailsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransferDetailsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transfer_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  GetTransferDetailsRequest._() : super();
  factory GetTransferDetailsRequest({
    $fixnum.Int64? transferId,
  }) {
    final _result = create();
    if (transferId != null) {
      _result.transferId = transferId;
    }
    return _result;
  }
  factory GetTransferDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransferDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransferDetailsRequest clone() => GetTransferDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransferDetailsRequest copyWith(void Function(GetTransferDetailsRequest) updates) => super.copyWith((message) => updates(message as GetTransferDetailsRequest)) as GetTransferDetailsRequest; // ignore: deprecated_member_use
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
  void clearTransferId() => clearField(1);
}

class GetTransferDetailsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransferDetailsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transfer_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'to_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from_user_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'to_user_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOM<$34.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created_at', subBuilder: $34.Timestamp.create)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduled_at')
    ..aOM<$34.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completed_at', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failed_at', subBuilder: $34.Timestamp.create)
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failure_reason')
    ..hasRequiredFields = false
  ;

  GetTransferDetailsResponse._() : super();
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
    $34.Timestamp? createdAt,
    $core.String? scheduledAt,
    $34.Timestamp? completedAt,
    $34.Timestamp? failedAt,
    $core.String? failureReason,
  }) {
    final _result = create();
    if (transferId != null) {
      _result.transferId = transferId;
    }
    if (fromAccountId != null) {
      _result.fromAccountId = fromAccountId;
    }
    if (toAccountId != null) {
      _result.toAccountId = toAccountId;
    }
    if (fromUserId != null) {
      _result.fromUserId = fromUserId;
    }
    if (toUserId != null) {
      _result.toUserId = toUserId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (status != null) {
      _result.status = status;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (category != null) {
      _result.category = category;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (scheduledAt != null) {
      _result.scheduledAt = scheduledAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    if (failedAt != null) {
      _result.failedAt = failedAt;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    return _result;
  }
  factory GetTransferDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransferDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransferDetailsResponse clone() => GetTransferDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransferDetailsResponse copyWith(void Function(GetTransferDetailsResponse) updates) => super.copyWith((message) => updates(message as GetTransferDetailsResponse)) as GetTransferDetailsResponse; // ignore: deprecated_member_use
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
  void clearTransferId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get fromAccountId => $_getI64(1);
  @$pb.TagNumber(2)
  set fromAccountId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get toAccountId => $_getI64(2);
  @$pb.TagNumber(3)
  set toAccountId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get fromUserId => $_getI64(3);
  @$pb.TagNumber(4)
  set fromUserId($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFromUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromUserId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get toUserId => $_getI64(4);
  @$pb.TagNumber(5)
  set toUserId($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasToUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearToUserId() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amount => $_getI64(5);
  @$pb.TagNumber(6)
  set amount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get fee => $_getI64(6);
  @$pb.TagNumber(7)
  set fee($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFee() => $_has(6);
  @$pb.TagNumber(7)
  void clearFee() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalAmount => $_getI64(7);
  @$pb.TagNumber(8)
  set totalAmount($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get reference => $_getSZ(10);
  @$pb.TagNumber(11)
  set reference($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearReference() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get category => $_getSZ(11);
  @$pb.TagNumber(12)
  set category($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCategory() => $_has(11);
  @$pb.TagNumber(12)
  void clearCategory() => clearField(12);

  @$pb.TagNumber(13)
  $34.Timestamp get createdAt => $_getN(12);
  @$pb.TagNumber(13)
  set createdAt($34.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => clearField(13);
  @$pb.TagNumber(13)
  $34.Timestamp ensureCreatedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $core.String get scheduledAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set scheduledAt($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasScheduledAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearScheduledAt() => clearField(14);

  @$pb.TagNumber(15)
  $34.Timestamp get completedAt => $_getN(14);
  @$pb.TagNumber(15)
  set completedAt($34.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasCompletedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCompletedAt() => clearField(15);
  @$pb.TagNumber(15)
  $34.Timestamp ensureCompletedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $34.Timestamp get failedAt => $_getN(15);
  @$pb.TagNumber(16)
  set failedAt($34.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasFailedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailedAt() => clearField(16);
  @$pb.TagNumber(16)
  $34.Timestamp ensureFailedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.String get failureReason => $_getSZ(16);
  @$pb.TagNumber(17)
  set failureReason($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasFailureReason() => $_has(16);
  @$pb.TagNumber(17)
  void clearFailureReason() => clearField(17);
}

class TransferPaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferPaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  TransferPaginationInfo._() : super();
  factory TransferPaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final _result = create();
    if (currentPage != null) {
      _result.currentPage = currentPage;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (totalItems != null) {
      _result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      _result.itemsPerPage = itemsPerPage;
    }
    if (hasNext != null) {
      _result.hasNext = hasNext;
    }
    if (hasPrev != null) {
      _result.hasPrev = hasPrev;
    }
    return _result;
  }
  factory TransferPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferPaginationInfo clone() => TransferPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferPaginationInfo copyWith(void Function(TransferPaginationInfo) updates) => super.copyWith((message) => updates(message as TransferPaginationInfo)) as TransferPaginationInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransferPaginationInfo create() => TransferPaginationInfo._();
  TransferPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<TransferPaginationInfo> createRepeated() => $pb.PbList<TransferPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static TransferPaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferPaginationInfo>(create);
  static TransferPaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPages => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPages($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalPages() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPages() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemsPerPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemsPerPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasItemsPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemsPerPage() => clearField(4);

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

class ListTransfersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListTransfersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sortBy')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sortOrder')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'search')
    ..hasRequiredFields = false
  ;

  ListTransfersRequest._() : super();
  factory ListTransfersRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? status,
    $core.String? sortBy,
    $core.String? sortOrder,
    $core.String? search,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (status != null) {
      _result.status = status;
    }
    if (sortBy != null) {
      _result.sortBy = sortBy;
    }
    if (sortOrder != null) {
      _result.sortOrder = sortOrder;
    }
    if (search != null) {
      _result.search = search;
    }
    return _result;
  }
  factory ListTransfersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTransfersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTransfersRequest clone() => ListTransfersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTransfersRequest copyWith(void Function(ListTransfersRequest) updates) => super.copyWith((message) => updates(message as ListTransfersRequest)) as ListTransfersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListTransfersRequest create() => ListTransfersRequest._();
  ListTransfersRequest createEmptyInstance() => create();
  static $pb.PbList<ListTransfersRequest> createRepeated() => $pb.PbList<ListTransfersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTransfersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTransfersRequest>(create);
  static ListTransfersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sortBy => $_getSZ(3);
  @$pb.TagNumber(4)
  set sortBy($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSortBy() => $_has(3);
  @$pb.TagNumber(4)
  void clearSortBy() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get sortOrder => $_getSZ(4);
  @$pb.TagNumber(5)
  set sortOrder($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSortOrder() => $_has(4);
  @$pb.TagNumber(5)
  void clearSortOrder() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get search => $_getSZ(5);
  @$pb.TagNumber(6)
  set search($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSearch() => $_has(5);
  @$pb.TagNumber(6)
  void clearSearch() => clearField(6);
}

class ListTransfersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListTransfersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<GetTransferDetailsResponse>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transfers', $pb.PbFieldType.PM, subBuilder: GetTransferDetailsResponse.create)
    ..aOM<TransferPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: TransferPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListTransfersResponse._() : super();
  factory ListTransfersResponse({
    $core.Iterable<GetTransferDetailsResponse>? transfers,
    TransferPaginationInfo? pagination,
  }) {
    final _result = create();
    if (transfers != null) {
      _result.transfers.addAll(transfers);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListTransfersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTransfersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTransfersResponse clone() => ListTransfersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTransfersResponse copyWith(void Function(ListTransfersResponse) updates) => super.copyWith((message) => updates(message as ListTransfersResponse)) as ListTransfersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListTransfersResponse create() => ListTransfersResponse._();
  ListTransfersResponse createEmptyInstance() => create();
  static $pb.PbList<ListTransfersResponse> createRepeated() => $pb.PbList<ListTransfersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListTransfersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTransfersResponse>(create);
  static ListTransfersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GetTransferDetailsResponse> get transfers => $_getList(0);

  @$pb.TagNumber(2)
  TransferPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(TransferPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  TransferPaginationInfo ensurePagination() => $_ensure(1);
}

class BatchRecipient extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BatchRecipient', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..hasRequiredFields = false
  ;

  BatchRecipient._() : super();
  factory BatchRecipient({
    $fixnum.Int64? recipientId,
    $fixnum.Int64? toAccountId,
    $fixnum.Int64? amount,
    $core.String? reference,
    $core.String? category,
  }) {
    final _result = create();
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    if (toAccountId != null) {
      _result.toAccountId = toAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (category != null) {
      _result.category = category;
    }
    return _result;
  }
  factory BatchRecipient.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchRecipient.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BatchRecipient clone() => BatchRecipient()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BatchRecipient copyWith(void Function(BatchRecipient) updates) => super.copyWith((message) => updates(message as BatchRecipient)) as BatchRecipient; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BatchRecipient create() => BatchRecipient._();
  BatchRecipient createEmptyInstance() => create();
  static $pb.PbList<BatchRecipient> createRepeated() => $pb.PbList<BatchRecipient>();
  @$core.pragma('dart2js:noInline')
  static BatchRecipient getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchRecipient>(create);
  static BatchRecipient? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get recipientId => $_getI64(0);
  @$pb.TagNumber(1)
  set recipientId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get toAccountId => $_getI64(1);
  @$pb.TagNumber(2)
  set toAccountId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearToAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

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
}

class InitiateBatchTransferRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateBatchTransferRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<BatchRecipient>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipients', $pb.PbFieldType.PM, subBuilder: BatchRecipient.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduledAt')
    ..hasRequiredFields = false
  ;

  InitiateBatchTransferRequest._() : super();
  factory InitiateBatchTransferRequest({
    $fixnum.Int64? fromAccountId,
    $core.Iterable<BatchRecipient>? recipients,
    $core.String? scheduledAt,
  }) {
    final _result = create();
    if (fromAccountId != null) {
      _result.fromAccountId = fromAccountId;
    }
    if (recipients != null) {
      _result.recipients.addAll(recipients);
    }
    if (scheduledAt != null) {
      _result.scheduledAt = scheduledAt;
    }
    return _result;
  }
  factory InitiateBatchTransferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateBatchTransferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateBatchTransferRequest clone() => InitiateBatchTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateBatchTransferRequest copyWith(void Function(InitiateBatchTransferRequest) updates) => super.copyWith((message) => updates(message as InitiateBatchTransferRequest)) as InitiateBatchTransferRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateBatchTransferRequest create() => InitiateBatchTransferRequest._();
  InitiateBatchTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateBatchTransferRequest> createRepeated() => $pb.PbList<InitiateBatchTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateBatchTransferRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateBatchTransferRequest>(create);
  static InitiateBatchTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get fromAccountId => $_getI64(0);
  @$pb.TagNumber(1)
  set fromAccountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<BatchRecipient> get recipients => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get scheduledAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set scheduledAt($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasScheduledAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearScheduledAt() => clearField(3);
}

class BatchTransferResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BatchTransferResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientAccount')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..hasRequiredFields = false
  ;

  BatchTransferResult._() : super();
  factory BatchTransferResult({
    $fixnum.Int64? transferId,
    $core.String? status,
    $fixnum.Int64? amount,
    $fixnum.Int64? fee,
    $core.String? recipientName,
    $core.String? recipientAccount,
    $core.String? failureReason,
  }) {
    final _result = create();
    if (transferId != null) {
      _result.transferId = transferId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (recipientAccount != null) {
      _result.recipientAccount = recipientAccount;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    return _result;
  }
  factory BatchTransferResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchTransferResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BatchTransferResult clone() => BatchTransferResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BatchTransferResult copyWith(void Function(BatchTransferResult) updates) => super.copyWith((message) => updates(message as BatchTransferResult)) as BatchTransferResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BatchTransferResult create() => BatchTransferResult._();
  BatchTransferResult createEmptyInstance() => create();
  static $pb.PbList<BatchTransferResult> createRepeated() => $pb.PbList<BatchTransferResult>();
  @$core.pragma('dart2js:noInline')
  static BatchTransferResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchTransferResult>(create);
  static BatchTransferResult? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get transferId => $_getI64(0);
  @$pb.TagNumber(1)
  set transferId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransferId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get fee => $_getI64(3);
  @$pb.TagNumber(4)
  set fee($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearFee() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientName => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecipientName() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientAccount => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientAccount($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecipientAccount() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientAccount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get failureReason => $_getSZ(6);
  @$pb.TagNumber(7)
  set failureReason($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFailureReason() => $_has(6);
  @$pb.TagNumber(7)
  void clearFailureReason() => clearField(7);
}

class InitiateBatchTransferResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateBatchTransferResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batchId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalFee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmountWithFee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'successfulTransfers', $pb.PbFieldType.O3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedTransfers', $pb.PbFieldType.O3)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalTransfers', $pb.PbFieldType.O3)
    ..pc<BatchTransferResult>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'results', $pb.PbFieldType.PM, subBuilder: BatchTransferResult.create)
    ..aOM<$34.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt', subBuilder: $34.Timestamp.create)
    ..hasRequiredFields = false
  ;

  InitiateBatchTransferResponse._() : super();
  factory InitiateBatchTransferResponse({
    $fixnum.Int64? batchId,
    $core.String? status,
    $fixnum.Int64? totalAmount,
    $fixnum.Int64? totalFee,
    $fixnum.Int64? totalAmountWithFee,
    $core.int? successfulTransfers,
    $core.int? failedTransfers,
    $core.int? totalTransfers,
    $core.Iterable<BatchTransferResult>? results,
    $34.Timestamp? createdAt,
    $34.Timestamp? completedAt,
  }) {
    final _result = create();
    if (batchId != null) {
      _result.batchId = batchId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (totalFee != null) {
      _result.totalFee = totalFee;
    }
    if (totalAmountWithFee != null) {
      _result.totalAmountWithFee = totalAmountWithFee;
    }
    if (successfulTransfers != null) {
      _result.successfulTransfers = successfulTransfers;
    }
    if (failedTransfers != null) {
      _result.failedTransfers = failedTransfers;
    }
    if (totalTransfers != null) {
      _result.totalTransfers = totalTransfers;
    }
    if (results != null) {
      _result.results.addAll(results);
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    return _result;
  }
  factory InitiateBatchTransferResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateBatchTransferResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateBatchTransferResponse clone() => InitiateBatchTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateBatchTransferResponse copyWith(void Function(InitiateBatchTransferResponse) updates) => super.copyWith((message) => updates(message as InitiateBatchTransferResponse)) as InitiateBatchTransferResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateBatchTransferResponse create() => InitiateBatchTransferResponse._();
  InitiateBatchTransferResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateBatchTransferResponse> createRepeated() => $pb.PbList<InitiateBatchTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateBatchTransferResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateBatchTransferResponse>(create);
  static InitiateBatchTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get batchId => $_getI64(0);
  @$pb.TagNumber(1)
  set batchId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalAmount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalAmount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalAmount() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalFee => $_getI64(3);
  @$pb.TagNumber(4)
  set totalFee($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalFee() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalAmountWithFee => $_getI64(4);
  @$pb.TagNumber(5)
  set totalAmountWithFee($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalAmountWithFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmountWithFee() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get successfulTransfers => $_getIZ(5);
  @$pb.TagNumber(6)
  set successfulTransfers($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSuccessfulTransfers() => $_has(5);
  @$pb.TagNumber(6)
  void clearSuccessfulTransfers() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get failedTransfers => $_getIZ(6);
  @$pb.TagNumber(7)
  set failedTransfers($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFailedTransfers() => $_has(6);
  @$pb.TagNumber(7)
  void clearFailedTransfers() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get totalTransfers => $_getIZ(7);
  @$pb.TagNumber(8)
  set totalTransfers($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalTransfers() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalTransfers() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<BatchTransferResult> get results => $_getList(8);

  @$pb.TagNumber(10)
  $34.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($34.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $34.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $34.Timestamp get completedAt => $_getN(10);
  @$pb.TagNumber(11)
  set completedAt($34.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCompletedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCompletedAt() => clearField(11);
  @$pb.TagNumber(11)
  $34.Timestamp ensureCompletedAt() => $_ensure(10);
}

class GetBatchTransferStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBatchTransferStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batch_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  GetBatchTransferStatusRequest._() : super();
  factory GetBatchTransferStatusRequest({
    $fixnum.Int64? batchId,
  }) {
    final _result = create();
    if (batchId != null) {
      _result.batchId = batchId;
    }
    return _result;
  }
  factory GetBatchTransferStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBatchTransferStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBatchTransferStatusRequest clone() => GetBatchTransferStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBatchTransferStatusRequest copyWith(void Function(GetBatchTransferStatusRequest) updates) => super.copyWith((message) => updates(message as GetBatchTransferStatusRequest)) as GetBatchTransferStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBatchTransferStatusRequest create() => GetBatchTransferStatusRequest._();
  GetBatchTransferStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetBatchTransferStatusRequest> createRepeated() => $pb.PbList<GetBatchTransferStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBatchTransferStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBatchTransferStatusRequest>(create);
  static GetBatchTransferStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get batchId => $_getI64(0);
  @$pb.TagNumber(1)
  set batchId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => clearField(1);
}

class GetBatchTransferStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBatchTransferStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batchId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalFee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmountWithFee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'successfulTransfers', $pb.PbFieldType.O3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedTransfers', $pb.PbFieldType.O3)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalTransfers', $pb.PbFieldType.O3)
    ..pc<BatchTransferResult>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'results', $pb.PbFieldType.PM, subBuilder: BatchTransferResult.create)
    ..aOM<$34.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt', subBuilder: $34.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetBatchTransferStatusResponse._() : super();
  factory GetBatchTransferStatusResponse({
    $fixnum.Int64? batchId,
    $core.String? status,
    $fixnum.Int64? totalAmount,
    $fixnum.Int64? totalFee,
    $fixnum.Int64? totalAmountWithFee,
    $core.int? successfulTransfers,
    $core.int? failedTransfers,
    $core.int? totalTransfers,
    $core.Iterable<BatchTransferResult>? results,
    $34.Timestamp? createdAt,
    $34.Timestamp? completedAt,
  }) {
    final _result = create();
    if (batchId != null) {
      _result.batchId = batchId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (totalFee != null) {
      _result.totalFee = totalFee;
    }
    if (totalAmountWithFee != null) {
      _result.totalAmountWithFee = totalAmountWithFee;
    }
    if (successfulTransfers != null) {
      _result.successfulTransfers = successfulTransfers;
    }
    if (failedTransfers != null) {
      _result.failedTransfers = failedTransfers;
    }
    if (totalTransfers != null) {
      _result.totalTransfers = totalTransfers;
    }
    if (results != null) {
      _result.results.addAll(results);
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    return _result;
  }
  factory GetBatchTransferStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBatchTransferStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBatchTransferStatusResponse clone() => GetBatchTransferStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBatchTransferStatusResponse copyWith(void Function(GetBatchTransferStatusResponse) updates) => super.copyWith((message) => updates(message as GetBatchTransferStatusResponse)) as GetBatchTransferStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBatchTransferStatusResponse create() => GetBatchTransferStatusResponse._();
  GetBatchTransferStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetBatchTransferStatusResponse> createRepeated() => $pb.PbList<GetBatchTransferStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBatchTransferStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBatchTransferStatusResponse>(create);
  static GetBatchTransferStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get batchId => $_getI64(0);
  @$pb.TagNumber(1)
  set batchId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalAmount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalAmount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalAmount() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalFee => $_getI64(3);
  @$pb.TagNumber(4)
  set totalFee($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalFee() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalAmountWithFee => $_getI64(4);
  @$pb.TagNumber(5)
  set totalAmountWithFee($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalAmountWithFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmountWithFee() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get successfulTransfers => $_getIZ(5);
  @$pb.TagNumber(6)
  set successfulTransfers($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSuccessfulTransfers() => $_has(5);
  @$pb.TagNumber(6)
  void clearSuccessfulTransfers() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get failedTransfers => $_getIZ(6);
  @$pb.TagNumber(7)
  set failedTransfers($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFailedTransfers() => $_has(6);
  @$pb.TagNumber(7)
  void clearFailedTransfers() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get totalTransfers => $_getIZ(7);
  @$pb.TagNumber(8)
  set totalTransfers($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalTransfers() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalTransfers() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<BatchTransferResult> get results => $_getList(8);

  @$pb.TagNumber(10)
  $34.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($34.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $34.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $34.Timestamp get completedAt => $_getN(10);
  @$pb.TagNumber(11)
  set completedAt($34.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCompletedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCompletedAt() => clearField(11);
  @$pb.TagNumber(11)
  $34.Timestamp ensureCompletedAt() => $_ensure(10);
}

class GetBatchTransferHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBatchTransferHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  GetBatchTransferHistoryRequest._() : super();
  factory GetBatchTransferHistoryRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? status,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory GetBatchTransferHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBatchTransferHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBatchTransferHistoryRequest clone() => GetBatchTransferHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBatchTransferHistoryRequest copyWith(void Function(GetBatchTransferHistoryRequest) updates) => super.copyWith((message) => updates(message as GetBatchTransferHistoryRequest)) as GetBatchTransferHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBatchTransferHistoryRequest create() => GetBatchTransferHistoryRequest._();
  GetBatchTransferHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetBatchTransferHistoryRequest> createRepeated() => $pb.PbList<GetBatchTransferHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBatchTransferHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBatchTransferHistoryRequest>(create);
  static GetBatchTransferHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);
}

class GetBatchTransferHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBatchTransferHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<GetBatchTransferStatusResponse>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batches', $pb.PbFieldType.PM, subBuilder: GetBatchTransferStatusResponse.create)
    ..aOM<TransferPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: TransferPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetBatchTransferHistoryResponse._() : super();
  factory GetBatchTransferHistoryResponse({
    $core.Iterable<GetBatchTransferStatusResponse>? batches,
    TransferPaginationInfo? pagination,
  }) {
    final _result = create();
    if (batches != null) {
      _result.batches.addAll(batches);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetBatchTransferHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBatchTransferHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBatchTransferHistoryResponse clone() => GetBatchTransferHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBatchTransferHistoryResponse copyWith(void Function(GetBatchTransferHistoryResponse) updates) => super.copyWith((message) => updates(message as GetBatchTransferHistoryResponse)) as GetBatchTransferHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBatchTransferHistoryResponse create() => GetBatchTransferHistoryResponse._();
  GetBatchTransferHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetBatchTransferHistoryResponse> createRepeated() => $pb.PbList<GetBatchTransferHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBatchTransferHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBatchTransferHistoryResponse>(create);
  static GetBatchTransferHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GetBatchTransferStatusResponse> get batches => $_getList(0);

  @$pb.TagNumber(2)
  TransferPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(TransferPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  TransferPaginationInfo ensurePagination() => $_ensure(1);
}

