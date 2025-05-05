//
//  Generated code. Do not modify.
//  source: generate_tx_data.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Request message - Requires the user ID
class GenerateUserTxDataFileRequest extends $pb.GeneratedMessage {
  factory GenerateUserTxDataFileRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GenerateUserTxDataFileRequest._() : super();
  factory GenerateUserTxDataFileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateUserTxDataFileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateUserTxDataFileRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateUserTxDataFileRequest clone() => GenerateUserTxDataFileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateUserTxDataFileRequest copyWith(void Function(GenerateUserTxDataFileRequest) updates) => super.copyWith((message) => updates(message as GenerateUserTxDataFileRequest)) as GenerateUserTxDataFileRequest;

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
  void clearUserId() => $_clearField(1);
}

/// Response message - Returns the GCS URL of the generated file
class GenerateUserTxDataFileResponse extends $pb.GeneratedMessage {
  factory GenerateUserTxDataFileResponse({
    $core.String? fileGcsUrl,
  }) {
    final $result = create();
    if (fileGcsUrl != null) {
      $result.fileGcsUrl = fileGcsUrl;
    }
    return $result;
  }
  GenerateUserTxDataFileResponse._() : super();
  factory GenerateUserTxDataFileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateUserTxDataFileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateUserTxDataFileResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fileGcsUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateUserTxDataFileResponse clone() => GenerateUserTxDataFileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateUserTxDataFileResponse copyWith(void Function(GenerateUserTxDataFileResponse) updates) => super.copyWith((message) => updates(message as GenerateUserTxDataFileResponse)) as GenerateUserTxDataFileResponse;

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
  void clearFileGcsUrl() => $_clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
