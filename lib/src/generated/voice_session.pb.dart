///
//  Generated code. Do not modify.
//  source: voice_session.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class StartVoiceSessionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartVoiceSessionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  StartVoiceSessionRequest._() : super();
  factory StartVoiceSessionRequest() => create();
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
}

class StartVoiceSessionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartVoiceSessionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roomName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'livekitToken')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'agentId')
    ..hasRequiredFields = false
  ;

  StartVoiceSessionResponse._() : super();
  factory StartVoiceSessionResponse({
    $core.String? roomName,
    $core.String? livekitToken,
    $core.String? agentId,
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
}

