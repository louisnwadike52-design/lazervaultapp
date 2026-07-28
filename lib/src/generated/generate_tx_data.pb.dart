// This is a generated file - do not edit.
//
// Generated from generate_tx_data.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Request message - Requires the user ID
class GenerateUserTxDataFileRequest extends $pb.GeneratedMessage {
  factory GenerateUserTxDataFileRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GenerateUserTxDataFileRequest._();

  factory GenerateUserTxDataFileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateUserTxDataFileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateUserTxDataFileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateUserTxDataFileRequest clone() =>
      GenerateUserTxDataFileRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateUserTxDataFileRequest copyWith(
          void Function(GenerateUserTxDataFileRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateUserTxDataFileRequest))
          as GenerateUserTxDataFileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateUserTxDataFileRequest create() =>
      GenerateUserTxDataFileRequest._();
  @$core.override
  GenerateUserTxDataFileRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateUserTxDataFileRequest> createRepeated() =>
      $pb.PbList<GenerateUserTxDataFileRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateUserTxDataFileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateUserTxDataFileRequest>(create);
  static GenerateUserTxDataFileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
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
    final result = create();
    if (fileGcsUrl != null) result.fileGcsUrl = fileGcsUrl;
    return result;
  }

  GenerateUserTxDataFileResponse._();

  factory GenerateUserTxDataFileResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateUserTxDataFileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateUserTxDataFileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fileGcsUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateUserTxDataFileResponse clone() =>
      GenerateUserTxDataFileResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateUserTxDataFileResponse copyWith(
          void Function(GenerateUserTxDataFileResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateUserTxDataFileResponse))
          as GenerateUserTxDataFileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateUserTxDataFileResponse create() =>
      GenerateUserTxDataFileResponse._();
  @$core.override
  GenerateUserTxDataFileResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateUserTxDataFileResponse> createRepeated() =>
      $pb.PbList<GenerateUserTxDataFileResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateUserTxDataFileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateUserTxDataFileResponse>(create);
  static GenerateUserTxDataFileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fileGcsUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set fileGcsUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFileGcsUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileGcsUrl() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
