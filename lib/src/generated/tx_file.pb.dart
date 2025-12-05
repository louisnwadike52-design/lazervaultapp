///
//  Generated code. Do not modify.
//  source: tx_file.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GetUserTxFileUrlRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserTxFileUrlRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetUserTxFileUrlRequest._() : super();
  factory GetUserTxFileUrlRequest() => create();
  factory GetUserTxFileUrlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserTxFileUrlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserTxFileUrlRequest clone() => GetUserTxFileUrlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserTxFileUrlRequest copyWith(void Function(GetUserTxFileUrlRequest) updates) => super.copyWith((message) => updates(message as GetUserTxFileUrlRequest)) as GetUserTxFileUrlRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlRequest create() => GetUserTxFileUrlRequest._();
  GetUserTxFileUrlRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserTxFileUrlRequest> createRepeated() => $pb.PbList<GetUserTxFileUrlRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserTxFileUrlRequest>(create);
  static GetUserTxFileUrlRequest? _defaultInstance;
}

class GetUserTxFileUrlResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserTxFileUrlResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publicFileUrl')
    ..hasRequiredFields = false
  ;

  GetUserTxFileUrlResponse._() : super();
  factory GetUserTxFileUrlResponse({
    $core.String? publicFileUrl,
  }) {
    final _result = create();
    if (publicFileUrl != null) {
      _result.publicFileUrl = publicFileUrl;
    }
    return _result;
  }
  factory GetUserTxFileUrlResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserTxFileUrlResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserTxFileUrlResponse clone() => GetUserTxFileUrlResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserTxFileUrlResponse copyWith(void Function(GetUserTxFileUrlResponse) updates) => super.copyWith((message) => updates(message as GetUserTxFileUrlResponse)) as GetUserTxFileUrlResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlResponse create() => GetUserTxFileUrlResponse._();
  GetUserTxFileUrlResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserTxFileUrlResponse> createRepeated() => $pb.PbList<GetUserTxFileUrlResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserTxFileUrlResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserTxFileUrlResponse>(create);
  static GetUserTxFileUrlResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get publicFileUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set publicFileUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPublicFileUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearPublicFileUrl() => clearField(1);
}

