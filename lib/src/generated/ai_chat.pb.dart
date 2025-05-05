//
//  Generated code. Do not modify.
//  source: ai_chat.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Request message for the AI Chat endpoint
class ProcessChatRequest extends $pb.GeneratedMessage {
  factory ProcessChatRequest({
    $core.String? query,
  }) {
    final $result = create();
    if (query != null) {
      $result.query = query;
    }
    return $result;
  }
  ProcessChatRequest._() : super();
  factory ProcessChatRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessChatRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessChatRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessChatRequest clone() => ProcessChatRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessChatRequest copyWith(void Function(ProcessChatRequest) updates) => super.copyWith((message) => updates(message as ProcessChatRequest)) as ProcessChatRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessChatRequest create() => ProcessChatRequest._();
  ProcessChatRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessChatRequest> createRepeated() => $pb.PbList<ProcessChatRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessChatRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessChatRequest>(create);
  static ProcessChatRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);
}

/// Response message for the AI Chat endpoint
class ProcessChatResponse extends $pb.GeneratedMessage {
  factory ProcessChatResponse({
    $core.bool? success,
    $core.String? msg,
    $core.String? query,
    $core.String? response,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    if (query != null) {
      $result.query = query;
    }
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  ProcessChatResponse._() : super();
  factory ProcessChatResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessChatResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessChatResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOS(3, _omitFieldNames ? '' : 'query')
    ..aOS(4, _omitFieldNames ? '' : 'response')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessChatResponse clone() => ProcessChatResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessChatResponse copyWith(void Function(ProcessChatResponse) updates) => super.copyWith((message) => updates(message as ProcessChatResponse)) as ProcessChatResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessChatResponse create() => ProcessChatResponse._();
  ProcessChatResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessChatResponse> createRepeated() => $pb.PbList<ProcessChatResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessChatResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessChatResponse>(create);
  static ProcessChatResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get query => $_getSZ(2);
  @$pb.TagNumber(3)
  set query($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuery() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get response => $_getSZ(3);
  @$pb.TagNumber(4)
  set response($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasResponse() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponse() => $_clearField(4);
}

/// Request message for triggering chat history indexing for the authenticated user
class IndexChatHistoryRequest extends $pb.GeneratedMessage {
  factory IndexChatHistoryRequest() => create();
  IndexChatHistoryRequest._() : super();
  factory IndexChatHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IndexChatHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IndexChatHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IndexChatHistoryRequest clone() => IndexChatHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IndexChatHistoryRequest copyWith(void Function(IndexChatHistoryRequest) updates) => super.copyWith((message) => updates(message as IndexChatHistoryRequest)) as IndexChatHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IndexChatHistoryRequest create() => IndexChatHistoryRequest._();
  IndexChatHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<IndexChatHistoryRequest> createRepeated() => $pb.PbList<IndexChatHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static IndexChatHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IndexChatHistoryRequest>(create);
  static IndexChatHistoryRequest? _defaultInstance;
}

/// Response message for chat history indexing trigger
class IndexChatHistoryResponse extends $pb.GeneratedMessage {
  factory IndexChatHistoryResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  IndexChatHistoryResponse._() : super();
  factory IndexChatHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IndexChatHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IndexChatHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IndexChatHistoryResponse clone() => IndexChatHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IndexChatHistoryResponse copyWith(void Function(IndexChatHistoryResponse) updates) => super.copyWith((message) => updates(message as IndexChatHistoryResponse)) as IndexChatHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IndexChatHistoryResponse create() => IndexChatHistoryResponse._();
  IndexChatHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<IndexChatHistoryResponse> createRepeated() => $pb.PbList<IndexChatHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static IndexChatHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IndexChatHistoryResponse>(create);
  static IndexChatHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);
}

/// Request message for triggering transaction file indexing for the authenticated user
class IndexTransactionFileRequest extends $pb.GeneratedMessage {
  factory IndexTransactionFileRequest() => create();
  IndexTransactionFileRequest._() : super();
  factory IndexTransactionFileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IndexTransactionFileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IndexTransactionFileRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IndexTransactionFileRequest clone() => IndexTransactionFileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IndexTransactionFileRequest copyWith(void Function(IndexTransactionFileRequest) updates) => super.copyWith((message) => updates(message as IndexTransactionFileRequest)) as IndexTransactionFileRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IndexTransactionFileRequest create() => IndexTransactionFileRequest._();
  IndexTransactionFileRequest createEmptyInstance() => create();
  static $pb.PbList<IndexTransactionFileRequest> createRepeated() => $pb.PbList<IndexTransactionFileRequest>();
  @$core.pragma('dart2js:noInline')
  static IndexTransactionFileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IndexTransactionFileRequest>(create);
  static IndexTransactionFileRequest? _defaultInstance;
}

/// Response message for transaction file indexing trigger
class IndexTransactionFileResponse extends $pb.GeneratedMessage {
  factory IndexTransactionFileResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  IndexTransactionFileResponse._() : super();
  factory IndexTransactionFileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IndexTransactionFileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IndexTransactionFileResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IndexTransactionFileResponse clone() => IndexTransactionFileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IndexTransactionFileResponse copyWith(void Function(IndexTransactionFileResponse) updates) => super.copyWith((message) => updates(message as IndexTransactionFileResponse)) as IndexTransactionFileResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IndexTransactionFileResponse create() => IndexTransactionFileResponse._();
  IndexTransactionFileResponse createEmptyInstance() => create();
  static $pb.PbList<IndexTransactionFileResponse> createRepeated() => $pb.PbList<IndexTransactionFileResponse>();
  @$core.pragma('dart2js:noInline')
  static IndexTransactionFileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IndexTransactionFileResponse>(create);
  static IndexTransactionFileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);
}

/// Represents a single entry in the AI chat history
class AIChatHistoryEntry extends $pb.GeneratedMessage {
  factory AIChatHistoryEntry({
    $core.String? query,
    $core.String? response,
    $core.String? timestamp,
  }) {
    final $result = create();
    if (query != null) {
      $result.query = query;
    }
    if (response != null) {
      $result.response = response;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  AIChatHistoryEntry._() : super();
  factory AIChatHistoryEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AIChatHistoryEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AIChatHistoryEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(2, _omitFieldNames ? '' : 'response')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AIChatHistoryEntry clone() => AIChatHistoryEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AIChatHistoryEntry copyWith(void Function(AIChatHistoryEntry) updates) => super.copyWith((message) => updates(message as AIChatHistoryEntry)) as AIChatHistoryEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AIChatHistoryEntry create() => AIChatHistoryEntry._();
  AIChatHistoryEntry createEmptyInstance() => create();
  static $pb.PbList<AIChatHistoryEntry> createRepeated() => $pb.PbList<AIChatHistoryEntry>();
  @$core.pragma('dart2js:noInline')
  static AIChatHistoryEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AIChatHistoryEntry>(create);
  static AIChatHistoryEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get response => $_getSZ(1);
  @$pb.TagNumber(2)
  set response($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);
}

/// Request message for getting the user's AI chat history
class GetAIChatHistoryRequest extends $pb.GeneratedMessage {
  factory GetAIChatHistoryRequest() => create();
  GetAIChatHistoryRequest._() : super();
  factory GetAIChatHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAIChatHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAIChatHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAIChatHistoryRequest clone() => GetAIChatHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAIChatHistoryRequest copyWith(void Function(GetAIChatHistoryRequest) updates) => super.copyWith((message) => updates(message as GetAIChatHistoryRequest)) as GetAIChatHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAIChatHistoryRequest create() => GetAIChatHistoryRequest._();
  GetAIChatHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetAIChatHistoryRequest> createRepeated() => $pb.PbList<GetAIChatHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAIChatHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAIChatHistoryRequest>(create);
  static GetAIChatHistoryRequest? _defaultInstance;
}

/// Response message containing the user's AI chat history
class GetAIChatHistoryResponse extends $pb.GeneratedMessage {
  factory GetAIChatHistoryResponse({
    $core.Iterable<AIChatHistoryEntry>? history,
  }) {
    final $result = create();
    if (history != null) {
      $result.history.addAll(history);
    }
    return $result;
  }
  GetAIChatHistoryResponse._() : super();
  factory GetAIChatHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAIChatHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAIChatHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<AIChatHistoryEntry>(1, _omitFieldNames ? '' : 'history', $pb.PbFieldType.PM, subBuilder: AIChatHistoryEntry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAIChatHistoryResponse clone() => GetAIChatHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAIChatHistoryResponse copyWith(void Function(GetAIChatHistoryResponse) updates) => super.copyWith((message) => updates(message as GetAIChatHistoryResponse)) as GetAIChatHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAIChatHistoryResponse create() => GetAIChatHistoryResponse._();
  GetAIChatHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetAIChatHistoryResponse> createRepeated() => $pb.PbList<GetAIChatHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAIChatHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAIChatHistoryResponse>(create);
  static GetAIChatHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AIChatHistoryEntry> get history => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
