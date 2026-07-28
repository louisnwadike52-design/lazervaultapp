// This is a generated file - do not edit.
//
// Generated from tx_file.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Request message for GetUserTxFileUrl
class GetUserTxFileUrlRequest extends $pb.GeneratedMessage {
  factory GetUserTxFileUrlRequest() => create();

  GetUserTxFileUrlRequest._();

  factory GetUserTxFileUrlRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserTxFileUrlRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserTxFileUrlRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserTxFileUrlRequest clone() =>
      GetUserTxFileUrlRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserTxFileUrlRequest copyWith(
          void Function(GetUserTxFileUrlRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserTxFileUrlRequest))
          as GetUserTxFileUrlRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlRequest create() => GetUserTxFileUrlRequest._();
  @$core.override
  GetUserTxFileUrlRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserTxFileUrlRequest> createRepeated() =>
      $pb.PbList<GetUserTxFileUrlRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserTxFileUrlRequest>(create);
  static GetUserTxFileUrlRequest? _defaultInstance;
}

/// Response message for GetUserTxFileUrl
class GetUserTxFileUrlResponse extends $pb.GeneratedMessage {
  factory GetUserTxFileUrlResponse({
    $core.String? publicFileUrl,
  }) {
    final result = create();
    if (publicFileUrl != null) result.publicFileUrl = publicFileUrl;
    return result;
  }

  GetUserTxFileUrlResponse._();

  factory GetUserTxFileUrlResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserTxFileUrlResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserTxFileUrlResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'publicFileUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserTxFileUrlResponse clone() =>
      GetUserTxFileUrlResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserTxFileUrlResponse copyWith(
          void Function(GetUserTxFileUrlResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserTxFileUrlResponse))
          as GetUserTxFileUrlResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlResponse create() => GetUserTxFileUrlResponse._();
  @$core.override
  GetUserTxFileUrlResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserTxFileUrlResponse> createRepeated() =>
      $pb.PbList<GetUserTxFileUrlResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserTxFileUrlResponse>(create);
  static GetUserTxFileUrlResponse? _defaultInstance;

  /// The Public HTTPS URL to the transaction file.
  /// Requires the GCS object to be publicly readable.
  @$pb.TagNumber(1)
  $core.String get publicFileUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set publicFileUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPublicFileUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearPublicFileUrl() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
