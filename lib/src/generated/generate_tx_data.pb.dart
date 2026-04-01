///
//  Generated code. Do not modify.
//  source: generate_tx_data.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GenerateUserTxDataFileRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateUserTxDataFileRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GenerateUserTxDataFileRequest._() : super();
  factory GenerateUserTxDataFileRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GenerateUserTxDataFileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateUserTxDataFileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateUserTxDataFileRequest clone() => GenerateUserTxDataFileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateUserTxDataFileRequest copyWith(void Function(GenerateUserTxDataFileRequest) updates) => super.copyWith((message) => updates(message as GenerateUserTxDataFileRequest)) as GenerateUserTxDataFileRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateUserTxDataFileRequest create() => GenerateUserTxDataFileRequest._();
  GenerateUserTxDataFileRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateUserTxDataFileRequest> createRepeated() => $pb.PbList<GenerateUserTxDataFileRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateUserTxDataFileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateUserTxDataFileRequest>(create);
  static GenerateUserTxDataFileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GenerateUserTxDataFileResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateUserTxDataFileResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileGcsUrl')
    ..hasRequiredFields = false
  ;

  GenerateUserTxDataFileResponse._() : super();
  factory GenerateUserTxDataFileResponse({
    $core.String? fileGcsUrl,
  }) {
    final _result = create();
    if (fileGcsUrl != null) {
      _result.fileGcsUrl = fileGcsUrl;
    }
    return _result;
  }
  factory GenerateUserTxDataFileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateUserTxDataFileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateUserTxDataFileResponse clone() => GenerateUserTxDataFileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateUserTxDataFileResponse copyWith(void Function(GenerateUserTxDataFileResponse) updates) => super.copyWith((message) => updates(message as GenerateUserTxDataFileResponse)) as GenerateUserTxDataFileResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateUserTxDataFileResponse create() => GenerateUserTxDataFileResponse._();
  GenerateUserTxDataFileResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateUserTxDataFileResponse> createRepeated() => $pb.PbList<GenerateUserTxDataFileResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateUserTxDataFileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateUserTxDataFileResponse>(create);
  static GenerateUserTxDataFileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fileGcsUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set fileGcsUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFileGcsUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileGcsUrl() => clearField(1);
}

