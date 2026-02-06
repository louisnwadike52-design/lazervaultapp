//
//  Generated code. Do not modify.
//  source: tx_file.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Request message for GetUserTxFileUrl
class GetUserTxFileUrlRequest extends $pb.GeneratedMessage {
  factory GetUserTxFileUrlRequest() => create();
  GetUserTxFileUrlRequest._() : super();
  factory GetUserTxFileUrlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserTxFileUrlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserTxFileUrlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserTxFileUrlRequest clone() => GetUserTxFileUrlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserTxFileUrlRequest copyWith(void Function(GetUserTxFileUrlRequest) updates) => super.copyWith((message) => updates(message as GetUserTxFileUrlRequest)) as GetUserTxFileUrlRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlRequest create() => GetUserTxFileUrlRequest._();
  GetUserTxFileUrlRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserTxFileUrlRequest> createRepeated() => $pb.PbList<GetUserTxFileUrlRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserTxFileUrlRequest>(create);
  static GetUserTxFileUrlRequest? _defaultInstance;
}

/// Response message for GetUserTxFileUrl
class GetUserTxFileUrlResponse extends $pb.GeneratedMessage {
  factory GetUserTxFileUrlResponse({
    $core.String? publicFileUrl,
  }) {
    final $result = create();
    if (publicFileUrl != null) {
      $result.publicFileUrl = publicFileUrl;
    }
    return $result;
  }
  GetUserTxFileUrlResponse._() : super();
  factory GetUserTxFileUrlResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserTxFileUrlResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserTxFileUrlResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'publicFileUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserTxFileUrlResponse clone() => GetUserTxFileUrlResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserTxFileUrlResponse copyWith(void Function(GetUserTxFileUrlResponse) updates) => super.copyWith((message) => updates(message as GetUserTxFileUrlResponse)) as GetUserTxFileUrlResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlResponse create() => GetUserTxFileUrlResponse._();
  GetUserTxFileUrlResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserTxFileUrlResponse> createRepeated() => $pb.PbList<GetUserTxFileUrlResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserTxFileUrlResponse>(create);
  static GetUserTxFileUrlResponse? _defaultInstance;

  /// The Public HTTPS URL to the transaction file.
  /// Requires the GCS object to be publicly readable.
  @$pb.TagNumber(1)
  $core.String get publicFileUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set publicFileUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPublicFileUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearPublicFileUrl() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
