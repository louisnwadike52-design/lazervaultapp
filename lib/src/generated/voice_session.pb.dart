//
//  Generated code. Do not modify.
//  source: voice_session.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class StartVoiceSessionRequest extends $pb.GeneratedMessage {
  factory StartVoiceSessionRequest({
    $core.String? serviceName,
    $core.String? preferredAgentLanguage,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (preferredAgentLanguage != null) {
      $result.preferredAgentLanguage = preferredAgentLanguage;
    }
    return $result;
  }
  StartVoiceSessionRequest._() : super();
  factory StartVoiceSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartVoiceSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StartVoiceSessionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOS(2, _omitFieldNames ? '' : 'preferredAgentLanguage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartVoiceSessionRequest clone() => StartVoiceSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartVoiceSessionRequest copyWith(void Function(StartVoiceSessionRequest) updates) => super.copyWith((message) => updates(message as StartVoiceSessionRequest)) as StartVoiceSessionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartVoiceSessionRequest create() => StartVoiceSessionRequest._();
  StartVoiceSessionRequest createEmptyInstance() => create();
  static $pb.PbList<StartVoiceSessionRequest> createRepeated() => $pb.PbList<StartVoiceSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static StartVoiceSessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartVoiceSessionRequest>(create);
  static StartVoiceSessionRequest? _defaultInstance;

  /// Service name for routing to specific voice agent (e.g., "stocks", "transfers", "crypto")
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);

  /// Preferred language for the voice agent (optional)
  @$pb.TagNumber(2)
  $core.String get preferredAgentLanguage => $_getSZ(1);
  @$pb.TagNumber(2)
  set preferredAgentLanguage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPreferredAgentLanguage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreferredAgentLanguage() => clearField(2);
}

class StartVoiceSessionResponse extends $pb.GeneratedMessage {
  factory StartVoiceSessionResponse({
    $core.String? roomName,
    $core.String? livekitToken,
    $core.String? agentId,
    $core.String? agentUrl,
    $core.int? agentPort,
  }) {
    final $result = create();
    if (roomName != null) {
      $result.roomName = roomName;
    }
    if (livekitToken != null) {
      $result.livekitToken = livekitToken;
    }
    if (agentId != null) {
      $result.agentId = agentId;
    }
    if (agentUrl != null) {
      $result.agentUrl = agentUrl;
    }
    if (agentPort != null) {
      $result.agentPort = agentPort;
    }
    return $result;
  }
  StartVoiceSessionResponse._() : super();
  factory StartVoiceSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartVoiceSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StartVoiceSessionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomName')
    ..aOS(2, _omitFieldNames ? '' : 'livekitToken')
    ..aOS(3, _omitFieldNames ? '' : 'agentId')
    ..aOS(4, _omitFieldNames ? '' : 'agentUrl')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'agentPort', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartVoiceSessionResponse clone() => StartVoiceSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartVoiceSessionResponse copyWith(void Function(StartVoiceSessionResponse) updates) => super.copyWith((message) => updates(message as StartVoiceSessionResponse)) as StartVoiceSessionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartVoiceSessionResponse create() => StartVoiceSessionResponse._();
  StartVoiceSessionResponse createEmptyInstance() => create();
  static $pb.PbList<StartVoiceSessionResponse> createRepeated() => $pb.PbList<StartVoiceSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static StartVoiceSessionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartVoiceSessionResponse>(create);
  static StartVoiceSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomName => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomName() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get livekitToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set livekitToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLivekitToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearLivekitToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get agentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set agentId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAgentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAgentId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get agentUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set agentUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAgentUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearAgentUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get agentPort => $_getIZ(4);
  @$pb.TagNumber(5)
  set agentPort($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAgentPort() => $_has(4);
  @$pb.TagNumber(5)
  void clearAgentPort() => clearField(5);
}

/// Voice note processing request - accepts multipart form data file upload
class ProcessVoiceNoteRequest extends $pb.GeneratedMessage {
  factory ProcessVoiceNoteRequest({
    $core.String? txHistory,
  }) {
    final $result = create();
    if (txHistory != null) {
      $result.txHistory = txHistory;
    }
    return $result;
  }
  ProcessVoiceNoteRequest._() : super();
  factory ProcessVoiceNoteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessVoiceNoteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessVoiceNoteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'txHistory')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessVoiceNoteRequest clone() => ProcessVoiceNoteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessVoiceNoteRequest copyWith(void Function(ProcessVoiceNoteRequest) updates) => super.copyWith((message) => updates(message as ProcessVoiceNoteRequest)) as ProcessVoiceNoteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessVoiceNoteRequest create() => ProcessVoiceNoteRequest._();
  ProcessVoiceNoteRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessVoiceNoteRequest> createRepeated() => $pb.PbList<ProcessVoiceNoteRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessVoiceNoteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessVoiceNoteRequest>(create);
  static ProcessVoiceNoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get txHistory => $_getSZ(0);
  @$pb.TagNumber(1)
  set txHistory($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxHistory() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxHistory() => clearField(1);
}

/// Voice note processing response
class ProcessVoiceNoteResponse extends $pb.GeneratedMessage {
  factory ProcessVoiceNoteResponse({
    $core.bool? success,
    $core.String? msg,
    $core.String? response,
    $core.String? transcribedText,
    $fixnum.Int64? processingTimeMs,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    if (response != null) {
      $result.response = response;
    }
    if (transcribedText != null) {
      $result.transcribedText = transcribedText;
    }
    if (processingTimeMs != null) {
      $result.processingTimeMs = processingTimeMs;
    }
    return $result;
  }
  ProcessVoiceNoteResponse._() : super();
  factory ProcessVoiceNoteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessVoiceNoteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessVoiceNoteResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOS(3, _omitFieldNames ? '' : 'response')
    ..aOS(4, _omitFieldNames ? '' : 'transcribedText')
    ..aInt64(5, _omitFieldNames ? '' : 'processingTimeMs')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessVoiceNoteResponse clone() => ProcessVoiceNoteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessVoiceNoteResponse copyWith(void Function(ProcessVoiceNoteResponse) updates) => super.copyWith((message) => updates(message as ProcessVoiceNoteResponse)) as ProcessVoiceNoteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessVoiceNoteResponse create() => ProcessVoiceNoteResponse._();
  ProcessVoiceNoteResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessVoiceNoteResponse> createRepeated() => $pb.PbList<ProcessVoiceNoteResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessVoiceNoteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessVoiceNoteResponse>(create);
  static ProcessVoiceNoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get response => $_getSZ(2);
  @$pb.TagNumber(3)
  set response($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasResponse() => $_has(2);
  @$pb.TagNumber(3)
  void clearResponse() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get transcribedText => $_getSZ(3);
  @$pb.TagNumber(4)
  set transcribedText($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTranscribedText() => $_has(3);
  @$pb.TagNumber(4)
  void clearTranscribedText() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get processingTimeMs => $_getI64(4);
  @$pb.TagNumber(5)
  set processingTimeMs($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProcessingTimeMs() => $_has(4);
  @$pb.TagNumber(5)
  void clearProcessingTimeMs() => clearField(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
