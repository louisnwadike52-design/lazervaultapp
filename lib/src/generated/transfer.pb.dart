///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $17;

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
    ..aOM<$17.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $17.Timestamp.create)
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
    $17.Timestamp? createdAt,
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
  $17.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($17.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $17.Timestamp ensureCreatedAt() => $_ensure(9);
}

class InitiateTransferRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateTransferRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from_account_id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOM<$17.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduledAt', subBuilder: $17.Timestamp.create)
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
    $17.Timestamp? scheduledAt,
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
  $17.Timestamp get scheduledAt => $_getN(4);
  @$pb.TagNumber(5)
  set scheduledAt($17.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasScheduledAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearScheduledAt() => clearField(5);
  @$pb.TagNumber(5)
  $17.Timestamp ensureScheduledAt() => $_ensure(4);

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
    ..aOM<$17.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $17.Timestamp.create)
    ..hasRequiredFields = false
  ;

  InitiateTransferResponse._() : super();
  factory InitiateTransferResponse({
    $fixnum.Int64? transferId,
    $core.String? status,
    $fixnum.Int64? amount,
    $fixnum.Int64? fee,
    $fixnum.Int64? totalAmount,
    $17.Timestamp? createdAt,
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
  $17.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($17.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $17.Timestamp ensureCreatedAt() => $_ensure(5);
}

class TimeSeriesPoint extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TimeSeriesPoint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$17.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', subBuilder: $17.Timestamp.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  TimeSeriesPoint._() : super();
  factory TimeSeriesPoint({
    $17.Timestamp? timestamp,
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
  $17.Timestamp get timestamp => $_getN(0);
  @$pb.TagNumber(1)
  set timestamp($17.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);
  @$pb.TagNumber(1)
  $17.Timestamp ensureTimestamp() => $_ensure(0);

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

class PaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems')
    ..hasRequiredFields = false
  ;

  PaginationInfo._() : super();
  factory PaginationInfo({
    $core.int? currentPage,
    $core.int? pageSize,
    $core.int? totalPages,
    $fixnum.Int64? totalItems,
  }) {
    final _result = create();
    if (currentPage != null) {
      _result.currentPage = currentPage;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (totalItems != null) {
      _result.totalItems = totalItems;
    }
    return _result;
  }
  factory PaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginationInfo clone() => PaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginationInfo copyWith(void Function(PaginationInfo) updates) => super.copyWith((message) => updates(message as PaginationInfo)) as PaginationInfo; // ignore: deprecated_member_use
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
  void clearCurrentPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalPages => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalPages($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalPages() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPages() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalItems => $_getI64(3);
  @$pb.TagNumber(4)
  set totalItems($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalItems() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalItems() => clearField(4);
}

class GetTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardId')
    ..aOM<$17.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $17.Timestamp.create)
    ..aOM<$17.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $17.Timestamp.create)
    ..e<TransferType>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferType', $pb.PbFieldType.OE, defaultOrMaker: TransferType.TRANSFER_TYPE_UNSPECIFIED, valueOf: TransferType.valueOf, enumValues: TransferType.values)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageNumber', $pb.PbFieldType.O3)
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetTransactionsRequest._() : super();
  factory GetTransactionsRequest({
    $fixnum.Int64? accountId,
    $core.String? cardId,
    $17.Timestamp? startDate,
    $17.Timestamp? endDate,
    TransferType? transferType,
    $core.String? category,
    $core.int? pageNumber,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (cardId != null) {
      _result.cardId = cardId;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (transferType != null) {
      _result.transferType = transferType;
    }
    if (category != null) {
      _result.category = category;
    }
    if (pageNumber != null) {
      _result.pageNumber = pageNumber;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionsRequest clone() => GetTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionsRequest copyWith(void Function(GetTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetTransactionsRequest)) as GetTransactionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTransactionsRequest create() => GetTransactionsRequest._();
  GetTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionsRequest> createRepeated() => $pb.PbList<GetTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionsRequest>(create);
  static GetTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardId() => clearField(2);

  @$pb.TagNumber(3)
  $17.Timestamp get startDate => $_getN(2);
  @$pb.TagNumber(3)
  set startDate($17.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => clearField(3);
  @$pb.TagNumber(3)
  $17.Timestamp ensureStartDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $17.Timestamp get endDate => $_getN(3);
  @$pb.TagNumber(4)
  set endDate($17.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => clearField(4);
  @$pb.TagNumber(4)
  $17.Timestamp ensureEndDate() => $_ensure(3);

  @$pb.TagNumber(5)
  TransferType get transferType => $_getN(4);
  @$pb.TagNumber(5)
  set transferType(TransferType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransferType() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransferType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => clearField(6);

  @$pb.TagNumber(10)
  $core.int get pageNumber => $_getIZ(6);
  @$pb.TagNumber(10)
  set pageNumber($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(10)
  $core.bool hasPageNumber() => $_has(6);
  @$pb.TagNumber(10)
  void clearPageNumber() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get pageSize => $_getIZ(7);
  @$pb.TagNumber(11)
  set pageSize($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(11)
  $core.bool hasPageSize() => $_has(7);
  @$pb.TagNumber(11)
  void clearPageSize() => clearField(11);
}

class GetTransactionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TransferTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: TransferTransaction.create)
    ..aOM<PaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetTransactionsResponse._() : super();
  factory GetTransactionsResponse({
    $core.Iterable<TransferTransaction>? transactions,
    PaginationInfo? pagination,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionsResponse clone() => GetTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionsResponse copyWith(void Function(GetTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetTransactionsResponse)) as GetTransactionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTransactionsResponse create() => GetTransactionsResponse._();
  GetTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionsResponse> createRepeated() => $pb.PbList<GetTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionsResponse>(create);
  static GetTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TransferTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PaginationInfo ensurePagination() => $_ensure(1);
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
    ..aOM<$17.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created_at', subBuilder: $17.Timestamp.create)
    ..aOM<$17.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduled_at', subBuilder: $17.Timestamp.create)
    ..aOM<$17.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completed_at', subBuilder: $17.Timestamp.create)
    ..aOM<$17.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failed_at', subBuilder: $17.Timestamp.create)
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
    $17.Timestamp? createdAt,
    $17.Timestamp? scheduledAt,
    $17.Timestamp? completedAt,
    $17.Timestamp? failedAt,
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
  $17.Timestamp get createdAt => $_getN(12);
  @$pb.TagNumber(13)
  set createdAt($17.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => clearField(13);
  @$pb.TagNumber(13)
  $17.Timestamp ensureCreatedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $17.Timestamp get scheduledAt => $_getN(13);
  @$pb.TagNumber(14)
  set scheduledAt($17.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasScheduledAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearScheduledAt() => clearField(14);
  @$pb.TagNumber(14)
  $17.Timestamp ensureScheduledAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $17.Timestamp get completedAt => $_getN(14);
  @$pb.TagNumber(15)
  set completedAt($17.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasCompletedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCompletedAt() => clearField(15);
  @$pb.TagNumber(15)
  $17.Timestamp ensureCompletedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $17.Timestamp get failedAt => $_getN(15);
  @$pb.TagNumber(16)
  set failedAt($17.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasFailedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailedAt() => clearField(16);
  @$pb.TagNumber(16)
  $17.Timestamp ensureFailedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.String get failureReason => $_getSZ(16);
  @$pb.TagNumber(17)
  set failureReason($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasFailureReason() => $_has(16);
  @$pb.TagNumber(17)
  void clearFailureReason() => clearField(17);
}

