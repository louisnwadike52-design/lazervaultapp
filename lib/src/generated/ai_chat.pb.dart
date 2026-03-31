//
//  Generated code. Do not modify.
//  source: ai_chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

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
    final $result = create();
    if (query != null) {
      $result.query = query;
    }
    if (txHistory != null) {
      $result.txHistory = txHistory;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (uploadedFile != null) {
      $result.uploadedFile = uploadedFile;
    }
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    if (sourceContext != null) {
      $result.sourceContext = sourceContext;
    }
    if (language != null) {
      $result.language = language;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (userCountry != null) {
      $result.userCountry = userCountry;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    return $result;
  }
  ProcessChatRequest._() : super();
  factory ProcessChatRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessChatRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessChatRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(2, _omitFieldNames ? '' : 'txHistory')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU3)
    ..aOM<ChatFile>(4, _omitFieldNames ? '' : 'uploadedFile', subBuilder: ChatFile.create)
    ..aOS(5, _omitFieldNames ? '' : 'sessionId')
    ..aOS(6, _omitFieldNames ? '' : 'sourceContext')
    ..aOS(7, _omitFieldNames ? '' : 'language')
    ..aOS(8, _omitFieldNames ? '' : 'accountId')
    ..aOS(9, _omitFieldNames ? '' : 'userCountry')
    ..aOS(10, _omitFieldNames ? '' : 'currency')
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
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get txHistory => $_getSZ(1);
  @$pb.TagNumber(2)
  set txHistory($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTxHistory() => $_has(1);
  @$pb.TagNumber(2)
  void clearTxHistory() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get userId => $_getIZ(2);
  @$pb.TagNumber(3)
  set userId($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  /// Optional file handling field
  @$pb.TagNumber(4)
  ChatFile get uploadedFile => $_getN(3);
  @$pb.TagNumber(4)
  set uploadedFile(ChatFile v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUploadedFile() => $_has(3);
  @$pb.TagNumber(4)
  void clearUploadedFile() => clearField(4);
  @$pb.TagNumber(4)
  ChatFile ensureUploadedFile() => $_ensure(3);

  /// Conversation context fields
  @$pb.TagNumber(5)
  $core.String get sessionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set sessionId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSessionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSessionId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get sourceContext => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceContext($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSourceContext() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceContext() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get language => $_getSZ(6);
  @$pb.TagNumber(7)
  set language($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLanguage() => $_has(6);
  @$pb.TagNumber(7)
  void clearLanguage() => clearField(7);

  /// Account context fields for agent routing
  @$pb.TagNumber(8)
  $core.String get accountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set accountId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearAccountId() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get userCountry => $_getSZ(8);
  @$pb.TagNumber(9)
  set userCountry($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasUserCountry() => $_has(8);
  @$pb.TagNumber(9)
  void clearUserCountry() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(9);
  @$pb.TagNumber(10)
  set currency($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrency() => clearField(10);
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
    $core.Map<$core.String, $core.String>? entities,
    $core.bool? requiresConfirmation,
    $core.Iterable<ActionButton>? actionButtons,
    $core.String? sessionId,
    ConfirmationData? confirmationData,
    $core.String? conversationState,
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
    if (generatedFiles != null) {
      $result.generatedFiles.addAll(generatedFiles);
    }
    if (fileAnalysis != null) {
      $result.fileAnalysis = fileAnalysis;
    }
    if (intent != null) {
      $result.intent = intent;
    }
    if (entities != null) {
      $result.entities.addAll(entities);
    }
    if (requiresConfirmation != null) {
      $result.requiresConfirmation = requiresConfirmation;
    }
    if (actionButtons != null) {
      $result.actionButtons.addAll(actionButtons);
    }
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    if (confirmationData != null) {
      $result.confirmationData = confirmationData;
    }
    if (conversationState != null) {
      $result.conversationState = conversationState;
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
    ..pc<ChatFile>(5, _omitFieldNames ? '' : 'generatedFiles', $pb.PbFieldType.PM, subBuilder: ChatFile.create)
    ..aOM<FileAnalysis>(6, _omitFieldNames ? '' : 'fileAnalysis', subBuilder: FileAnalysis.create)
    ..aOS(7, _omitFieldNames ? '' : 'intent')
    ..m<$core.String, $core.String>(8, _omitFieldNames ? '' : 'entities', entryClassName: 'ProcessChatResponse.EntitiesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOB(9, _omitFieldNames ? '' : 'requiresConfirmation')
    ..pc<ActionButton>(10, _omitFieldNames ? '' : 'actionButtons', $pb.PbFieldType.PM, subBuilder: ActionButton.create)
    ..aOS(11, _omitFieldNames ? '' : 'sessionId')
    ..aOM<ConfirmationData>(12, _omitFieldNames ? '' : 'confirmationData', subBuilder: ConfirmationData.create)
    ..aOS(13, _omitFieldNames ? '' : 'conversationState')
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
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get query => $_getSZ(2);
  @$pb.TagNumber(3)
  set query($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuery() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get response => $_getSZ(3);
  @$pb.TagNumber(4)
  set response($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasResponse() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponse() => clearField(4);

  /// Optional file handling response fields
  @$pb.TagNumber(5)
  $core.List<ChatFile> get generatedFiles => $_getList(4);

  @$pb.TagNumber(6)
  FileAnalysis get fileAnalysis => $_getN(5);
  @$pb.TagNumber(6)
  set fileAnalysis(FileAnalysis v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasFileAnalysis() => $_has(5);
  @$pb.TagNumber(6)
  void clearFileAnalysis() => clearField(6);
  @$pb.TagNumber(6)
  FileAnalysis ensureFileAnalysis() => $_ensure(5);

  /// Conversation intelligence fields
  @$pb.TagNumber(7)
  $core.String get intent => $_getSZ(6);
  @$pb.TagNumber(7)
  set intent($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIntent() => $_has(6);
  @$pb.TagNumber(7)
  void clearIntent() => clearField(7);

  @$pb.TagNumber(8)
  $core.Map<$core.String, $core.String> get entities => $_getMap(7);

  @$pb.TagNumber(9)
  $core.bool get requiresConfirmation => $_getBF(8);
  @$pb.TagNumber(9)
  set requiresConfirmation($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRequiresConfirmation() => $_has(8);
  @$pb.TagNumber(9)
  void clearRequiresConfirmation() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<ActionButton> get actionButtons => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get sessionId => $_getSZ(10);
  @$pb.TagNumber(11)
  set sessionId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSessionId() => $_has(10);
  @$pb.TagNumber(11)
  void clearSessionId() => clearField(11);

  @$pb.TagNumber(12)
  ConfirmationData get confirmationData => $_getN(11);
  @$pb.TagNumber(12)
  set confirmationData(ConfirmationData v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasConfirmationData() => $_has(11);
  @$pb.TagNumber(12)
  void clearConfirmationData() => clearField(12);
  @$pb.TagNumber(12)
  ConfirmationData ensureConfirmationData() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get conversationState => $_getSZ(12);
  @$pb.TagNumber(13)
  set conversationState($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasConversationState() => $_has(12);
  @$pb.TagNumber(13)
  void clearConversationState() => clearField(13);
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
    final $result = create();
    if (filename != null) {
      $result.filename = filename;
    }
    if (contentType != null) {
      $result.contentType = contentType;
    }
    if (fileContent != null) {
      $result.fileContent = fileContent;
    }
    if (fileId != null) {
      $result.fileId = fileId;
    }
    if (fileUrl != null) {
      $result.fileUrl = fileUrl;
    }
    if (fileSize != null) {
      $result.fileSize = fileSize;
    }
    if (uploadTimestamp != null) {
      $result.uploadTimestamp = uploadTimestamp;
    }
    return $result;
  }
  ChatFile._() : super();
  factory ChatFile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatFile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatFile', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'filename')
    ..aOS(2, _omitFieldNames ? '' : 'contentType')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'fileContent', $pb.PbFieldType.OY)
    ..aOS(4, _omitFieldNames ? '' : 'fileId')
    ..aOS(5, _omitFieldNames ? '' : 'fileUrl')
    ..aInt64(6, _omitFieldNames ? '' : 'fileSize')
    ..aOS(7, _omitFieldNames ? '' : 'uploadTimestamp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatFile clone() => ChatFile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatFile copyWith(void Function(ChatFile) updates) => super.copyWith((message) => updates(message as ChatFile)) as ChatFile;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatFile create() => ChatFile._();
  ChatFile createEmptyInstance() => create();
  static $pb.PbList<ChatFile> createRepeated() => $pb.PbList<ChatFile>();
  @$core.pragma('dart2js:noInline')
  static ChatFile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatFile>(create);
  static ChatFile? _defaultInstance;

  /// For uploads - client provides these fields
  @$pb.TagNumber(1)
  $core.String get filename => $_getSZ(0);
  @$pb.TagNumber(1)
  set filename($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilename() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilename() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get contentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set contentType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearContentType() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get fileContent => $_getN(2);
  @$pb.TagNumber(3)
  set fileContent($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFileContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileContent() => clearField(3);

  /// For responses - server provides these fields
  @$pb.TagNumber(4)
  $core.String get fileId => $_getSZ(3);
  @$pb.TagNumber(4)
  set fileId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFileId() => $_has(3);
  @$pb.TagNumber(4)
  void clearFileId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get fileUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set fileUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFileUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearFileUrl() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get fileSize => $_getI64(5);
  @$pb.TagNumber(6)
  set fileSize($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFileSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearFileSize() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get uploadTimestamp => $_getSZ(6);
  @$pb.TagNumber(7)
  set uploadTimestamp($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUploadTimestamp() => $_has(6);
  @$pb.TagNumber(7)
  void clearUploadTimestamp() => clearField(7);
}

/// File analysis results from AI
class FileAnalysis extends $pb.GeneratedMessage {
  factory FileAnalysis({
    $core.Iterable<FileAnalysisResult>? results,
    $core.String? summary,
  }) {
    final $result = create();
    if (results != null) {
      $result.results.addAll(results);
    }
    if (summary != null) {
      $result.summary = summary;
    }
    return $result;
  }
  FileAnalysis._() : super();
  factory FileAnalysis.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileAnalysis.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FileAnalysis', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<FileAnalysisResult>(1, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM, subBuilder: FileAnalysisResult.create)
    ..aOS(2, _omitFieldNames ? '' : 'summary')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileAnalysis clone() => FileAnalysis()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileAnalysis copyWith(void Function(FileAnalysis) updates) => super.copyWith((message) => updates(message as FileAnalysis)) as FileAnalysis;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileAnalysis create() => FileAnalysis._();
  FileAnalysis createEmptyInstance() => create();
  static $pb.PbList<FileAnalysis> createRepeated() => $pb.PbList<FileAnalysis>();
  @$core.pragma('dart2js:noInline')
  static FileAnalysis getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileAnalysis>(create);
  static FileAnalysis? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FileAnalysisResult> get results => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get summary => $_getSZ(1);
  @$pb.TagNumber(2)
  set summary($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSummary() => $_has(1);
  @$pb.TagNumber(2)
  void clearSummary() => clearField(2);
}

/// Individual file analysis result
class FileAnalysisResult extends $pb.GeneratedMessage {
  factory FileAnalysisResult({
    $core.String? fileId,
    $core.String? filename,
    $core.String? analysisType,
    $core.String? analysisResult,
    $core.Map<$core.String, $core.String>? metadata,
    $core.bool? processingSuccess,
    $core.String? errorMessage,
  }) {
    final $result = create();
    if (fileId != null) {
      $result.fileId = fileId;
    }
    if (filename != null) {
      $result.filename = filename;
    }
    if (analysisType != null) {
      $result.analysisType = analysisType;
    }
    if (analysisResult != null) {
      $result.analysisResult = analysisResult;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    if (processingSuccess != null) {
      $result.processingSuccess = processingSuccess;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    return $result;
  }
  FileAnalysisResult._() : super();
  factory FileAnalysisResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileAnalysisResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FileAnalysisResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fileId')
    ..aOS(2, _omitFieldNames ? '' : 'filename')
    ..aOS(3, _omitFieldNames ? '' : 'analysisType')
    ..aOS(4, _omitFieldNames ? '' : 'analysisResult')
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'metadata', entryClassName: 'FileAnalysisResult.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOB(6, _omitFieldNames ? '' : 'processingSuccess')
    ..aOS(7, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileAnalysisResult clone() => FileAnalysisResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileAnalysisResult copyWith(void Function(FileAnalysisResult) updates) => super.copyWith((message) => updates(message as FileAnalysisResult)) as FileAnalysisResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileAnalysisResult create() => FileAnalysisResult._();
  FileAnalysisResult createEmptyInstance() => create();
  static $pb.PbList<FileAnalysisResult> createRepeated() => $pb.PbList<FileAnalysisResult>();
  @$core.pragma('dart2js:noInline')
  static FileAnalysisResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileAnalysisResult>(create);
  static FileAnalysisResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fileId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fileId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFileId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get filename => $_getSZ(1);
  @$pb.TagNumber(2)
  set filename($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFilename() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilename() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get analysisType => $_getSZ(2);
  @$pb.TagNumber(3)
  set analysisType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAnalysisType() => $_has(2);
  @$pb.TagNumber(3)
  void clearAnalysisType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get analysisResult => $_getSZ(3);
  @$pb.TagNumber(4)
  set analysisResult($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAnalysisResult() => $_has(3);
  @$pb.TagNumber(4)
  void clearAnalysisResult() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(4);

  @$pb.TagNumber(6)
  $core.bool get processingSuccess => $_getBF(5);
  @$pb.TagNumber(6)
  set processingSuccess($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProcessingSuccess() => $_has(5);
  @$pb.TagNumber(6)
  void clearProcessingSuccess() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get errorMessage => $_getSZ(6);
  @$pb.TagNumber(7)
  set errorMessage($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasErrorMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearErrorMessage() => clearField(7);
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
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);
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
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);
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
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get response => $_getSZ(1);
  @$pb.TagNumber(2)
  set response($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);
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
  $core.List<AIChatHistoryEntry> get history => $_getList(0);
}

/// Action button for rich chat responses
class ActionButton extends $pb.GeneratedMessage {
  factory ActionButton({
    $core.String? label,
    $core.String? actionType,
    $core.String? payload,
    $core.String? icon,
  }) {
    final $result = create();
    if (label != null) {
      $result.label = label;
    }
    if (actionType != null) {
      $result.actionType = actionType;
    }
    if (payload != null) {
      $result.payload = payload;
    }
    if (icon != null) {
      $result.icon = icon;
    }
    return $result;
  }
  ActionButton._() : super();
  factory ActionButton.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ActionButton.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ActionButton', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'label')
    ..aOS(2, _omitFieldNames ? '' : 'actionType')
    ..aOS(3, _omitFieldNames ? '' : 'payload')
    ..aOS(4, _omitFieldNames ? '' : 'icon')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ActionButton clone() => ActionButton()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ActionButton copyWith(void Function(ActionButton) updates) => super.copyWith((message) => updates(message as ActionButton)) as ActionButton;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActionButton create() => ActionButton._();
  ActionButton createEmptyInstance() => create();
  static $pb.PbList<ActionButton> createRepeated() => $pb.PbList<ActionButton>();
  @$core.pragma('dart2js:noInline')
  static ActionButton getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActionButton>(create);
  static ActionButton? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get actionType => $_getSZ(1);
  @$pb.TagNumber(2)
  set actionType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActionType() => $_has(1);
  @$pb.TagNumber(2)
  void clearActionType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get payload => $_getSZ(2);
  @$pb.TagNumber(3)
  set payload($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayload() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayload() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get icon => $_getSZ(3);
  @$pb.TagNumber(4)
  set icon($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIcon() => $_has(3);
  @$pb.TagNumber(4)
  void clearIcon() => clearField(4);
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
    $core.Map<$core.String, $core.String>? extra,
  }) {
    final $result = create();
    if (actionType != null) {
      $result.actionType = actionType;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (recipientName != null) {
      $result.recipientName = recipientName;
    }
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    if (description != null) {
      $result.description = description;
    }
    if (extra != null) {
      $result.extra.addAll(extra);
    }
    return $result;
  }
  ConfirmationData._() : super();
  factory ConfirmationData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConfirmationData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConfirmationData', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'actionType')
    ..aOS(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'recipientName')
    ..aOS(5, _omitFieldNames ? '' : 'recipientId')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..m<$core.String, $core.String>(7, _omitFieldNames ? '' : 'extra', entryClassName: 'ConfirmationData.ExtraEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConfirmationData clone() => ConfirmationData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConfirmationData copyWith(void Function(ConfirmationData) updates) => super.copyWith((message) => updates(message as ConfirmationData)) as ConfirmationData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmationData create() => ConfirmationData._();
  ConfirmationData createEmptyInstance() => create();
  static $pb.PbList<ConfirmationData> createRepeated() => $pb.PbList<ConfirmationData>();
  @$core.pragma('dart2js:noInline')
  static ConfirmationData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConfirmationData>(create);
  static ConfirmationData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get actionType => $_getSZ(0);
  @$pb.TagNumber(1)
  set actionType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActionType() => $_has(0);
  @$pb.TagNumber(1)
  void clearActionType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get amount => $_getSZ(1);
  @$pb.TagNumber(2)
  set amount($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientName => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRecipientName() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientId => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecipientId() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $core.Map<$core.String, $core.String> get extra => $_getMap(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
