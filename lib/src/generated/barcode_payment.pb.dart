///
//  Generated code. Do not modify.
//  source: barcode_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $36;

class GenerateBarcodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateBarcodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validityMinutes', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GenerateBarcodeRequest._() : super();
  factory GenerateBarcodeRequest({
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.int? validityMinutes,
  }) {
    final _result = create();
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (description != null) {
      _result.description = description;
    }
    if (validityMinutes != null) {
      _result.validityMinutes = validityMinutes;
    }
    return _result;
  }
  factory GenerateBarcodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateBarcodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateBarcodeRequest clone() => GenerateBarcodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateBarcodeRequest copyWith(void Function(GenerateBarcodeRequest) updates) => super.copyWith((message) => updates(message as GenerateBarcodeRequest)) as GenerateBarcodeRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateBarcodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barcodeId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barcodeCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'qrData')
    ..aOM<$36.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $36.Timestamp.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  GenerateBarcodeResponse._() : super();
  factory GenerateBarcodeResponse({
    $core.String? barcodeId,
    $core.String? barcodeCode,
    $core.String? qrData,
    $36.Timestamp? expiresAt,
    $core.String? message,
  }) {
    final _result = create();
    if (barcodeId != null) {
      _result.barcodeId = barcodeId;
    }
    if (barcodeCode != null) {
      _result.barcodeCode = barcodeCode;
    }
    if (qrData != null) {
      _result.qrData = qrData;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory GenerateBarcodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateBarcodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateBarcodeResponse clone() => GenerateBarcodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateBarcodeResponse copyWith(void Function(GenerateBarcodeResponse) updates) => super.copyWith((message) => updates(message as GenerateBarcodeResponse)) as GenerateBarcodeResponse; // ignore: deprecated_member_use
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
  $36.Timestamp get expiresAt => $_getN(3);
  @$pb.TagNumber(4)
  set expiresAt($36.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => clearField(4);
  @$pb.TagNumber(4)
  $36.Timestamp ensureExpiresAt() => $_ensure(3);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBarcodeDetailsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barcodeCode')
    ..hasRequiredFields = false
  ;

  GetBarcodeDetailsRequest._() : super();
  factory GetBarcodeDetailsRequest({
    $core.String? barcodeCode,
  }) {
    final _result = create();
    if (barcodeCode != null) {
      _result.barcodeCode = barcodeCode;
    }
    return _result;
  }
  factory GetBarcodeDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBarcodeDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBarcodeDetailsRequest clone() => GetBarcodeDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBarcodeDetailsRequest copyWith(void Function(GetBarcodeDetailsRequest) updates) => super.copyWith((message) => updates(message as GetBarcodeDetailsRequest)) as GetBarcodeDetailsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBarcodeDetailsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOM<BarcodePayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barcode', subBuilder: BarcodePayment.create)
    ..hasRequiredFields = false
  ;

  GetBarcodeDetailsResponse._() : super();
  factory GetBarcodeDetailsResponse({
    BarcodePayment? barcode,
  }) {
    final _result = create();
    if (barcode != null) {
      _result.barcode = barcode;
    }
    return _result;
  }
  factory GetBarcodeDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBarcodeDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBarcodeDetailsResponse clone() => GetBarcodeDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBarcodeDetailsResponse copyWith(void Function(GetBarcodeDetailsResponse) updates) => super.copyWith((message) => updates(message as GetBarcodeDetailsResponse)) as GetBarcodeDetailsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessBarcodePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barcodeCode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..hasRequiredFields = false
  ;

  ProcessBarcodePaymentRequest._() : super();
  factory ProcessBarcodePaymentRequest({
    $core.String? barcodeCode,
    $core.String? sourceAccountId,
  }) {
    final _result = create();
    if (barcodeCode != null) {
      _result.barcodeCode = barcodeCode;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    return _result;
  }
  factory ProcessBarcodePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessBarcodePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessBarcodePaymentRequest clone() => ProcessBarcodePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessBarcodePaymentRequest copyWith(void Function(ProcessBarcodePaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessBarcodePaymentRequest)) as ProcessBarcodePaymentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessBarcodePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOM<BarcodeTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: BarcodeTransaction.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ProcessBarcodePaymentResponse._() : super();
  factory ProcessBarcodePaymentResponse({
    BarcodeTransaction? transaction,
    $core.String? message,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ProcessBarcodePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessBarcodePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessBarcodePaymentResponse clone() => ProcessBarcodePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessBarcodePaymentResponse copyWith(void Function(ProcessBarcodePaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessBarcodePaymentResponse)) as ProcessBarcodePaymentResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyGeneratedBarcodesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyGeneratedBarcodesRequest._() : super();
  factory GetMyGeneratedBarcodesRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetMyGeneratedBarcodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyGeneratedBarcodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyGeneratedBarcodesRequest clone() => GetMyGeneratedBarcodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyGeneratedBarcodesRequest copyWith(void Function(GetMyGeneratedBarcodesRequest) updates) => super.copyWith((message) => updates(message as GetMyGeneratedBarcodesRequest)) as GetMyGeneratedBarcodesRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyGeneratedBarcodesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..pc<BarcodePayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barcodes', $pb.PbFieldType.PM, subBuilder: BarcodePayment.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyGeneratedBarcodesResponse._() : super();
  factory GetMyGeneratedBarcodesResponse({
    $core.Iterable<BarcodePayment>? barcodes,
    $core.int? total,
  }) {
    final _result = create();
    if (barcodes != null) {
      _result.barcodes.addAll(barcodes);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMyGeneratedBarcodesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyGeneratedBarcodesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyGeneratedBarcodesResponse clone() => GetMyGeneratedBarcodesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyGeneratedBarcodesResponse copyWith(void Function(GetMyGeneratedBarcodesResponse) updates) => super.copyWith((message) => updates(message as GetMyGeneratedBarcodesResponse)) as GetMyGeneratedBarcodesResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyScannedBarcodesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyScannedBarcodesRequest._() : super();
  factory GetMyScannedBarcodesRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetMyScannedBarcodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyScannedBarcodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyScannedBarcodesRequest clone() => GetMyScannedBarcodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyScannedBarcodesRequest copyWith(void Function(GetMyScannedBarcodesRequest) updates) => super.copyWith((message) => updates(message as GetMyScannedBarcodesRequest)) as GetMyScannedBarcodesRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyScannedBarcodesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..pc<BarcodeTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: BarcodeTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyScannedBarcodesResponse._() : super();
  factory GetMyScannedBarcodesResponse({
    $core.Iterable<BarcodeTransaction>? transactions,
    $core.int? total,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMyScannedBarcodesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyScannedBarcodesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyScannedBarcodesResponse clone() => GetMyScannedBarcodesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyScannedBarcodesResponse copyWith(void Function(GetMyScannedBarcodesResponse) updates) => super.copyWith((message) => updates(message as GetMyScannedBarcodesResponse)) as GetMyScannedBarcodesResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelBarcodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barcodeId')
    ..hasRequiredFields = false
  ;

  CancelBarcodeRequest._() : super();
  factory CancelBarcodeRequest({
    $core.String? barcodeId,
  }) {
    final _result = create();
    if (barcodeId != null) {
      _result.barcodeId = barcodeId;
    }
    return _result;
  }
  factory CancelBarcodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelBarcodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelBarcodeRequest clone() => CancelBarcodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelBarcodeRequest copyWith(void Function(CancelBarcodeRequest) updates) => super.copyWith((message) => updates(message as CancelBarcodeRequest)) as CancelBarcodeRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelBarcodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CancelBarcodeResponse._() : super();
  factory CancelBarcodeResponse({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CancelBarcodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelBarcodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelBarcodeResponse clone() => CancelBarcodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelBarcodeResponse copyWith(void Function(CancelBarcodeResponse) updates) => super.copyWith((message) => updates(message as CancelBarcodeResponse)) as CancelBarcodeResponse; // ignore: deprecated_member_use
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

class BarcodePayment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarcodePayment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fullName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barcodeCode')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOM<$36.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paidAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  BarcodePayment._() : super();
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
    $36.Timestamp? createdAt,
    $36.Timestamp? expiresAt,
    $36.Timestamp? paidAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (username != null) {
      _result.username = username;
    }
    if (fullName != null) {
      _result.fullName = fullName;
    }
    if (barcodeCode != null) {
      _result.barcodeCode = barcodeCode;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (description != null) {
      _result.description = description;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    if (paidAt != null) {
      _result.paidAt = paidAt;
    }
    return _result;
  }
  factory BarcodePayment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarcodePayment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarcodePayment clone() => BarcodePayment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarcodePayment copyWith(void Function(BarcodePayment) updates) => super.copyWith((message) => updates(message as BarcodePayment)) as BarcodePayment; // ignore: deprecated_member_use
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
  $36.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($36.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $36.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $36.Timestamp get expiresAt => $_getN(10);
  @$pb.TagNumber(11)
  set expiresAt($36.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasExpiresAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearExpiresAt() => clearField(11);
  @$pb.TagNumber(11)
  $36.Timestamp ensureExpiresAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $36.Timestamp get paidAt => $_getN(11);
  @$pb.TagNumber(12)
  set paidAt($36.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasPaidAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearPaidAt() => clearField(12);
  @$pb.TagNumber(12)
  $36.Timestamp ensurePaidAt() => $_ensure(11);
}

class BarcodeTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarcodeTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'barcode_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barcodeId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerUsername')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientUsername')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referenceNumber')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOM<$36.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  BarcodeTransaction._() : super();
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
    $36.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (barcodeId != null) {
      _result.barcodeId = barcodeId;
    }
    if (payerId != null) {
      _result.payerId = payerId;
    }
    if (payerUsername != null) {
      _result.payerUsername = payerUsername;
    }
    if (payerName != null) {
      _result.payerName = payerName;
    }
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    if (recipientUsername != null) {
      _result.recipientUsername = recipientUsername;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (description != null) {
      _result.description = description;
    }
    if (referenceNumber != null) {
      _result.referenceNumber = referenceNumber;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory BarcodeTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarcodeTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarcodeTransaction clone() => BarcodeTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarcodeTransaction copyWith(void Function(BarcodeTransaction) updates) => super.copyWith((message) => updates(message as BarcodeTransaction)) as BarcodeTransaction; // ignore: deprecated_member_use
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

