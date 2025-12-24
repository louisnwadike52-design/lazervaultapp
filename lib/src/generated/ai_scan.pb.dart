///
//  Generated code. Do not modify.
//  source: ai_scan.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'ai_scan.pbenum.dart';

export 'ai_scan.pbenum.dart';

class StartScanSessionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartScanSessionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<ScanType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanType', $pb.PbFieldType.OE, defaultOrMaker: ScanType.SCAN_TYPE_UNSPECIFIED, valueOf: ScanType.valueOf, enumValues: ScanType.values)
    ..hasRequiredFields = false
  ;

  StartScanSessionRequest._() : super();
  factory StartScanSessionRequest({
    $core.String? userId,
    ScanType? scanType,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (scanType != null) {
      _result.scanType = scanType;
    }
    return _result;
  }
  factory StartScanSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartScanSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartScanSessionRequest clone() => StartScanSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartScanSessionRequest copyWith(void Function(StartScanSessionRequest) updates) => super.copyWith((message) => updates(message as StartScanSessionRequest)) as StartScanSessionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StartScanSessionRequest create() => StartScanSessionRequest._();
  StartScanSessionRequest createEmptyInstance() => create();
  static $pb.PbList<StartScanSessionRequest> createRepeated() => $pb.PbList<StartScanSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static StartScanSessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartScanSessionRequest>(create);
  static StartScanSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  ScanType get scanType => $_getN(1);
  @$pb.TagNumber(2)
  set scanType(ScanType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasScanType() => $_has(1);
  @$pb.TagNumber(2)
  void clearScanType() => clearField(2);
}

class StartScanSessionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartScanSessionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..e<ScanType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanType', $pb.PbFieldType.OE, defaultOrMaker: ScanType.SCAN_TYPE_UNSPECIFIED, valueOf: ScanType.valueOf, enumValues: ScanType.values)
    ..e<ScanStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ScanStatus.SCAN_STATUS_UNSPECIFIED, valueOf: ScanStatus.valueOf, enumValues: ScanStatus.values)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  StartScanSessionResponse._() : super();
  factory StartScanSessionResponse({
    $core.String? sessionId,
    ScanType? scanType,
    ScanStatus? status,
    $fixnum.Int64? createdAt,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (scanType != null) {
      _result.scanType = scanType;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory StartScanSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartScanSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartScanSessionResponse clone() => StartScanSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartScanSessionResponse copyWith(void Function(StartScanSessionResponse) updates) => super.copyWith((message) => updates(message as StartScanSessionResponse)) as StartScanSessionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StartScanSessionResponse create() => StartScanSessionResponse._();
  StartScanSessionResponse createEmptyInstance() => create();
  static $pb.PbList<StartScanSessionResponse> createRepeated() => $pb.PbList<StartScanSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static StartScanSessionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartScanSessionResponse>(create);
  static StartScanSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);

  @$pb.TagNumber(2)
  ScanType get scanType => $_getN(1);
  @$pb.TagNumber(2)
  set scanType(ScanType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasScanType() => $_has(1);
  @$pb.TagNumber(2)
  void clearScanType() => clearField(2);

  @$pb.TagNumber(3)
  ScanStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(ScanStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get createdAt => $_getI64(3);
  @$pb.TagNumber(4)
  set createdAt($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => clearField(4);
}

class ProcessImageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessImageRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageData', $pb.PbFieldType.OY)
    ..e<ScanType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanType', $pb.PbFieldType.OE, defaultOrMaker: ScanType.SCAN_TYPE_UNSPECIFIED, valueOf: ScanType.valueOf, enumValues: ScanType.values)
    ..hasRequiredFields = false
  ;

  ProcessImageRequest._() : super();
  factory ProcessImageRequest({
    $core.String? sessionId,
    $core.List<$core.int>? imageData,
    ScanType? scanType,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (imageData != null) {
      _result.imageData = imageData;
    }
    if (scanType != null) {
      _result.scanType = scanType;
    }
    return _result;
  }
  factory ProcessImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessImageRequest clone() => ProcessImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessImageRequest copyWith(void Function(ProcessImageRequest) updates) => super.copyWith((message) => updates(message as ProcessImageRequest)) as ProcessImageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessImageRequest create() => ProcessImageRequest._();
  ProcessImageRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessImageRequest> createRepeated() => $pb.PbList<ProcessImageRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessImageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessImageRequest>(create);
  static ProcessImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get imageData => $_getN(1);
  @$pb.TagNumber(2)
  set imageData($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasImageData() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageData() => clearField(2);

  @$pb.TagNumber(3)
  ScanType get scanType => $_getN(2);
  @$pb.TagNumber(3)
  set scanType(ScanType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasScanType() => $_has(2);
  @$pb.TagNumber(3)
  void clearScanType() => clearField(3);
}

class ExtractedData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExtractedData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipient')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueDate')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'routingNumber')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..m<$core.String, $core.String>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'additionalFields', entryClassName: 'ExtractedData.AdditionalFieldsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('ai_scan'))
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confidenceScore', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  ExtractedData._() : super();
  factory ExtractedData({
    $core.String? recipient,
    $core.double? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? dueDate,
    $core.String? description,
    $core.String? accountNumber,
    $core.String? routingNumber,
    $core.String? bankName,
    $core.Map<$core.String, $core.String>? additionalFields,
    $core.double? confidenceScore,
  }) {
    final _result = create();
    if (recipient != null) {
      _result.recipient = recipient;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (dueDate != null) {
      _result.dueDate = dueDate;
    }
    if (description != null) {
      _result.description = description;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (routingNumber != null) {
      _result.routingNumber = routingNumber;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (additionalFields != null) {
      _result.additionalFields.addAll(additionalFields);
    }
    if (confidenceScore != null) {
      _result.confidenceScore = confidenceScore;
    }
    return _result;
  }
  factory ExtractedData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExtractedData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExtractedData clone() => ExtractedData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExtractedData copyWith(void Function(ExtractedData) updates) => super.copyWith((message) => updates(message as ExtractedData)) as ExtractedData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExtractedData create() => ExtractedData._();
  ExtractedData createEmptyInstance() => create();
  static $pb.PbList<ExtractedData> createRepeated() => $pb.PbList<ExtractedData>();
  @$core.pragma('dart2js:noInline')
  static ExtractedData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExtractedData>(create);
  static ExtractedData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recipient => $_getSZ(0);
  @$pb.TagNumber(1)
  set recipient($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipient() => clearField(1);

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
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get dueDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set dueDate($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDueDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearDueDate() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get accountNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set accountNumber($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAccountNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearAccountNumber() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get routingNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set routingNumber($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRoutingNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearRoutingNumber() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get bankName => $_getSZ(8);
  @$pb.TagNumber(9)
  set bankName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasBankName() => $_has(8);
  @$pb.TagNumber(9)
  void clearBankName() => clearField(9);

  @$pb.TagNumber(10)
  $core.Map<$core.String, $core.String> get additionalFields => $_getMap(9);

  @$pb.TagNumber(11)
  $core.double get confidenceScore => $_getN(10);
  @$pb.TagNumber(11)
  set confidenceScore($core.double v) { $_setFloat(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasConfidenceScore() => $_has(10);
  @$pb.TagNumber(11)
  void clearConfidenceScore() => clearField(11);
}

class ProcessImageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessImageResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..aOM<ExtractedData>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'extractedData', subBuilder: ExtractedData.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'aiMessage')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  ProcessImageResponse._() : super();
  factory ProcessImageResponse({
    $core.String? sessionId,
    ExtractedData? extractedData,
    $core.String? aiMessage,
    $core.bool? success,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (extractedData != null) {
      _result.extractedData = extractedData;
    }
    if (aiMessage != null) {
      _result.aiMessage = aiMessage;
    }
    if (success != null) {
      _result.success = success;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory ProcessImageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessImageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessImageResponse clone() => ProcessImageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessImageResponse copyWith(void Function(ProcessImageResponse) updates) => super.copyWith((message) => updates(message as ProcessImageResponse)) as ProcessImageResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessImageResponse create() => ProcessImageResponse._();
  ProcessImageResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessImageResponse> createRepeated() => $pb.PbList<ProcessImageResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessImageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessImageResponse>(create);
  static ProcessImageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);

  @$pb.TagNumber(2)
  ExtractedData get extractedData => $_getN(1);
  @$pb.TagNumber(2)
  set extractedData(ExtractedData v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasExtractedData() => $_has(1);
  @$pb.TagNumber(2)
  void clearExtractedData() => clearField(2);
  @$pb.TagNumber(2)
  ExtractedData ensureExtractedData() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get aiMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set aiMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAiMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearAiMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get success => $_getBF(3);
  @$pb.TagNumber(4)
  set success($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSuccess() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuccess() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get errorMessage => $_getSZ(4);
  @$pb.TagNumber(5)
  set errorMessage($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasErrorMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearErrorMessage() => clearField(5);
}

class SendChatMessageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendChatMessageRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userMessage')
    ..aOM<ExtractedData>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contextData', subBuilder: ExtractedData.create)
    ..hasRequiredFields = false
  ;

  SendChatMessageRequest._() : super();
  factory SendChatMessageRequest({
    $core.String? sessionId,
    $core.String? userMessage,
    ExtractedData? contextData,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (userMessage != null) {
      _result.userMessage = userMessage;
    }
    if (contextData != null) {
      _result.contextData = contextData;
    }
    return _result;
  }
  factory SendChatMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendChatMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendChatMessageRequest clone() => SendChatMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendChatMessageRequest copyWith(void Function(SendChatMessageRequest) updates) => super.copyWith((message) => updates(message as SendChatMessageRequest)) as SendChatMessageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendChatMessageRequest create() => SendChatMessageRequest._();
  SendChatMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SendChatMessageRequest> createRepeated() => $pb.PbList<SendChatMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SendChatMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendChatMessageRequest>(create);
  static SendChatMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set userMessage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserMessage() => clearField(2);

  @$pb.TagNumber(3)
  ExtractedData get contextData => $_getN(2);
  @$pb.TagNumber(3)
  set contextData(ExtractedData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasContextData() => $_has(2);
  @$pb.TagNumber(3)
  void clearContextData() => clearField(3);
  @$pb.TagNumber(3)
  ExtractedData ensureContextData() => $_ensure(2);
}

class SendChatMessageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendChatMessageResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messageId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'aiResponse')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  SendChatMessageResponse._() : super();
  factory SendChatMessageResponse({
    $core.String? messageId,
    $core.String? aiResponse,
    $fixnum.Int64? timestamp,
  }) {
    final _result = create();
    if (messageId != null) {
      _result.messageId = messageId;
    }
    if (aiResponse != null) {
      _result.aiResponse = aiResponse;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory SendChatMessageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendChatMessageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendChatMessageResponse clone() => SendChatMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendChatMessageResponse copyWith(void Function(SendChatMessageResponse) updates) => super.copyWith((message) => updates(message as SendChatMessageResponse)) as SendChatMessageResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendChatMessageResponse create() => SendChatMessageResponse._();
  SendChatMessageResponse createEmptyInstance() => create();
  static $pb.PbList<SendChatMessageResponse> createRepeated() => $pb.PbList<SendChatMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static SendChatMessageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendChatMessageResponse>(create);
  static SendChatMessageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get messageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set messageId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get aiResponse => $_getSZ(1);
  @$pb.TagNumber(2)
  set aiResponse($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAiResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearAiResponse() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get timestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set timestamp($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);
}

class GeneratePaymentInstructionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GeneratePaymentInstructionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..aOM<ExtractedData>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'extractedData', subBuilder: ExtractedData.create)
    ..e<ScanType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanType', $pb.PbFieldType.OE, defaultOrMaker: ScanType.SCAN_TYPE_UNSPECIFIED, valueOf: ScanType.valueOf, enumValues: ScanType.values)
    ..hasRequiredFields = false
  ;

  GeneratePaymentInstructionRequest._() : super();
  factory GeneratePaymentInstructionRequest({
    $core.String? sessionId,
    ExtractedData? extractedData,
    ScanType? scanType,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (extractedData != null) {
      _result.extractedData = extractedData;
    }
    if (scanType != null) {
      _result.scanType = scanType;
    }
    return _result;
  }
  factory GeneratePaymentInstructionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GeneratePaymentInstructionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GeneratePaymentInstructionRequest clone() => GeneratePaymentInstructionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GeneratePaymentInstructionRequest copyWith(void Function(GeneratePaymentInstructionRequest) updates) => super.copyWith((message) => updates(message as GeneratePaymentInstructionRequest)) as GeneratePaymentInstructionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GeneratePaymentInstructionRequest create() => GeneratePaymentInstructionRequest._();
  GeneratePaymentInstructionRequest createEmptyInstance() => create();
  static $pb.PbList<GeneratePaymentInstructionRequest> createRepeated() => $pb.PbList<GeneratePaymentInstructionRequest>();
  @$core.pragma('dart2js:noInline')
  static GeneratePaymentInstructionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GeneratePaymentInstructionRequest>(create);
  static GeneratePaymentInstructionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);

  @$pb.TagNumber(2)
  ExtractedData get extractedData => $_getN(1);
  @$pb.TagNumber(2)
  set extractedData(ExtractedData v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasExtractedData() => $_has(1);
  @$pb.TagNumber(2)
  void clearExtractedData() => clearField(2);
  @$pb.TagNumber(2)
  ExtractedData ensureExtractedData() => $_ensure(1);

  @$pb.TagNumber(3)
  ScanType get scanType => $_getN(2);
  @$pb.TagNumber(3)
  set scanType(ScanType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasScanType() => $_has(2);
  @$pb.TagNumber(3)
  void clearScanType() => clearField(3);
}

class PaymentInstruction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PaymentInstruction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'instructionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipient')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..m<$core.String, $core.String>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'PaymentInstruction.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('ai_scan'))
    ..hasRequiredFields = false
  ;

  PaymentInstruction._() : super();
  factory PaymentInstruction({
    $core.String? instructionId,
    $core.String? recipient,
    $core.double? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? description,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final _result = create();
    if (instructionId != null) {
      _result.instructionId = instructionId;
    }
    if (recipient != null) {
      _result.recipient = recipient;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (description != null) {
      _result.description = description;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    return _result;
  }
  factory PaymentInstruction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentInstruction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentInstruction clone() => PaymentInstruction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentInstruction copyWith(void Function(PaymentInstruction) updates) => super.copyWith((message) => updates(message as PaymentInstruction)) as PaymentInstruction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PaymentInstruction create() => PaymentInstruction._();
  PaymentInstruction createEmptyInstance() => create();
  static $pb.PbList<PaymentInstruction> createRepeated() => $pb.PbList<PaymentInstruction>();
  @$core.pragma('dart2js:noInline')
  static PaymentInstruction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentInstruction>(create);
  static PaymentInstruction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get instructionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set instructionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInstructionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInstructionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get recipient => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipient($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecipient() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipient() => clearField(2);

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
  $core.String get reference => $_getSZ(4);
  @$pb.TagNumber(5)
  set reference($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearReference() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(6);
}

class GeneratePaymentInstructionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GeneratePaymentInstructionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOM<PaymentInstruction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'instruction', subBuilder: PaymentInstruction.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  GeneratePaymentInstructionResponse._() : super();
  factory GeneratePaymentInstructionResponse({
    PaymentInstruction? instruction,
    $core.bool? success,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (instruction != null) {
      _result.instruction = instruction;
    }
    if (success != null) {
      _result.success = success;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory GeneratePaymentInstructionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GeneratePaymentInstructionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GeneratePaymentInstructionResponse clone() => GeneratePaymentInstructionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GeneratePaymentInstructionResponse copyWith(void Function(GeneratePaymentInstructionResponse) updates) => super.copyWith((message) => updates(message as GeneratePaymentInstructionResponse)) as GeneratePaymentInstructionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GeneratePaymentInstructionResponse create() => GeneratePaymentInstructionResponse._();
  GeneratePaymentInstructionResponse createEmptyInstance() => create();
  static $pb.PbList<GeneratePaymentInstructionResponse> createRepeated() => $pb.PbList<GeneratePaymentInstructionResponse>();
  @$core.pragma('dart2js:noInline')
  static GeneratePaymentInstructionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GeneratePaymentInstructionResponse>(create);
  static GeneratePaymentInstructionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentInstruction get instruction => $_getN(0);
  @$pb.TagNumber(1)
  set instruction(PaymentInstruction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInstruction() => $_has(0);
  @$pb.TagNumber(1)
  void clearInstruction() => clearField(1);
  @$pb.TagNumber(1)
  PaymentInstruction ensureInstruction() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);
}

class ProcessPaymentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessPaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..aOM<PaymentInstruction>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'instruction', subBuilder: PaymentInstruction.create)
    ..hasRequiredFields = false
  ;

  ProcessPaymentRequest._() : super();
  factory ProcessPaymentRequest({
    $core.String? userId,
    $core.String? sessionId,
    PaymentInstruction? instruction,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (instruction != null) {
      _result.instruction = instruction;
    }
    return _result;
  }
  factory ProcessPaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPaymentRequest clone() => ProcessPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPaymentRequest copyWith(void Function(ProcessPaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessPaymentRequest)) as ProcessPaymentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessPaymentRequest create() => ProcessPaymentRequest._();
  ProcessPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessPaymentRequest> createRepeated() => $pb.PbList<ProcessPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessPaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessPaymentRequest>(create);
  static ProcessPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => clearField(2);

  @$pb.TagNumber(3)
  PaymentInstruction get instruction => $_getN(2);
  @$pb.TagNumber(3)
  set instruction(PaymentInstruction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasInstruction() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstruction() => clearField(3);
  @$pb.TagNumber(3)
  PaymentInstruction ensureInstruction() => $_ensure(2);
}

class ProcessPaymentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessPaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  ProcessPaymentResponse._() : super();
  factory ProcessPaymentResponse({
    $core.String? transactionId,
    $core.bool? success,
    $core.String? status,
    $core.String? errorMessage,
    $fixnum.Int64? timestamp,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (success != null) {
      _result.success = success;
    }
    if (status != null) {
      _result.status = status;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory ProcessPaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPaymentResponse clone() => ProcessPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPaymentResponse copyWith(void Function(ProcessPaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessPaymentResponse)) as ProcessPaymentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessPaymentResponse create() => ProcessPaymentResponse._();
  ProcessPaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessPaymentResponse> createRepeated() => $pb.PbList<ProcessPaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessPaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessPaymentResponse>(create);
  static ProcessPaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get errorMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set errorMessage($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasErrorMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorMessage() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get timestamp => $_getI64(4);
  @$pb.TagNumber(5)
  set timestamp($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => clearField(5);
}

class GetScanHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetScanHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetScanHistoryRequest._() : super();
  factory GetScanHistoryRequest({
    $core.String? userId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetScanHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetScanHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetScanHistoryRequest clone() => GetScanHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetScanHistoryRequest copyWith(void Function(GetScanHistoryRequest) updates) => super.copyWith((message) => updates(message as GetScanHistoryRequest)) as GetScanHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetScanHistoryRequest create() => GetScanHistoryRequest._();
  GetScanHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetScanHistoryRequest> createRepeated() => $pb.PbList<GetScanHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetScanHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetScanHistoryRequest>(create);
  static GetScanHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => clearField(3);
}

class ScanSessionHistory extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ScanSessionHistory', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..e<ScanType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanType', $pb.PbFieldType.OE, defaultOrMaker: ScanType.SCAN_TYPE_UNSPECIFIED, valueOf: ScanType.valueOf, enumValues: ScanType.values)
    ..e<ScanStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ScanStatus.SCAN_STATUS_UNSPECIFIED, valueOf: ScanStatus.valueOf, enumValues: ScanStatus.values)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOM<ExtractedData>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'extractedData', subBuilder: ExtractedData.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  ScanSessionHistory._() : super();
  factory ScanSessionHistory({
    $core.String? sessionId,
    ScanType? scanType,
    ScanStatus? status,
    $fixnum.Int64? createdAt,
    ExtractedData? extractedData,
    $core.String? transactionId,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (scanType != null) {
      _result.scanType = scanType;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (extractedData != null) {
      _result.extractedData = extractedData;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    return _result;
  }
  factory ScanSessionHistory.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScanSessionHistory.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScanSessionHistory clone() => ScanSessionHistory()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScanSessionHistory copyWith(void Function(ScanSessionHistory) updates) => super.copyWith((message) => updates(message as ScanSessionHistory)) as ScanSessionHistory; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScanSessionHistory create() => ScanSessionHistory._();
  ScanSessionHistory createEmptyInstance() => create();
  static $pb.PbList<ScanSessionHistory> createRepeated() => $pb.PbList<ScanSessionHistory>();
  @$core.pragma('dart2js:noInline')
  static ScanSessionHistory getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScanSessionHistory>(create);
  static ScanSessionHistory? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);

  @$pb.TagNumber(2)
  ScanType get scanType => $_getN(1);
  @$pb.TagNumber(2)
  set scanType(ScanType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasScanType() => $_has(1);
  @$pb.TagNumber(2)
  void clearScanType() => clearField(2);

  @$pb.TagNumber(3)
  ScanStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(ScanStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get createdAt => $_getI64(3);
  @$pb.TagNumber(4)
  set createdAt($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => clearField(4);

  @$pb.TagNumber(5)
  ExtractedData get extractedData => $_getN(4);
  @$pb.TagNumber(5)
  set extractedData(ExtractedData v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasExtractedData() => $_has(4);
  @$pb.TagNumber(5)
  void clearExtractedData() => clearField(5);
  @$pb.TagNumber(5)
  ExtractedData ensureExtractedData() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);
}

class GetScanHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetScanHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ai_scan'), createEmptyInstance: create)
    ..pc<ScanSessionHistory>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessions', $pb.PbFieldType.PM, subBuilder: ScanSessionHistory.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetScanHistoryResponse._() : super();
  factory GetScanHistoryResponse({
    $core.Iterable<ScanSessionHistory>? sessions,
    $core.int? totalCount,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (sessions != null) {
      _result.sessions.addAll(sessions);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetScanHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetScanHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetScanHistoryResponse clone() => GetScanHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetScanHistoryResponse copyWith(void Function(GetScanHistoryResponse) updates) => super.copyWith((message) => updates(message as GetScanHistoryResponse)) as GetScanHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetScanHistoryResponse create() => GetScanHistoryResponse._();
  GetScanHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetScanHistoryResponse> createRepeated() => $pb.PbList<GetScanHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetScanHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetScanHistoryResponse>(create);
  static GetScanHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ScanSessionHistory> get sessions => $_getList(0);

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
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => clearField(4);
}

