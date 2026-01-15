///
//  Generated code. Do not modify.
//  source: voice_session.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class StartVoiceSessionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartVoiceSessionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serviceName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferredAgentLanguage')
    ..hasRequiredFields = false
  ;

  StartVoiceSessionRequest._() : super();
  factory StartVoiceSessionRequest({
    $core.String? serviceName,
    $core.String? preferredAgentLanguage,
  }) {
    final _result = create();
    if (serviceName != null) {
      _result.serviceName = serviceName;
    }
    if (preferredAgentLanguage != null) {
      _result.preferredAgentLanguage = preferredAgentLanguage;
    }
    return _result;
  }
  factory StartVoiceSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartVoiceSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartVoiceSessionRequest clone() => StartVoiceSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartVoiceSessionRequest copyWith(void Function(StartVoiceSessionRequest) updates) => super.copyWith((message) => updates(message as StartVoiceSessionRequest)) as StartVoiceSessionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StartVoiceSessionRequest create() => StartVoiceSessionRequest._();
  StartVoiceSessionRequest createEmptyInstance() => create();
  static $pb.PbList<StartVoiceSessionRequest> createRepeated() => $pb.PbList<StartVoiceSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static StartVoiceSessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartVoiceSessionRequest>(create);
  static StartVoiceSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartVoiceSessionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roomName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'livekitToken')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'agentId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'agentUrl')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'agentPort', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  StartVoiceSessionResponse._() : super();
  factory StartVoiceSessionResponse({
    $core.String? roomName,
    $core.String? livekitToken,
    $core.String? agentId,
    $core.String? agentUrl,
    $core.int? agentPort,
  }) {
    final _result = create();
    if (roomName != null) {
      _result.roomName = roomName;
    }
    if (livekitToken != null) {
      _result.livekitToken = livekitToken;
    }
    if (agentId != null) {
      _result.agentId = agentId;
    }
    if (agentUrl != null) {
      _result.agentUrl = agentUrl;
    }
    if (agentPort != null) {
      _result.agentPort = agentPort;
    }
    return _result;
  }
  factory StartVoiceSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartVoiceSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartVoiceSessionResponse clone() => StartVoiceSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartVoiceSessionResponse copyWith(void Function(StartVoiceSessionResponse) updates) => super.copyWith((message) => updates(message as StartVoiceSessionResponse)) as StartVoiceSessionResponse; // ignore: deprecated_member_use
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

class ProcessVoiceNoteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessVoiceNoteRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'txHistory')
    ..hasRequiredFields = false
  ;

  ProcessVoiceNoteRequest._() : super();
  factory ProcessVoiceNoteRequest({
    $core.String? txHistory,
  }) {
    final _result = create();
    if (txHistory != null) {
      _result.txHistory = txHistory;
    }
    return _result;
  }
  factory ProcessVoiceNoteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessVoiceNoteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessVoiceNoteRequest clone() => ProcessVoiceNoteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessVoiceNoteRequest copyWith(void Function(ProcessVoiceNoteRequest) updates) => super.copyWith((message) => updates(message as ProcessVoiceNoteRequest)) as ProcessVoiceNoteRequest; // ignore: deprecated_member_use
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

class ProcessVoiceNoteResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessVoiceNoteResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'response')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transcribedText')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'processingTimeMs')
    ..hasRequiredFields = false
  ;

  ProcessVoiceNoteResponse._() : super();
  factory ProcessVoiceNoteResponse({
    $core.bool? success,
    $core.String? msg,
    $core.String? response,
    $core.String? transcribedText,
    $fixnum.Int64? processingTimeMs,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (response != null) {
      _result.response = response;
    }
    if (transcribedText != null) {
      _result.transcribedText = transcribedText;
    }
    if (processingTimeMs != null) {
      _result.processingTimeMs = processingTimeMs;
    }
    return _result;
  }
  factory ProcessVoiceNoteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessVoiceNoteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessVoiceNoteResponse clone() => ProcessVoiceNoteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessVoiceNoteResponse copyWith(void Function(ProcessVoiceNoteResponse) updates) => super.copyWith((message) => updates(message as ProcessVoiceNoteResponse)) as ProcessVoiceNoteResponse; // ignore: deprecated_member_use
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

