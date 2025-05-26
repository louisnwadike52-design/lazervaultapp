//
//  Generated code. Do not modify.
//  source: voice_session.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class StartVoiceSessionRequest extends $pb.GeneratedMessage {
  factory StartVoiceSessionRequest() => create();
  StartVoiceSessionRequest._() : super();
  factory StartVoiceSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartVoiceSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StartVoiceSessionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
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
}

class StartVoiceSessionResponse extends $pb.GeneratedMessage {
  factory StartVoiceSessionResponse({
    $core.String? roomName,
    $core.String? livekitToken,
    $core.String? agentId,
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
    return $result;
  }
  StartVoiceSessionResponse._() : super();
  factory StartVoiceSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartVoiceSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StartVoiceSessionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomName')
    ..aOS(2, _omitFieldNames ? '' : 'livekitToken')
    ..aOS(3, _omitFieldNames ? '' : 'agentId')
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
  void clearRoomName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get livekitToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set livekitToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLivekitToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearLivekitToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get agentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set agentId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAgentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAgentId() => $_clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
