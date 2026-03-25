// This is a generated file - do not edit.
//
// Generated from voice_session.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class StartVoiceSessionRequest extends $pb.GeneratedMessage {
  factory StartVoiceSessionRequest({
    $core.String? serviceName,
    $core.String? language,
    $core.String? voicePreference,
  }) {
    final result = create();
    if (serviceName != null) result.serviceName = serviceName;
    if (language != null) result.language = language;
    if (voicePreference != null) result.voicePreference = voicePreference;
    return result;
  }

  StartVoiceSessionRequest._();

  factory StartVoiceSessionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StartVoiceSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartVoiceSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOS(2, _omitFieldNames ? '' : 'language')
    ..aOS(3, _omitFieldNames ? '' : 'voicePreference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StartVoiceSessionRequest clone() =>
      StartVoiceSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StartVoiceSessionRequest copyWith(
          void Function(StartVoiceSessionRequest) updates) =>
      super.copyWith((message) => updates(message as StartVoiceSessionRequest))
          as StartVoiceSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartVoiceSessionRequest create() => StartVoiceSessionRequest._();
  @$core.override
  StartVoiceSessionRequest createEmptyInstance() => create();
  static $pb.PbList<StartVoiceSessionRequest> createRepeated() =>
      $pb.PbList<StartVoiceSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static StartVoiceSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartVoiceSessionRequest>(create);
  static StartVoiceSessionRequest? _defaultInstance;

  /// Service name for routing to specific voice agent (e.g., "stocks", "transfers", "crypto")
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => $_clearField(1);

  /// User's preferred language code (e.g., "en", "fr", "yo")
  @$pb.TagNumber(2)
  $core.String get language => $_getSZ(1);
  @$pb.TagNumber(2)
  set language($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLanguage() => $_has(1);
  @$pb.TagNumber(2)
  void clearLanguage() => $_clearField(2);

  /// User's preferred TTS voice ID
  @$pb.TagNumber(3)
  $core.String get voicePreference => $_getSZ(2);
  @$pb.TagNumber(3)
  set voicePreference($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVoicePreference() => $_has(2);
  @$pb.TagNumber(3)
  void clearVoicePreference() => $_clearField(3);
}

class StartVoiceSessionResponse extends $pb.GeneratedMessage {
  factory StartVoiceSessionResponse({
    $core.String? roomName,
    $core.String? livekitToken,
    $core.String? agentId,
    $core.String? agentUrl,
    $core.int? agentPort,
  }) {
    final result = create();
    if (roomName != null) result.roomName = roomName;
    if (livekitToken != null) result.livekitToken = livekitToken;
    if (agentId != null) result.agentId = agentId;
    if (agentUrl != null) result.agentUrl = agentUrl;
    if (agentPort != null) result.agentPort = agentPort;
    return result;
  }

  StartVoiceSessionResponse._();

  factory StartVoiceSessionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StartVoiceSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartVoiceSessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomName')
    ..aOS(2, _omitFieldNames ? '' : 'livekitToken')
    ..aOS(3, _omitFieldNames ? '' : 'agentId')
    ..aOS(4, _omitFieldNames ? '' : 'agentUrl')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'agentPort', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StartVoiceSessionResponse clone() =>
      StartVoiceSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StartVoiceSessionResponse copyWith(
          void Function(StartVoiceSessionResponse) updates) =>
      super.copyWith((message) => updates(message as StartVoiceSessionResponse))
          as StartVoiceSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartVoiceSessionResponse create() => StartVoiceSessionResponse._();
  @$core.override
  StartVoiceSessionResponse createEmptyInstance() => create();
  static $pb.PbList<StartVoiceSessionResponse> createRepeated() =>
      $pb.PbList<StartVoiceSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static StartVoiceSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartVoiceSessionResponse>(create);
  static StartVoiceSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomName => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomName() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get livekitToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set livekitToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLivekitToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearLivekitToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get agentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set agentId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAgentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAgentId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get agentUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set agentUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAgentUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearAgentUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get agentPort => $_getIZ(4);
  @$pb.TagNumber(5)
  set agentPort($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAgentPort() => $_has(4);
  @$pb.TagNumber(5)
  void clearAgentPort() => $_clearField(5);
}

/// Voice note processing request - accepts multipart form data file upload
class ProcessVoiceNoteRequest extends $pb.GeneratedMessage {
  factory ProcessVoiceNoteRequest({
    $core.String? txHistory,
  }) {
    final result = create();
    if (txHistory != null) result.txHistory = txHistory;
    return result;
  }

  ProcessVoiceNoteRequest._();

  factory ProcessVoiceNoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessVoiceNoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessVoiceNoteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'txHistory')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessVoiceNoteRequest clone() =>
      ProcessVoiceNoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessVoiceNoteRequest copyWith(
          void Function(ProcessVoiceNoteRequest) updates) =>
      super.copyWith((message) => updates(message as ProcessVoiceNoteRequest))
          as ProcessVoiceNoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessVoiceNoteRequest create() => ProcessVoiceNoteRequest._();
  @$core.override
  ProcessVoiceNoteRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessVoiceNoteRequest> createRepeated() =>
      $pb.PbList<ProcessVoiceNoteRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessVoiceNoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessVoiceNoteRequest>(create);
  static ProcessVoiceNoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get txHistory => $_getSZ(0);
  @$pb.TagNumber(1)
  set txHistory($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTxHistory() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxHistory() => $_clearField(1);
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
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (response != null) result.response = response;
    if (transcribedText != null) result.transcribedText = transcribedText;
    if (processingTimeMs != null) result.processingTimeMs = processingTimeMs;
    return result;
  }

  ProcessVoiceNoteResponse._();

  factory ProcessVoiceNoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessVoiceNoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessVoiceNoteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOS(3, _omitFieldNames ? '' : 'response')
    ..aOS(4, _omitFieldNames ? '' : 'transcribedText')
    ..aInt64(5, _omitFieldNames ? '' : 'processingTimeMs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessVoiceNoteResponse clone() =>
      ProcessVoiceNoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessVoiceNoteResponse copyWith(
          void Function(ProcessVoiceNoteResponse) updates) =>
      super.copyWith((message) => updates(message as ProcessVoiceNoteResponse))
          as ProcessVoiceNoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessVoiceNoteResponse create() => ProcessVoiceNoteResponse._();
  @$core.override
  ProcessVoiceNoteResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessVoiceNoteResponse> createRepeated() =>
      $pb.PbList<ProcessVoiceNoteResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessVoiceNoteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessVoiceNoteResponse>(create);
  static ProcessVoiceNoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get response => $_getSZ(2);
  @$pb.TagNumber(3)
  set response($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasResponse() => $_has(2);
  @$pb.TagNumber(3)
  void clearResponse() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transcribedText => $_getSZ(3);
  @$pb.TagNumber(4)
  set transcribedText($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTranscribedText() => $_has(3);
  @$pb.TagNumber(4)
  void clearTranscribedText() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get processingTimeMs => $_getI64(4);
  @$pb.TagNumber(5)
  set processingTimeMs($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProcessingTimeMs() => $_has(4);
  @$pb.TagNumber(5)
  void clearProcessingTimeMs() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
