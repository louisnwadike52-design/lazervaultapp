//
//  Generated code. Do not modify.
//  source: barcode_payment.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $42;

class GenerateBarcodeRequest extends $pb.GeneratedMessage {
  factory GenerateBarcodeRequest({
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.int? validityMinutes,
  }) {
    final $result = create();
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (description != null) {
      $result.description = description;
    }
    if (validityMinutes != null) {
      $result.validityMinutes = validityMinutes;
    }
    return $result;
  }
  GenerateBarcodeRequest._() : super();
  factory GenerateBarcodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateBarcodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateBarcodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'validityMinutes', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateBarcodeRequest clone() => GenerateBarcodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateBarcodeRequest copyWith(void Function(GenerateBarcodeRequest) updates) => super.copyWith((message) => updates(message as GenerateBarcodeRequest)) as GenerateBarcodeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateBarcodeRequest create() => GenerateBarcodeRequest._();
  GenerateBarcodeRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateBarcodeRequest> createRepeated() => $pb.PbList<GenerateBarcodeRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateBarcodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateBarcodeRequest>(create);
  static GenerateBarcodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get amount => $_getN(0);
  @$pb.TagNumber(1)
  set amount($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get validityMinutes => $_getIZ(3);
  @$pb.TagNumber(4)
  set validityMinutes($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasValidityMinutes() => $_has(3);
  @$pb.TagNumber(4)
  void clearValidityMinutes() => clearField(4);
}

class GenerateBarcodeResponse extends $pb.GeneratedMessage {
  factory GenerateBarcodeResponse({
    $core.String? barcodeId,
    $core.String? barcodeCode,
    $core.String? qrData,
    $42.Timestamp? expiresAt,
    $core.String? message,
  }) {
    final $result = create();
    if (barcodeId != null) {
      $result.barcodeId = barcodeId;
    }
    if (barcodeCode != null) {
      $result.barcodeCode = barcodeCode;
    }
    if (qrData != null) {
      $result.qrData = qrData;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  GenerateBarcodeResponse._() : super();
  factory GenerateBarcodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateBarcodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateBarcodeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'barcodeId')
    ..aOS(2, _omitFieldNames ? '' : 'barcodeCode')
    ..aOS(3, _omitFieldNames ? '' : 'qrData')
    ..aOM<$42.Timestamp>(4, _omitFieldNames ? '' : 'expiresAt', subBuilder: $42.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateBarcodeResponse clone() => GenerateBarcodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateBarcodeResponse copyWith(void Function(GenerateBarcodeResponse) updates) => super.copyWith((message) => updates(message as GenerateBarcodeResponse)) as GenerateBarcodeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateBarcodeResponse create() => GenerateBarcodeResponse._();
  GenerateBarcodeResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateBarcodeResponse> createRepeated() => $pb.PbList<GenerateBarcodeResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateBarcodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateBarcodeResponse>(create);
  static GenerateBarcodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get barcodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set barcodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBarcodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBarcodeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get barcodeCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set barcodeCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBarcodeCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearBarcodeCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get qrData => $_getSZ(2);
  @$pb.TagNumber(3)
  set qrData($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQrData() => $_has(2);
  @$pb.TagNumber(3)
  void clearQrData() => clearField(3);

  @$pb.TagNumber(4)
  $42.Timestamp get expiresAt => $_getN(3);
  @$pb.TagNumber(4)
  set expiresAt($42.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => clearField(4);
  @$pb.TagNumber(4)
  $42.Timestamp ensureExpiresAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

class GetBarcodeDetailsRequest extends $pb.GeneratedMessage {
  factory GetBarcodeDetailsRequest({
    $core.String? barcodeCode,
  }) {
    final $result = create();
    if (barcodeCode != null) {
      $result.barcodeCode = barcodeCode;
    }
    return $result;
  }
  GetBarcodeDetailsRequest._() : super();
  factory GetBarcodeDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBarcodeDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBarcodeDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'barcodeCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBarcodeDetailsRequest clone() => GetBarcodeDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBarcodeDetailsRequest copyWith(void Function(GetBarcodeDetailsRequest) updates) => super.copyWith((message) => updates(message as GetBarcodeDetailsRequest)) as GetBarcodeDetailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBarcodeDetailsRequest create() => GetBarcodeDetailsRequest._();
  GetBarcodeDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetBarcodeDetailsRequest> createRepeated() => $pb.PbList<GetBarcodeDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBarcodeDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBarcodeDetailsRequest>(create);
  static GetBarcodeDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get barcodeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set barcodeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBarcodeCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearBarcodeCode() => clearField(1);
}

class GetBarcodeDetailsResponse extends $pb.GeneratedMessage {
  factory GetBarcodeDetailsResponse({
    BarcodePayment? barcode,
  }) {
    final $result = create();
    if (barcode != null) {
      $result.barcode = barcode;
    }
    return $result;
  }
  GetBarcodeDetailsResponse._() : super();
  factory GetBarcodeDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBarcodeDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBarcodeDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOM<BarcodePayment>(1, _omitFieldNames ? '' : 'barcode', subBuilder: BarcodePayment.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBarcodeDetailsResponse clone() => GetBarcodeDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBarcodeDetailsResponse copyWith(void Function(GetBarcodeDetailsResponse) updates) => super.copyWith((message) => updates(message as GetBarcodeDetailsResponse)) as GetBarcodeDetailsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBarcodeDetailsResponse create() => GetBarcodeDetailsResponse._();
  GetBarcodeDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetBarcodeDetailsResponse> createRepeated() => $pb.PbList<GetBarcodeDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBarcodeDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBarcodeDetailsResponse>(create);
  static GetBarcodeDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BarcodePayment get barcode => $_getN(0);
  @$pb.TagNumber(1)
  set barcode(BarcodePayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBarcode() => $_has(0);
  @$pb.TagNumber(1)
  void clearBarcode() => clearField(1);
  @$pb.TagNumber(1)
  BarcodePayment ensureBarcode() => $_ensure(0);
}

class ProcessBarcodePaymentRequest extends $pb.GeneratedMessage {
  factory ProcessBarcodePaymentRequest({
    $core.String? barcodeCode,
    $core.String? sourceAccountId,
  }) {
    final $result = create();
    if (barcodeCode != null) {
      $result.barcodeCode = barcodeCode;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    return $result;
  }
  ProcessBarcodePaymentRequest._() : super();
  factory ProcessBarcodePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessBarcodePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessBarcodePaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'barcodeCode')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessBarcodePaymentRequest clone() => ProcessBarcodePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessBarcodePaymentRequest copyWith(void Function(ProcessBarcodePaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessBarcodePaymentRequest)) as ProcessBarcodePaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessBarcodePaymentRequest create() => ProcessBarcodePaymentRequest._();
  ProcessBarcodePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessBarcodePaymentRequest> createRepeated() => $pb.PbList<ProcessBarcodePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessBarcodePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessBarcodePaymentRequest>(create);
  static ProcessBarcodePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get barcodeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set barcodeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBarcodeCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearBarcodeCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => clearField(2);
}

class ProcessBarcodePaymentResponse extends $pb.GeneratedMessage {
  factory ProcessBarcodePaymentResponse({
    BarcodeTransaction? transaction,
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
  ProcessBarcodePaymentResponse._() : super();
  factory ProcessBarcodePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessBarcodePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessBarcodePaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOM<BarcodeTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: BarcodeTransaction.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessBarcodePaymentResponse clone() => ProcessBarcodePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessBarcodePaymentResponse copyWith(void Function(ProcessBarcodePaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessBarcodePaymentResponse)) as ProcessBarcodePaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessBarcodePaymentResponse create() => ProcessBarcodePaymentResponse._();
  ProcessBarcodePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessBarcodePaymentResponse> createRepeated() => $pb.PbList<ProcessBarcodePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessBarcodePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessBarcodePaymentResponse>(create);
  static ProcessBarcodePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BarcodeTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(BarcodeTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  BarcodeTransaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetMyGeneratedBarcodesRequest extends $pb.GeneratedMessage {
  factory GetMyGeneratedBarcodesRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetMyGeneratedBarcodesRequest._() : super();
  factory GetMyGeneratedBarcodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyGeneratedBarcodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyGeneratedBarcodesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyGeneratedBarcodesRequest clone() => GetMyGeneratedBarcodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyGeneratedBarcodesRequest copyWith(void Function(GetMyGeneratedBarcodesRequest) updates) => super.copyWith((message) => updates(message as GetMyGeneratedBarcodesRequest)) as GetMyGeneratedBarcodesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyGeneratedBarcodesRequest create() => GetMyGeneratedBarcodesRequest._();
  GetMyGeneratedBarcodesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyGeneratedBarcodesRequest> createRepeated() => $pb.PbList<GetMyGeneratedBarcodesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyGeneratedBarcodesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyGeneratedBarcodesRequest>(create);
  static GetMyGeneratedBarcodesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);
}

class GetMyGeneratedBarcodesResponse extends $pb.GeneratedMessage {
  factory GetMyGeneratedBarcodesResponse({
    $core.Iterable<BarcodePayment>? barcodes,
    $core.int? total,
  }) {
    final $result = create();
    if (barcodes != null) {
      $result.barcodes.addAll(barcodes);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetMyGeneratedBarcodesResponse._() : super();
  factory GetMyGeneratedBarcodesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyGeneratedBarcodesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyGeneratedBarcodesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..pc<BarcodePayment>(1, _omitFieldNames ? '' : 'barcodes', $pb.PbFieldType.PM, subBuilder: BarcodePayment.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyGeneratedBarcodesResponse clone() => GetMyGeneratedBarcodesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyGeneratedBarcodesResponse copyWith(void Function(GetMyGeneratedBarcodesResponse) updates) => super.copyWith((message) => updates(message as GetMyGeneratedBarcodesResponse)) as GetMyGeneratedBarcodesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyGeneratedBarcodesResponse create() => GetMyGeneratedBarcodesResponse._();
  GetMyGeneratedBarcodesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyGeneratedBarcodesResponse> createRepeated() => $pb.PbList<GetMyGeneratedBarcodesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyGeneratedBarcodesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyGeneratedBarcodesResponse>(create);
  static GetMyGeneratedBarcodesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BarcodePayment> get barcodes => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetMyScannedBarcodesRequest extends $pb.GeneratedMessage {
  factory GetMyScannedBarcodesRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetMyScannedBarcodesRequest._() : super();
  factory GetMyScannedBarcodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyScannedBarcodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyScannedBarcodesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyScannedBarcodesRequest clone() => GetMyScannedBarcodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyScannedBarcodesRequest copyWith(void Function(GetMyScannedBarcodesRequest) updates) => super.copyWith((message) => updates(message as GetMyScannedBarcodesRequest)) as GetMyScannedBarcodesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyScannedBarcodesRequest create() => GetMyScannedBarcodesRequest._();
  GetMyScannedBarcodesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyScannedBarcodesRequest> createRepeated() => $pb.PbList<GetMyScannedBarcodesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyScannedBarcodesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyScannedBarcodesRequest>(create);
  static GetMyScannedBarcodesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);
}

class GetMyScannedBarcodesResponse extends $pb.GeneratedMessage {
  factory GetMyScannedBarcodesResponse({
    $core.Iterable<BarcodeTransaction>? transactions,
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
  GetMyScannedBarcodesResponse._() : super();
  factory GetMyScannedBarcodesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyScannedBarcodesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyScannedBarcodesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..pc<BarcodeTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: BarcodeTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyScannedBarcodesResponse clone() => GetMyScannedBarcodesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyScannedBarcodesResponse copyWith(void Function(GetMyScannedBarcodesResponse) updates) => super.copyWith((message) => updates(message as GetMyScannedBarcodesResponse)) as GetMyScannedBarcodesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyScannedBarcodesResponse create() => GetMyScannedBarcodesResponse._();
  GetMyScannedBarcodesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyScannedBarcodesResponse> createRepeated() => $pb.PbList<GetMyScannedBarcodesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyScannedBarcodesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyScannedBarcodesResponse>(create);
  static GetMyScannedBarcodesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BarcodeTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class CancelBarcodeRequest extends $pb.GeneratedMessage {
  factory CancelBarcodeRequest({
    $core.String? barcodeId,
  }) {
    final $result = create();
    if (barcodeId != null) {
      $result.barcodeId = barcodeId;
    }
    return $result;
  }
  CancelBarcodeRequest._() : super();
  factory CancelBarcodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelBarcodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelBarcodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'barcodeId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelBarcodeRequest clone() => CancelBarcodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelBarcodeRequest copyWith(void Function(CancelBarcodeRequest) updates) => super.copyWith((message) => updates(message as CancelBarcodeRequest)) as CancelBarcodeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelBarcodeRequest create() => CancelBarcodeRequest._();
  CancelBarcodeRequest createEmptyInstance() => create();
  static $pb.PbList<CancelBarcodeRequest> createRepeated() => $pb.PbList<CancelBarcodeRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelBarcodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelBarcodeRequest>(create);
  static CancelBarcodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get barcodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set barcodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBarcodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBarcodeId() => clearField(1);
}

class CancelBarcodeResponse extends $pb.GeneratedMessage {
  factory CancelBarcodeResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CancelBarcodeResponse._() : super();
  factory CancelBarcodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelBarcodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelBarcodeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelBarcodeResponse clone() => CancelBarcodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelBarcodeResponse copyWith(void Function(CancelBarcodeResponse) updates) => super.copyWith((message) => updates(message as CancelBarcodeResponse)) as CancelBarcodeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelBarcodeResponse create() => CancelBarcodeResponse._();
  CancelBarcodeResponse createEmptyInstance() => create();
  static $pb.PbList<CancelBarcodeResponse> createRepeated() => $pb.PbList<CancelBarcodeResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelBarcodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelBarcodeResponse>(create);
  static CancelBarcodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

/// Models
class BarcodePayment extends $pb.GeneratedMessage {
  factory BarcodePayment({
    $core.String? id,
    $core.String? userId,
    $core.String? username,
    $core.String? fullName,
    $core.String? barcodeCode,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.String? status,
    $42.Timestamp? createdAt,
    $42.Timestamp? expiresAt,
    $42.Timestamp? paidAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (username != null) {
      $result.username = username;
    }
    if (fullName != null) {
      $result.fullName = fullName;
    }
    if (barcodeCode != null) {
      $result.barcodeCode = barcodeCode;
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
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    if (paidAt != null) {
      $result.paidAt = paidAt;
    }
    return $result;
  }
  BarcodePayment._() : super();
  factory BarcodePayment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarcodePayment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BarcodePayment', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'username')
    ..aOS(4, _omitFieldNames ? '' : 'fullName')
    ..aOS(5, _omitFieldNames ? '' : 'barcodeCode')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOM<$42.Timestamp>(10, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(11, _omitFieldNames ? '' : 'expiresAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(12, _omitFieldNames ? '' : 'paidAt', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarcodePayment clone() => BarcodePayment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarcodePayment copyWith(void Function(BarcodePayment) updates) => super.copyWith((message) => updates(message as BarcodePayment)) as BarcodePayment;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BarcodePayment create() => BarcodePayment._();
  BarcodePayment createEmptyInstance() => create();
  static $pb.PbList<BarcodePayment> createRepeated() => $pb.PbList<BarcodePayment>();
  @$core.pragma('dart2js:noInline')
  static BarcodePayment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarcodePayment>(create);
  static BarcodePayment? _defaultInstance;

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
  $core.String get username => $_getSZ(2);
  @$pb.TagNumber(3)
  set username($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsername() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fullName => $_getSZ(3);
  @$pb.TagNumber(4)
  set fullName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFullName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFullName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get barcodeCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set barcodeCode($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBarcodeCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearBarcodeCode() => clearField(5);

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
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $42.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($42.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $42.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $42.Timestamp get expiresAt => $_getN(10);
  @$pb.TagNumber(11)
  set expiresAt($42.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasExpiresAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearExpiresAt() => clearField(11);
  @$pb.TagNumber(11)
  $42.Timestamp ensureExpiresAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $42.Timestamp get paidAt => $_getN(11);
  @$pb.TagNumber(12)
  set paidAt($42.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasPaidAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearPaidAt() => clearField(12);
  @$pb.TagNumber(12)
  $42.Timestamp ensurePaidAt() => $_ensure(11);
}

class BarcodeTransaction extends $pb.GeneratedMessage {
  factory BarcodeTransaction({
    $core.String? id,
    $core.String? barcodeId,
    $core.String? payerId,
    $core.String? payerUsername,
    $core.String? payerName,
    $core.String? recipientId,
    $core.String? recipientUsername,
    $core.String? recipientName,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.String? referenceNumber,
    $core.String? status,
    $42.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (barcodeId != null) {
      $result.barcodeId = barcodeId;
    }
    if (payerId != null) {
      $result.payerId = payerId;
    }
    if (payerUsername != null) {
      $result.payerUsername = payerUsername;
    }
    if (payerName != null) {
      $result.payerName = payerName;
    }
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    if (recipientUsername != null) {
      $result.recipientUsername = recipientUsername;
    }
    if (recipientName != null) {
      $result.recipientName = recipientName;
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
    if (referenceNumber != null) {
      $result.referenceNumber = referenceNumber;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  BarcodeTransaction._() : super();
  factory BarcodeTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarcodeTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BarcodeTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'barcodeId')
    ..aOS(3, _omitFieldNames ? '' : 'payerId')
    ..aOS(4, _omitFieldNames ? '' : 'payerUsername')
    ..aOS(5, _omitFieldNames ? '' : 'payerName')
    ..aOS(6, _omitFieldNames ? '' : 'recipientId')
    ..aOS(7, _omitFieldNames ? '' : 'recipientUsername')
    ..aOS(8, _omitFieldNames ? '' : 'recipientName')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'currency')
    ..aOS(11, _omitFieldNames ? '' : 'description')
    ..aOS(12, _omitFieldNames ? '' : 'referenceNumber')
    ..aOS(13, _omitFieldNames ? '' : 'status')
    ..aOM<$42.Timestamp>(14, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarcodeTransaction clone() => BarcodeTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarcodeTransaction copyWith(void Function(BarcodeTransaction) updates) => super.copyWith((message) => updates(message as BarcodeTransaction)) as BarcodeTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BarcodeTransaction create() => BarcodeTransaction._();
  BarcodeTransaction createEmptyInstance() => create();
  static $pb.PbList<BarcodeTransaction> createRepeated() => $pb.PbList<BarcodeTransaction>();
  @$core.pragma('dart2js:noInline')
  static BarcodeTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarcodeTransaction>(create);
  static BarcodeTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get barcodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set barcodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBarcodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBarcodeId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get payerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set payerId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayerId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get payerUsername => $_getSZ(3);
  @$pb.TagNumber(4)
  set payerUsername($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPayerUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayerUsername() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get payerName => $_getSZ(4);
  @$pb.TagNumber(5)
  set payerName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPayerName() => $_has(4);
  @$pb.TagNumber(5)
  void clearPayerName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientId => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecipientId() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get recipientUsername => $_getSZ(6);
  @$pb.TagNumber(7)
  set recipientUsername($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRecipientUsername() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientUsername() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get recipientName => $_getSZ(7);
  @$pb.TagNumber(8)
  set recipientName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRecipientName() => $_has(7);
  @$pb.TagNumber(8)
  void clearRecipientName() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get amount => $_getN(8);
  @$pb.TagNumber(9)
  set amount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(9);
  @$pb.TagNumber(10)
  set currency($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrency() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get description => $_getSZ(10);
  @$pb.TagNumber(11)
  set description($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDescription() => $_has(10);
  @$pb.TagNumber(11)
  void clearDescription() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get referenceNumber => $_getSZ(11);
  @$pb.TagNumber(12)
  set referenceNumber($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasReferenceNumber() => $_has(11);
  @$pb.TagNumber(12)
  void clearReferenceNumber() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get status => $_getSZ(12);
  @$pb.TagNumber(13)
  set status($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasStatus() => $_has(12);
  @$pb.TagNumber(13)
  void clearStatus() => clearField(13);

  @$pb.TagNumber(14)
  $42.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($42.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $42.Timestamp ensureCreatedAt() => $_ensure(13);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
