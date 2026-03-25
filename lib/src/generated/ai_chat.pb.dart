// This is a generated file - do not edit.
//
// Generated from ai_chat.proto.

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

/// Request message for the AI Chat endpoint
class ProcessChatRequest extends $pb.GeneratedMessage {
  factory ProcessChatRequest({
    $core.String? query,
    $core.String? txHistory,
    $core.int? userId,
    ChatFile? uploadedFile,
    $core.String? sessionId,
    $core.String? sourceContext,
    $core.String? language,
    $core.String? accountId,
    $core.String? userCountry,
    $core.String? currency,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (txHistory != null) result.txHistory = txHistory;
    if (userId != null) result.userId = userId;
    if (uploadedFile != null) result.uploadedFile = uploadedFile;
    if (sessionId != null) result.sessionId = sessionId;
    if (sourceContext != null) result.sourceContext = sourceContext;
    if (language != null) result.language = language;
    if (accountId != null) result.accountId = accountId;
    if (userCountry != null) result.userCountry = userCountry;
    if (currency != null) result.currency = currency;
    return result;
  }

  ProcessChatRequest._();

  factory ProcessChatRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessChatRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessChatRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(2, _omitFieldNames ? '' : 'txHistory')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU3)
    ..aOM<ChatFile>(4, _omitFieldNames ? '' : 'uploadedFile',
        subBuilder: ChatFile.create)
    ..aOS(5, _omitFieldNames ? '' : 'sessionId')
    ..aOS(6, _omitFieldNames ? '' : 'sourceContext')
    ..aOS(7, _omitFieldNames ? '' : 'language')
    ..aOS(8, _omitFieldNames ? '' : 'accountId')
    ..aOS(9, _omitFieldNames ? '' : 'userCountry')
    ..aOS(10, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessChatRequest clone() => ProcessChatRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessChatRequest copyWith(void Function(ProcessChatRequest) updates) =>
      super.copyWith((message) => updates(message as ProcessChatRequest))
          as ProcessChatRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessChatRequest create() => ProcessChatRequest._();
  @$core.override
  ProcessChatRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessChatRequest> createRepeated() =>
      $pb.PbList<ProcessChatRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessChatRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessChatRequest>(create);
  static ProcessChatRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get txHistory => $_getSZ(1);
  @$pb.TagNumber(2)
  set txHistory($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTxHistory() => $_has(1);
  @$pb.TagNumber(2)
  void clearTxHistory() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get userId => $_getIZ(2);
  @$pb.TagNumber(3)
  set userId($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  /// Optional file handling field
  @$pb.TagNumber(4)
  ChatFile get uploadedFile => $_getN(3);
  @$pb.TagNumber(4)
  set uploadedFile(ChatFile value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasUploadedFile() => $_has(3);
  @$pb.TagNumber(4)
  void clearUploadedFile() => $_clearField(4);
  @$pb.TagNumber(4)
  ChatFile ensureUploadedFile() => $_ensure(3);

  /// Conversation context fields
  @$pb.TagNumber(5)
  $core.String get sessionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set sessionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSessionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSessionId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get sourceContext => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceContext($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSourceContext() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceContext() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get language => $_getSZ(6);
  @$pb.TagNumber(7)
  set language($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLanguage() => $_has(6);
  @$pb.TagNumber(7)
  void clearLanguage() => $_clearField(7);

  /// Account context fields for agent routing
  @$pb.TagNumber(8)
  $core.String get accountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set accountId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearAccountId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get userCountry => $_getSZ(8);
  @$pb.TagNumber(9)
  set userCountry($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUserCountry() => $_has(8);
  @$pb.TagNumber(9)
  void clearUserCountry() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(9);
  @$pb.TagNumber(10)
  set currency($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrency() => $_clearField(10);
}

/// Response message for the AI Chat endpoint
class ProcessChatResponse extends $pb.GeneratedMessage {
  factory ProcessChatResponse({
    $core.bool? success,
    $core.String? msg,
    $core.String? query,
    $core.String? response,
    $core.Iterable<ChatFile>? generatedFiles,
    FileAnalysis? fileAnalysis,
    $core.String? intent,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? entities,
    $core.bool? requiresConfirmation,
    $core.Iterable<ActionButton>? actionButtons,
    $core.String? sessionId,
    ConfirmationData? confirmationData,
    $core.String? conversationState,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (query != null) result.query = query;
    if (response != null) result.response = response;
    if (generatedFiles != null) result.generatedFiles.addAll(generatedFiles);
    if (fileAnalysis != null) result.fileAnalysis = fileAnalysis;
    if (intent != null) result.intent = intent;
    if (entities != null) result.entities.addEntries(entities);
    if (requiresConfirmation != null)
      result.requiresConfirmation = requiresConfirmation;
    if (actionButtons != null) result.actionButtons.addAll(actionButtons);
    if (sessionId != null) result.sessionId = sessionId;
    if (confirmationData != null) result.confirmationData = confirmationData;
    if (conversationState != null) result.conversationState = conversationState;
    return result;
  }

  ProcessChatResponse._();

  factory ProcessChatResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessChatResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessChatResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOS(3, _omitFieldNames ? '' : 'query')
    ..aOS(4, _omitFieldNames ? '' : 'response')
    ..pc<ChatFile>(
        5, _omitFieldNames ? '' : 'generatedFiles', $pb.PbFieldType.PM,
        subBuilder: ChatFile.create)
    ..aOM<FileAnalysis>(6, _omitFieldNames ? '' : 'fileAnalysis',
        subBuilder: FileAnalysis.create)
    ..aOS(7, _omitFieldNames ? '' : 'intent')
    ..m<$core.String, $core.String>(8, _omitFieldNames ? '' : 'entities',
        entryClassName: 'ProcessChatResponse.EntitiesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..aOB(9, _omitFieldNames ? '' : 'requiresConfirmation')
    ..pc<ActionButton>(
        10, _omitFieldNames ? '' : 'actionButtons', $pb.PbFieldType.PM,
        subBuilder: ActionButton.create)
    ..aOS(11, _omitFieldNames ? '' : 'sessionId')
    ..aOM<ConfirmationData>(12, _omitFieldNames ? '' : 'confirmationData',
        subBuilder: ConfirmationData.create)
    ..aOS(13, _omitFieldNames ? '' : 'conversationState')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessChatResponse clone() => ProcessChatResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessChatResponse copyWith(void Function(ProcessChatResponse) updates) =>
      super.copyWith((message) => updates(message as ProcessChatResponse))
          as ProcessChatResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessChatResponse create() => ProcessChatResponse._();
  @$core.override
  ProcessChatResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessChatResponse> createRepeated() =>
      $pb.PbList<ProcessChatResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessChatResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessChatResponse>(create);
  static ProcessChatResponse? _defaultInstance;

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
  $core.String get query => $_getSZ(2);
  @$pb.TagNumber(3)
  set query($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuery() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get response => $_getSZ(3);
  @$pb.TagNumber(4)
  set response($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasResponse() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponse() => $_clearField(4);

  /// Optional file handling response fields
  @$pb.TagNumber(5)
  $pb.PbList<ChatFile> get generatedFiles => $_getList(4);

  @$pb.TagNumber(6)
  FileAnalysis get fileAnalysis => $_getN(5);
  @$pb.TagNumber(6)
  set fileAnalysis(FileAnalysis value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasFileAnalysis() => $_has(5);
  @$pb.TagNumber(6)
  void clearFileAnalysis() => $_clearField(6);
  @$pb.TagNumber(6)
  FileAnalysis ensureFileAnalysis() => $_ensure(5);

  /// Conversation intelligence fields
  @$pb.TagNumber(7)
  $core.String get intent => $_getSZ(6);
  @$pb.TagNumber(7)
  set intent($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIntent() => $_has(6);
  @$pb.TagNumber(7)
  void clearIntent() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbMap<$core.String, $core.String> get entities => $_getMap(7);

  @$pb.TagNumber(9)
  $core.bool get requiresConfirmation => $_getBF(8);
  @$pb.TagNumber(9)
  set requiresConfirmation($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRequiresConfirmation() => $_has(8);
  @$pb.TagNumber(9)
  void clearRequiresConfirmation() => $_clearField(9);

  @$pb.TagNumber(10)
  $pb.PbList<ActionButton> get actionButtons => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get sessionId => $_getSZ(10);
  @$pb.TagNumber(11)
  set sessionId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSessionId() => $_has(10);
  @$pb.TagNumber(11)
  void clearSessionId() => $_clearField(11);

  @$pb.TagNumber(12)
  ConfirmationData get confirmationData => $_getN(11);
  @$pb.TagNumber(12)
  set confirmationData(ConfirmationData value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasConfirmationData() => $_has(11);
  @$pb.TagNumber(12)
  void clearConfirmationData() => $_clearField(12);
  @$pb.TagNumber(12)
  ConfirmationData ensureConfirmationData() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get conversationState => $_getSZ(12);
  @$pb.TagNumber(13)
  set conversationState($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasConversationState() => $_has(12);
  @$pb.TagNumber(13)
  void clearConversationState() => $_clearField(13);
}

/// Represents a file in chat context
class ChatFile extends $pb.GeneratedMessage {
  factory ChatFile({
    $core.String? filename,
    $core.String? contentType,
    $core.List<$core.int>? fileContent,
    $core.String? fileId,
    $core.String? fileUrl,
    $fixnum.Int64? fileSize,
    $core.String? uploadTimestamp,
  }) {
    final result = create();
    if (filename != null) result.filename = filename;
    if (contentType != null) result.contentType = contentType;
    if (fileContent != null) result.fileContent = fileContent;
    if (fileId != null) result.fileId = fileId;
    if (fileUrl != null) result.fileUrl = fileUrl;
    if (fileSize != null) result.fileSize = fileSize;
    if (uploadTimestamp != null) result.uploadTimestamp = uploadTimestamp;
    return result;
  }

  ChatFile._();

  factory ChatFile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatFile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatFile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'filename')
    ..aOS(2, _omitFieldNames ? '' : 'contentType')
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'fileContent', $pb.PbFieldType.OY)
    ..aOS(4, _omitFieldNames ? '' : 'fileId')
    ..aOS(5, _omitFieldNames ? '' : 'fileUrl')
    ..aInt64(6, _omitFieldNames ? '' : 'fileSize')
    ..aOS(7, _omitFieldNames ? '' : 'uploadTimestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatFile clone() => ChatFile()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatFile copyWith(void Function(ChatFile) updates) =>
      super.copyWith((message) => updates(message as ChatFile)) as ChatFile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatFile create() => ChatFile._();
  @$core.override
  ChatFile createEmptyInstance() => create();
  static $pb.PbList<ChatFile> createRepeated() => $pb.PbList<ChatFile>();
  @$core.pragma('dart2js:noInline')
  static ChatFile getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatFile>(create);
  static ChatFile? _defaultInstance;

  /// For uploads - client provides these fields
  @$pb.TagNumber(1)
  $core.String get filename => $_getSZ(0);
  @$pb.TagNumber(1)
  set filename($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFilename() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilename() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get contentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set contentType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearContentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get fileContent => $_getN(2);
  @$pb.TagNumber(3)
  set fileContent($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFileContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileContent() => $_clearField(3);

  /// For responses - server provides these fields
  @$pb.TagNumber(4)
  $core.String get fileId => $_getSZ(3);
  @$pb.TagNumber(4)
  set fileId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFileId() => $_has(3);
  @$pb.TagNumber(4)
  void clearFileId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get fileUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set fileUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFileUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearFileUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get fileSize => $_getI64(5);
  @$pb.TagNumber(6)
  set fileSize($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFileSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearFileSize() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get uploadTimestamp => $_getSZ(6);
  @$pb.TagNumber(7)
  set uploadTimestamp($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUploadTimestamp() => $_has(6);
  @$pb.TagNumber(7)
  void clearUploadTimestamp() => $_clearField(7);
}

/// File analysis results from AI
class FileAnalysis extends $pb.GeneratedMessage {
  factory FileAnalysis({
    $core.Iterable<FileAnalysisResult>? results,
    $core.String? summary,
  }) {
    final result = create();
    if (results != null) result.results.addAll(results);
    if (summary != null) result.summary = summary;
    return result;
  }

  FileAnalysis._();

  factory FileAnalysis.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FileAnalysis.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileAnalysis',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<FileAnalysisResult>(
        1, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM,
        subBuilder: FileAnalysisResult.create)
    ..aOS(2, _omitFieldNames ? '' : 'summary')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileAnalysis clone() => FileAnalysis()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileAnalysis copyWith(void Function(FileAnalysis) updates) =>
      super.copyWith((message) => updates(message as FileAnalysis))
          as FileAnalysis;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileAnalysis create() => FileAnalysis._();
  @$core.override
  FileAnalysis createEmptyInstance() => create();
  static $pb.PbList<FileAnalysis> createRepeated() =>
      $pb.PbList<FileAnalysis>();
  @$core.pragma('dart2js:noInline')
  static FileAnalysis getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileAnalysis>(create);
  static FileAnalysis? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FileAnalysisResult> get results => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get summary => $_getSZ(1);
  @$pb.TagNumber(2)
  set summary($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSummary() => $_has(1);
  @$pb.TagNumber(2)
  void clearSummary() => $_clearField(2);
}

/// Individual file analysis result
class FileAnalysisResult extends $pb.GeneratedMessage {
  factory FileAnalysisResult({
    $core.String? fileId,
    $core.String? filename,
    $core.String? analysisType,
    $core.String? analysisResult,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
    $core.bool? processingSuccess,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (fileId != null) result.fileId = fileId;
    if (filename != null) result.filename = filename;
    if (analysisType != null) result.analysisType = analysisType;
    if (analysisResult != null) result.analysisResult = analysisResult;
    if (metadata != null) result.metadata.addEntries(metadata);
    if (processingSuccess != null) result.processingSuccess = processingSuccess;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  FileAnalysisResult._();

  factory FileAnalysisResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FileAnalysisResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileAnalysisResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fileId')
    ..aOS(2, _omitFieldNames ? '' : 'filename')
    ..aOS(3, _omitFieldNames ? '' : 'analysisType')
    ..aOS(4, _omitFieldNames ? '' : 'analysisResult')
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'FileAnalysisResult.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..aOB(6, _omitFieldNames ? '' : 'processingSuccess')
    ..aOS(7, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileAnalysisResult clone() => FileAnalysisResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileAnalysisResult copyWith(void Function(FileAnalysisResult) updates) =>
      super.copyWith((message) => updates(message as FileAnalysisResult))
          as FileAnalysisResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileAnalysisResult create() => FileAnalysisResult._();
  @$core.override
  FileAnalysisResult createEmptyInstance() => create();
  static $pb.PbList<FileAnalysisResult> createRepeated() =>
      $pb.PbList<FileAnalysisResult>();
  @$core.pragma('dart2js:noInline')
  static FileAnalysisResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileAnalysisResult>(create);
  static FileAnalysisResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fileId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fileId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFileId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get filename => $_getSZ(1);
  @$pb.TagNumber(2)
  set filename($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFilename() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilename() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get analysisType => $_getSZ(2);
  @$pb.TagNumber(3)
  set analysisType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAnalysisType() => $_has(2);
  @$pb.TagNumber(3)
  void clearAnalysisType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get analysisResult => $_getSZ(3);
  @$pb.TagNumber(4)
  set analysisResult($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAnalysisResult() => $_has(3);
  @$pb.TagNumber(4)
  void clearAnalysisResult() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(4);

  @$pb.TagNumber(6)
  $core.bool get processingSuccess => $_getBF(5);
  @$pb.TagNumber(6)
  set processingSuccess($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProcessingSuccess() => $_has(5);
  @$pb.TagNumber(6)
  void clearProcessingSuccess() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get errorMessage => $_getSZ(6);
  @$pb.TagNumber(7)
  set errorMessage($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasErrorMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearErrorMessage() => $_clearField(7);
}

/// Request message for triggering chat history indexing for the authenticated user
class IndexChatHistoryRequest extends $pb.GeneratedMessage {
  factory IndexChatHistoryRequest() => create();

  IndexChatHistoryRequest._();

  factory IndexChatHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IndexChatHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IndexChatHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IndexChatHistoryRequest clone() =>
      IndexChatHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IndexChatHistoryRequest copyWith(
          void Function(IndexChatHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as IndexChatHistoryRequest))
          as IndexChatHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IndexChatHistoryRequest create() => IndexChatHistoryRequest._();
  @$core.override
  IndexChatHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<IndexChatHistoryRequest> createRepeated() =>
      $pb.PbList<IndexChatHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static IndexChatHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IndexChatHistoryRequest>(create);
  static IndexChatHistoryRequest? _defaultInstance;
}

/// Response message for chat history indexing trigger
class IndexChatHistoryResponse extends $pb.GeneratedMessage {
  factory IndexChatHistoryResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  IndexChatHistoryResponse._();

  factory IndexChatHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IndexChatHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IndexChatHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IndexChatHistoryResponse clone() =>
      IndexChatHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IndexChatHistoryResponse copyWith(
          void Function(IndexChatHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as IndexChatHistoryResponse))
          as IndexChatHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IndexChatHistoryResponse create() => IndexChatHistoryResponse._();
  @$core.override
  IndexChatHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<IndexChatHistoryResponse> createRepeated() =>
      $pb.PbList<IndexChatHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static IndexChatHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IndexChatHistoryResponse>(create);
  static IndexChatHistoryResponse? _defaultInstance;

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
}

/// Request message for triggering transaction file indexing for the authenticated user
class IndexTransactionFileRequest extends $pb.GeneratedMessage {
  factory IndexTransactionFileRequest() => create();

  IndexTransactionFileRequest._();

  factory IndexTransactionFileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IndexTransactionFileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IndexTransactionFileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IndexTransactionFileRequest clone() =>
      IndexTransactionFileRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IndexTransactionFileRequest copyWith(
          void Function(IndexTransactionFileRequest) updates) =>
      super.copyWith(
              (message) => updates(message as IndexTransactionFileRequest))
          as IndexTransactionFileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IndexTransactionFileRequest create() =>
      IndexTransactionFileRequest._();
  @$core.override
  IndexTransactionFileRequest createEmptyInstance() => create();
  static $pb.PbList<IndexTransactionFileRequest> createRepeated() =>
      $pb.PbList<IndexTransactionFileRequest>();
  @$core.pragma('dart2js:noInline')
  static IndexTransactionFileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IndexTransactionFileRequest>(create);
  static IndexTransactionFileRequest? _defaultInstance;
}

/// Response message for transaction file indexing trigger
class IndexTransactionFileResponse extends $pb.GeneratedMessage {
  factory IndexTransactionFileResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  IndexTransactionFileResponse._();

  factory IndexTransactionFileResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IndexTransactionFileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IndexTransactionFileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IndexTransactionFileResponse clone() =>
      IndexTransactionFileResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IndexTransactionFileResponse copyWith(
          void Function(IndexTransactionFileResponse) updates) =>
      super.copyWith(
              (message) => updates(message as IndexTransactionFileResponse))
          as IndexTransactionFileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IndexTransactionFileResponse create() =>
      IndexTransactionFileResponse._();
  @$core.override
  IndexTransactionFileResponse createEmptyInstance() => create();
  static $pb.PbList<IndexTransactionFileResponse> createRepeated() =>
      $pb.PbList<IndexTransactionFileResponse>();
  @$core.pragma('dart2js:noInline')
  static IndexTransactionFileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IndexTransactionFileResponse>(create);
  static IndexTransactionFileResponse? _defaultInstance;

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
}

/// Represents a single entry in the AI chat history
class AIChatHistoryEntry extends $pb.GeneratedMessage {
  factory AIChatHistoryEntry({
    $core.String? query,
    $core.String? response,
    $core.String? timestamp,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (response != null) result.response = response;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  AIChatHistoryEntry._();

  factory AIChatHistoryEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AIChatHistoryEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AIChatHistoryEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(2, _omitFieldNames ? '' : 'response')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AIChatHistoryEntry clone() => AIChatHistoryEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AIChatHistoryEntry copyWith(void Function(AIChatHistoryEntry) updates) =>
      super.copyWith((message) => updates(message as AIChatHistoryEntry))
          as AIChatHistoryEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AIChatHistoryEntry create() => AIChatHistoryEntry._();
  @$core.override
  AIChatHistoryEntry createEmptyInstance() => create();
  static $pb.PbList<AIChatHistoryEntry> createRepeated() =>
      $pb.PbList<AIChatHistoryEntry>();
  @$core.pragma('dart2js:noInline')
  static AIChatHistoryEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AIChatHistoryEntry>(create);
  static AIChatHistoryEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get response => $_getSZ(1);
  @$pb.TagNumber(2)
  set response($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);
}

/// Request message for getting the user's AI chat history
class GetAIChatHistoryRequest extends $pb.GeneratedMessage {
  factory GetAIChatHistoryRequest() => create();

  GetAIChatHistoryRequest._();

  factory GetAIChatHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAIChatHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAIChatHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIChatHistoryRequest clone() =>
      GetAIChatHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIChatHistoryRequest copyWith(
          void Function(GetAIChatHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetAIChatHistoryRequest))
          as GetAIChatHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAIChatHistoryRequest create() => GetAIChatHistoryRequest._();
  @$core.override
  GetAIChatHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetAIChatHistoryRequest> createRepeated() =>
      $pb.PbList<GetAIChatHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAIChatHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAIChatHistoryRequest>(create);
  static GetAIChatHistoryRequest? _defaultInstance;
}

/// Response message containing the user's AI chat history
class GetAIChatHistoryResponse extends $pb.GeneratedMessage {
  factory GetAIChatHistoryResponse({
    $core.Iterable<AIChatHistoryEntry>? history,
  }) {
    final result = create();
    if (history != null) result.history.addAll(history);
    return result;
  }

  GetAIChatHistoryResponse._();

  factory GetAIChatHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAIChatHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAIChatHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<AIChatHistoryEntry>(
        1, _omitFieldNames ? '' : 'history', $pb.PbFieldType.PM,
        subBuilder: AIChatHistoryEntry.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIChatHistoryResponse clone() =>
      GetAIChatHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAIChatHistoryResponse copyWith(
          void Function(GetAIChatHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as GetAIChatHistoryResponse))
          as GetAIChatHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAIChatHistoryResponse create() => GetAIChatHistoryResponse._();
  @$core.override
  GetAIChatHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetAIChatHistoryResponse> createRepeated() =>
      $pb.PbList<GetAIChatHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAIChatHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAIChatHistoryResponse>(create);
  static GetAIChatHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AIChatHistoryEntry> get history => $_getList(0);
}

/// Action button for rich chat responses
class ActionButton extends $pb.GeneratedMessage {
  factory ActionButton({
    $core.String? label,
    $core.String? actionType,
    $core.String? payload,
    $core.String? icon,
  }) {
    final result = create();
    if (label != null) result.label = label;
    if (actionType != null) result.actionType = actionType;
    if (payload != null) result.payload = payload;
    if (icon != null) result.icon = icon;
    return result;
  }

  ActionButton._();

  factory ActionButton.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ActionButton.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ActionButton',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'label')
    ..aOS(2, _omitFieldNames ? '' : 'actionType')
    ..aOS(3, _omitFieldNames ? '' : 'payload')
    ..aOS(4, _omitFieldNames ? '' : 'icon')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActionButton clone() => ActionButton()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActionButton copyWith(void Function(ActionButton) updates) =>
      super.copyWith((message) => updates(message as ActionButton))
          as ActionButton;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActionButton create() => ActionButton._();
  @$core.override
  ActionButton createEmptyInstance() => create();
  static $pb.PbList<ActionButton> createRepeated() =>
      $pb.PbList<ActionButton>();
  @$core.pragma('dart2js:noInline')
  static ActionButton getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ActionButton>(create);
  static ActionButton? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get actionType => $_getSZ(1);
  @$pb.TagNumber(2)
  set actionType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActionType() => $_has(1);
  @$pb.TagNumber(2)
  void clearActionType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get payload => $_getSZ(2);
  @$pb.TagNumber(3)
  set payload($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPayload() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayload() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get icon => $_getSZ(3);
  @$pb.TagNumber(4)
  set icon($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIcon() => $_has(3);
  @$pb.TagNumber(4)
  void clearIcon() => $_clearField(4);
}

/// Structured confirmation data for financial actions
class ConfirmationData extends $pb.GeneratedMessage {
  factory ConfirmationData({
    $core.String? actionType,
    $core.String? amount,
    $core.String? currency,
    $core.String? recipientName,
    $core.String? recipientId,
    $core.String? description,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? extra,
  }) {
    final result = create();
    if (actionType != null) result.actionType = actionType;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (recipientName != null) result.recipientName = recipientName;
    if (recipientId != null) result.recipientId = recipientId;
    if (description != null) result.description = description;
    if (extra != null) result.extra.addEntries(extra);
    return result;
  }

  ConfirmationData._();

  factory ConfirmationData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfirmationData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfirmationData',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'actionType')
    ..aOS(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'recipientName')
    ..aOS(5, _omitFieldNames ? '' : 'recipientId')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..m<$core.String, $core.String>(7, _omitFieldNames ? '' : 'extra',
        entryClassName: 'ConfirmationData.ExtraEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmationData clone() => ConfirmationData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmationData copyWith(void Function(ConfirmationData) updates) =>
      super.copyWith((message) => updates(message as ConfirmationData))
          as ConfirmationData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmationData create() => ConfirmationData._();
  @$core.override
  ConfirmationData createEmptyInstance() => create();
  static $pb.PbList<ConfirmationData> createRepeated() =>
      $pb.PbList<ConfirmationData>();
  @$core.pragma('dart2js:noInline')
  static ConfirmationData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfirmationData>(create);
  static ConfirmationData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get actionType => $_getSZ(0);
  @$pb.TagNumber(1)
  set actionType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasActionType() => $_has(0);
  @$pb.TagNumber(1)
  void clearActionType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get amount => $_getSZ(1);
  @$pb.TagNumber(2)
  set amount($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientName => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecipientName() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientId => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRecipientId() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbMap<$core.String, $core.String> get extra => $_getMap(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
