// This is a generated file - do not edit.
//
// Generated from voice-biometrics.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'voice-biometrics.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'voice-biometrics.pbenum.dart';

/// Stream-based verification - audio chunk for streaming
class VoiceAudioChunk extends $pb.GeneratedMessage {
  factory VoiceAudioChunk({
    $core.String? userId,
    $core.List<$core.int>? audioData,
    $fixnum.Int64? sequenceNumber,
    $core.bool? isFinal,
    AudioFormat? format,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (audioData != null) result.audioData = audioData;
    if (sequenceNumber != null) result.sequenceNumber = sequenceNumber;
    if (isFinal != null) result.isFinal = isFinal;
    if (format != null) result.format = format;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  VoiceAudioChunk._();

  factory VoiceAudioChunk.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VoiceAudioChunk.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VoiceAudioChunk',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'audioData', $pb.PbFieldType.OY)
    ..aInt64(3, _omitFieldNames ? '' : 'sequenceNumber')
    ..aOB(4, _omitFieldNames ? '' : 'isFinal')
    ..aOM<AudioFormat>(5, _omitFieldNames ? '' : 'format',
        subBuilder: AudioFormat.create)
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'VoiceAudioChunk.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('voicebiometrics'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VoiceAudioChunk clone() => VoiceAudioChunk()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VoiceAudioChunk copyWith(void Function(VoiceAudioChunk) updates) =>
      super.copyWith((message) => updates(message as VoiceAudioChunk))
          as VoiceAudioChunk;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VoiceAudioChunk create() => VoiceAudioChunk._();
  @$core.override
  VoiceAudioChunk createEmptyInstance() => create();
  static $pb.PbList<VoiceAudioChunk> createRepeated() =>
      $pb.PbList<VoiceAudioChunk>();
  @$core.pragma('dart2js:noInline')
  static VoiceAudioChunk getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VoiceAudioChunk>(create);
  static VoiceAudioChunk? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get audioData => $_getN(1);
  @$pb.TagNumber(2)
  set audioData($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAudioData() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudioData() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get sequenceNumber => $_getI64(2);
  @$pb.TagNumber(3)
  set sequenceNumber($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSequenceNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearSequenceNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isFinal => $_getBF(3);
  @$pb.TagNumber(4)
  set isFinal($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsFinal() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsFinal() => $_clearField(4);

  @$pb.TagNumber(5)
  AudioFormat get format => $_getN(4);
  @$pb.TagNumber(5)
  set format(AudioFormat value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFormat() => $_has(4);
  @$pb.TagNumber(5)
  void clearFormat() => $_clearField(5);
  @$pb.TagNumber(5)
  AudioFormat ensureFormat() => $_ensure(4);

  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(5);
}

/// Stream-based verification response
class VerifyVoiceStreamResponse extends $pb.GeneratedMessage {
  factory VerifyVoiceStreamResponse({
    $core.bool? verified,
    $core.double? similarityScore,
    $core.double? confidence,
    $core.String? message,
    VerificationStatus? status,
    $core.bool? needsMoreAudio,
    $core.int? chunksProcessed,
  }) {
    final result = create();
    if (verified != null) result.verified = verified;
    if (similarityScore != null) result.similarityScore = similarityScore;
    if (confidence != null) result.confidence = confidence;
    if (message != null) result.message = message;
    if (status != null) result.status = status;
    if (needsMoreAudio != null) result.needsMoreAudio = needsMoreAudio;
    if (chunksProcessed != null) result.chunksProcessed = chunksProcessed;
    return result;
  }

  VerifyVoiceStreamResponse._();

  factory VerifyVoiceStreamResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyVoiceStreamResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyVoiceStreamResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'verified')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'similarityScore', $pb.PbFieldType.OF)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'confidence', $pb.PbFieldType.OF)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..e<VerificationStatus>(
        5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: VerificationStatus.VERIFICATION_UNKNOWN,
        valueOf: VerificationStatus.valueOf,
        enumValues: VerificationStatus.values)
    ..aOB(6, _omitFieldNames ? '' : 'needsMoreAudio')
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'chunksProcessed', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyVoiceStreamResponse clone() =>
      VerifyVoiceStreamResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyVoiceStreamResponse copyWith(
          void Function(VerifyVoiceStreamResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyVoiceStreamResponse))
          as VerifyVoiceStreamResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyVoiceStreamResponse create() => VerifyVoiceStreamResponse._();
  @$core.override
  VerifyVoiceStreamResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyVoiceStreamResponse> createRepeated() =>
      $pb.PbList<VerifyVoiceStreamResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyVoiceStreamResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyVoiceStreamResponse>(create);
  static VerifyVoiceStreamResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get verified => $_getBF(0);
  @$pb.TagNumber(1)
  set verified($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVerified() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerified() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get similarityScore => $_getN(1);
  @$pb.TagNumber(2)
  set similarityScore($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSimilarityScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearSimilarityScore() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get confidence => $_getN(2);
  @$pb.TagNumber(3)
  set confidence($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConfidence() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfidence() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  VerificationStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(VerificationStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get needsMoreAudio => $_getBF(5);
  @$pb.TagNumber(6)
  set needsMoreAudio($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNeedsMoreAudio() => $_has(5);
  @$pb.TagNumber(6)
  void clearNeedsMoreAudio() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get chunksProcessed => $_getIZ(6);
  @$pb.TagNumber(7)
  set chunksProcessed($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasChunksProcessed() => $_has(6);
  @$pb.TagNumber(7)
  void clearChunksProcessed() => $_clearField(7);
}

/// Enroll voice request
class EnrollVoiceRequest extends $pb.GeneratedMessage {
  factory EnrollVoiceRequest({
    $core.String? userId,
    $core.Iterable<$core.List<$core.int>>? audioSamples,
    AudioFormat? format,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (audioSamples != null) result.audioSamples.addAll(audioSamples);
    if (format != null) result.format = format;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  EnrollVoiceRequest._();

  factory EnrollVoiceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EnrollVoiceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnrollVoiceRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..p<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'audioSamples', $pb.PbFieldType.PY)
    ..aOM<AudioFormat>(3, _omitFieldNames ? '' : 'format',
        subBuilder: AudioFormat.create)
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'EnrollVoiceRequest.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('voicebiometrics'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnrollVoiceRequest clone() => EnrollVoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnrollVoiceRequest copyWith(void Function(EnrollVoiceRequest) updates) =>
      super.copyWith((message) => updates(message as EnrollVoiceRequest))
          as EnrollVoiceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnrollVoiceRequest create() => EnrollVoiceRequest._();
  @$core.override
  EnrollVoiceRequest createEmptyInstance() => create();
  static $pb.PbList<EnrollVoiceRequest> createRepeated() =>
      $pb.PbList<EnrollVoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static EnrollVoiceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnrollVoiceRequest>(create);
  static EnrollVoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.List<$core.int>> get audioSamples => $_getList(1);

  @$pb.TagNumber(3)
  AudioFormat get format => $_getN(2);
  @$pb.TagNumber(3)
  set format(AudioFormat value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFormat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFormat() => $_clearField(3);
  @$pb.TagNumber(3)
  AudioFormat ensureFormat() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class EnrollVoiceResponse extends $pb.GeneratedMessage {
  factory EnrollVoiceResponse({
    $core.bool? success,
    $core.String? enrollmentId,
    $core.int? samplesCount,
    $core.double? qualityScore,
    $core.String? message,
    VoiceProfile? voiceProfile,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (enrollmentId != null) result.enrollmentId = enrollmentId;
    if (samplesCount != null) result.samplesCount = samplesCount;
    if (qualityScore != null) result.qualityScore = qualityScore;
    if (message != null) result.message = message;
    if (voiceProfile != null) result.voiceProfile = voiceProfile;
    return result;
  }

  EnrollVoiceResponse._();

  factory EnrollVoiceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EnrollVoiceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnrollVoiceResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'enrollmentId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'samplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'qualityScore', $pb.PbFieldType.OF)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..aOM<VoiceProfile>(6, _omitFieldNames ? '' : 'voiceProfile',
        subBuilder: VoiceProfile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnrollVoiceResponse clone() => EnrollVoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnrollVoiceResponse copyWith(void Function(EnrollVoiceResponse) updates) =>
      super.copyWith((message) => updates(message as EnrollVoiceResponse))
          as EnrollVoiceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnrollVoiceResponse create() => EnrollVoiceResponse._();
  @$core.override
  EnrollVoiceResponse createEmptyInstance() => create();
  static $pb.PbList<EnrollVoiceResponse> createRepeated() =>
      $pb.PbList<EnrollVoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static EnrollVoiceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnrollVoiceResponse>(create);
  static EnrollVoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get enrollmentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set enrollmentId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEnrollmentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnrollmentId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get samplesCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set samplesCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSamplesCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearSamplesCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get qualityScore => $_getN(3);
  @$pb.TagNumber(4)
  set qualityScore($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasQualityScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearQualityScore() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);

  @$pb.TagNumber(6)
  VoiceProfile get voiceProfile => $_getN(5);
  @$pb.TagNumber(6)
  set voiceProfile(VoiceProfile value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasVoiceProfile() => $_has(5);
  @$pb.TagNumber(6)
  void clearVoiceProfile() => $_clearField(6);
  @$pb.TagNumber(6)
  VoiceProfile ensureVoiceProfile() => $_ensure(5);
}

/// Verify voice request
class VerifyVoiceRequest extends $pb.GeneratedMessage {
  factory VerifyVoiceRequest({
    $core.String? userId,
    $core.List<$core.int>? audioSample,
    AudioFormat? format,
    $core.double? threshold,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (audioSample != null) result.audioSample = audioSample;
    if (format != null) result.format = format;
    if (threshold != null) result.threshold = threshold;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  VerifyVoiceRequest._();

  factory VerifyVoiceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyVoiceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyVoiceRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'audioSample', $pb.PbFieldType.OY)
    ..aOM<AudioFormat>(3, _omitFieldNames ? '' : 'format',
        subBuilder: AudioFormat.create)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'threshold', $pb.PbFieldType.OF)
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'VerifyVoiceRequest.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('voicebiometrics'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyVoiceRequest clone() => VerifyVoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyVoiceRequest copyWith(void Function(VerifyVoiceRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyVoiceRequest))
          as VerifyVoiceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyVoiceRequest create() => VerifyVoiceRequest._();
  @$core.override
  VerifyVoiceRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyVoiceRequest> createRepeated() =>
      $pb.PbList<VerifyVoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyVoiceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyVoiceRequest>(create);
  static VerifyVoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get audioSample => $_getN(1);
  @$pb.TagNumber(2)
  set audioSample($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAudioSample() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudioSample() => $_clearField(2);

  @$pb.TagNumber(3)
  AudioFormat get format => $_getN(2);
  @$pb.TagNumber(3)
  set format(AudioFormat value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFormat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFormat() => $_clearField(3);
  @$pb.TagNumber(3)
  AudioFormat ensureFormat() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get threshold => $_getN(3);
  @$pb.TagNumber(4)
  set threshold($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasThreshold() => $_has(3);
  @$pb.TagNumber(4)
  void clearThreshold() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(4);
}

class VerifyVoiceResponse extends $pb.GeneratedMessage {
  factory VerifyVoiceResponse({
    $core.bool? verified,
    $core.double? similarityScore,
    $core.double? confidence,
    $core.String? message,
    VerificationStatus? status,
    $fixnum.Int64? verificationTimestamp,
  }) {
    final result = create();
    if (verified != null) result.verified = verified;
    if (similarityScore != null) result.similarityScore = similarityScore;
    if (confidence != null) result.confidence = confidence;
    if (message != null) result.message = message;
    if (status != null) result.status = status;
    if (verificationTimestamp != null)
      result.verificationTimestamp = verificationTimestamp;
    return result;
  }

  VerifyVoiceResponse._();

  factory VerifyVoiceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyVoiceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyVoiceResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'verified')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'similarityScore', $pb.PbFieldType.OF)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'confidence', $pb.PbFieldType.OF)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..e<VerificationStatus>(
        5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: VerificationStatus.VERIFICATION_UNKNOWN,
        valueOf: VerificationStatus.valueOf,
        enumValues: VerificationStatus.values)
    ..aInt64(6, _omitFieldNames ? '' : 'verificationTimestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyVoiceResponse clone() => VerifyVoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyVoiceResponse copyWith(void Function(VerifyVoiceResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyVoiceResponse))
          as VerifyVoiceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyVoiceResponse create() => VerifyVoiceResponse._();
  @$core.override
  VerifyVoiceResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyVoiceResponse> createRepeated() =>
      $pb.PbList<VerifyVoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyVoiceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyVoiceResponse>(create);
  static VerifyVoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get verified => $_getBF(0);
  @$pb.TagNumber(1)
  set verified($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVerified() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerified() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get similarityScore => $_getN(1);
  @$pb.TagNumber(2)
  set similarityScore($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSimilarityScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearSimilarityScore() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get confidence => $_getN(2);
  @$pb.TagNumber(3)
  set confidence($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConfidence() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfidence() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  VerificationStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(VerificationStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get verificationTimestamp => $_getI64(5);
  @$pb.TagNumber(6)
  set verificationTimestamp($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerificationTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationTimestamp() => $_clearField(6);
}

/// Check enrollment status
class CheckEnrollmentStatusRequest extends $pb.GeneratedMessage {
  factory CheckEnrollmentStatusRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  CheckEnrollmentStatusRequest._();

  factory CheckEnrollmentStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckEnrollmentStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckEnrollmentStatusRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckEnrollmentStatusRequest clone() =>
      CheckEnrollmentStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckEnrollmentStatusRequest copyWith(
          void Function(CheckEnrollmentStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CheckEnrollmentStatusRequest))
          as CheckEnrollmentStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckEnrollmentStatusRequest create() =>
      CheckEnrollmentStatusRequest._();
  @$core.override
  CheckEnrollmentStatusRequest createEmptyInstance() => create();
  static $pb.PbList<CheckEnrollmentStatusRequest> createRepeated() =>
      $pb.PbList<CheckEnrollmentStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckEnrollmentStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckEnrollmentStatusRequest>(create);
  static CheckEnrollmentStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class CheckEnrollmentStatusResponse extends $pb.GeneratedMessage {
  factory CheckEnrollmentStatusResponse({
    $core.bool? isEnrolled,
    $core.String? enrollmentId,
    $fixnum.Int64? enrolledAt,
    $core.int? samplesCount,
    $core.double? qualityScore,
    VoiceProfile? voiceProfile,
  }) {
    final result = create();
    if (isEnrolled != null) result.isEnrolled = isEnrolled;
    if (enrollmentId != null) result.enrollmentId = enrollmentId;
    if (enrolledAt != null) result.enrolledAt = enrolledAt;
    if (samplesCount != null) result.samplesCount = samplesCount;
    if (qualityScore != null) result.qualityScore = qualityScore;
    if (voiceProfile != null) result.voiceProfile = voiceProfile;
    return result;
  }

  CheckEnrollmentStatusResponse._();

  factory CheckEnrollmentStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckEnrollmentStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckEnrollmentStatusResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isEnrolled')
    ..aOS(2, _omitFieldNames ? '' : 'enrollmentId')
    ..aInt64(3, _omitFieldNames ? '' : 'enrolledAt')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'samplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'qualityScore', $pb.PbFieldType.OF)
    ..aOM<VoiceProfile>(6, _omitFieldNames ? '' : 'voiceProfile',
        subBuilder: VoiceProfile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckEnrollmentStatusResponse clone() =>
      CheckEnrollmentStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckEnrollmentStatusResponse copyWith(
          void Function(CheckEnrollmentStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CheckEnrollmentStatusResponse))
          as CheckEnrollmentStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckEnrollmentStatusResponse create() =>
      CheckEnrollmentStatusResponse._();
  @$core.override
  CheckEnrollmentStatusResponse createEmptyInstance() => create();
  static $pb.PbList<CheckEnrollmentStatusResponse> createRepeated() =>
      $pb.PbList<CheckEnrollmentStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckEnrollmentStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckEnrollmentStatusResponse>(create);
  static CheckEnrollmentStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isEnrolled => $_getBF(0);
  @$pb.TagNumber(1)
  set isEnrolled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsEnrolled() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsEnrolled() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get enrollmentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set enrollmentId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEnrollmentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnrollmentId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get enrolledAt => $_getI64(2);
  @$pb.TagNumber(3)
  set enrolledAt($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEnrolledAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearEnrolledAt() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get samplesCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set samplesCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSamplesCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearSamplesCount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get qualityScore => $_getN(4);
  @$pb.TagNumber(5)
  set qualityScore($core.double value) => $_setFloat(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQualityScore() => $_has(4);
  @$pb.TagNumber(5)
  void clearQualityScore() => $_clearField(5);

  @$pb.TagNumber(6)
  VoiceProfile get voiceProfile => $_getN(5);
  @$pb.TagNumber(6)
  set voiceProfile(VoiceProfile value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasVoiceProfile() => $_has(5);
  @$pb.TagNumber(6)
  void clearVoiceProfile() => $_clearField(6);
  @$pb.TagNumber(6)
  VoiceProfile ensureVoiceProfile() => $_ensure(5);
}

/// Delete enrollment
class DeleteVoiceEnrollmentRequest extends $pb.GeneratedMessage {
  factory DeleteVoiceEnrollmentRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  DeleteVoiceEnrollmentRequest._();

  factory DeleteVoiceEnrollmentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteVoiceEnrollmentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteVoiceEnrollmentRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteVoiceEnrollmentRequest clone() =>
      DeleteVoiceEnrollmentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteVoiceEnrollmentRequest copyWith(
          void Function(DeleteVoiceEnrollmentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteVoiceEnrollmentRequest))
          as DeleteVoiceEnrollmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteVoiceEnrollmentRequest create() =>
      DeleteVoiceEnrollmentRequest._();
  @$core.override
  DeleteVoiceEnrollmentRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteVoiceEnrollmentRequest> createRepeated() =>
      $pb.PbList<DeleteVoiceEnrollmentRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteVoiceEnrollmentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteVoiceEnrollmentRequest>(create);
  static DeleteVoiceEnrollmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class DeleteVoiceEnrollmentResponse extends $pb.GeneratedMessage {
  factory DeleteVoiceEnrollmentResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteVoiceEnrollmentResponse._();

  factory DeleteVoiceEnrollmentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteVoiceEnrollmentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteVoiceEnrollmentResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteVoiceEnrollmentResponse clone() =>
      DeleteVoiceEnrollmentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteVoiceEnrollmentResponse copyWith(
          void Function(DeleteVoiceEnrollmentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteVoiceEnrollmentResponse))
          as DeleteVoiceEnrollmentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteVoiceEnrollmentResponse create() =>
      DeleteVoiceEnrollmentResponse._();
  @$core.override
  DeleteVoiceEnrollmentResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteVoiceEnrollmentResponse> createRepeated() =>
      $pb.PbList<DeleteVoiceEnrollmentResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteVoiceEnrollmentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteVoiceEnrollmentResponse>(create);
  static DeleteVoiceEnrollmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Update enrollment
class UpdateVoiceEnrollmentRequest extends $pb.GeneratedMessage {
  factory UpdateVoiceEnrollmentRequest({
    $core.String? userId,
    $core.Iterable<$core.List<$core.int>>? audioSamples,
    AudioFormat? format,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (audioSamples != null) result.audioSamples.addAll(audioSamples);
    if (format != null) result.format = format;
    return result;
  }

  UpdateVoiceEnrollmentRequest._();

  factory UpdateVoiceEnrollmentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateVoiceEnrollmentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateVoiceEnrollmentRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..p<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'audioSamples', $pb.PbFieldType.PY)
    ..aOM<AudioFormat>(3, _omitFieldNames ? '' : 'format',
        subBuilder: AudioFormat.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateVoiceEnrollmentRequest clone() =>
      UpdateVoiceEnrollmentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateVoiceEnrollmentRequest copyWith(
          void Function(UpdateVoiceEnrollmentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateVoiceEnrollmentRequest))
          as UpdateVoiceEnrollmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateVoiceEnrollmentRequest create() =>
      UpdateVoiceEnrollmentRequest._();
  @$core.override
  UpdateVoiceEnrollmentRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateVoiceEnrollmentRequest> createRepeated() =>
      $pb.PbList<UpdateVoiceEnrollmentRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateVoiceEnrollmentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateVoiceEnrollmentRequest>(create);
  static UpdateVoiceEnrollmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.List<$core.int>> get audioSamples => $_getList(1);

  @$pb.TagNumber(3)
  AudioFormat get format => $_getN(2);
  @$pb.TagNumber(3)
  set format(AudioFormat value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFormat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFormat() => $_clearField(3);
  @$pb.TagNumber(3)
  AudioFormat ensureFormat() => $_ensure(2);
}

class UpdateVoiceEnrollmentResponse extends $pb.GeneratedMessage {
  factory UpdateVoiceEnrollmentResponse({
    $core.bool? success,
    $core.int? newSamplesCount,
    $core.double? updatedQualityScore,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (newSamplesCount != null) result.newSamplesCount = newSamplesCount;
    if (updatedQualityScore != null)
      result.updatedQualityScore = updatedQualityScore;
    if (message != null) result.message = message;
    return result;
  }

  UpdateVoiceEnrollmentResponse._();

  factory UpdateVoiceEnrollmentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateVoiceEnrollmentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateVoiceEnrollmentResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'newSamplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'updatedQualityScore', $pb.PbFieldType.OF)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateVoiceEnrollmentResponse clone() =>
      UpdateVoiceEnrollmentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateVoiceEnrollmentResponse copyWith(
          void Function(UpdateVoiceEnrollmentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateVoiceEnrollmentResponse))
          as UpdateVoiceEnrollmentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateVoiceEnrollmentResponse create() =>
      UpdateVoiceEnrollmentResponse._();
  @$core.override
  UpdateVoiceEnrollmentResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateVoiceEnrollmentResponse> createRepeated() =>
      $pb.PbList<UpdateVoiceEnrollmentResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateVoiceEnrollmentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateVoiceEnrollmentResponse>(create);
  static UpdateVoiceEnrollmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get newSamplesCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set newSamplesCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewSamplesCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewSamplesCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get updatedQualityScore => $_getN(2);
  @$pb.TagNumber(3)
  set updatedQualityScore($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdatedQualityScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedQualityScore() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// Get enrollment details
class GetVoiceEnrollmentRequest extends $pb.GeneratedMessage {
  factory GetVoiceEnrollmentRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetVoiceEnrollmentRequest._();

  factory GetVoiceEnrollmentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVoiceEnrollmentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVoiceEnrollmentRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVoiceEnrollmentRequest clone() =>
      GetVoiceEnrollmentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVoiceEnrollmentRequest copyWith(
          void Function(GetVoiceEnrollmentRequest) updates) =>
      super.copyWith((message) => updates(message as GetVoiceEnrollmentRequest))
          as GetVoiceEnrollmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVoiceEnrollmentRequest create() => GetVoiceEnrollmentRequest._();
  @$core.override
  GetVoiceEnrollmentRequest createEmptyInstance() => create();
  static $pb.PbList<GetVoiceEnrollmentRequest> createRepeated() =>
      $pb.PbList<GetVoiceEnrollmentRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVoiceEnrollmentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVoiceEnrollmentRequest>(create);
  static GetVoiceEnrollmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class GetVoiceEnrollmentResponse extends $pb.GeneratedMessage {
  factory GetVoiceEnrollmentResponse({
    $core.bool? exists,
    VoiceProfile? voiceProfile,
    EnrollmentMetadata? metadata,
  }) {
    final result = create();
    if (exists != null) result.exists = exists;
    if (voiceProfile != null) result.voiceProfile = voiceProfile;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  GetVoiceEnrollmentResponse._();

  factory GetVoiceEnrollmentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVoiceEnrollmentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVoiceEnrollmentResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'exists')
    ..aOM<VoiceProfile>(2, _omitFieldNames ? '' : 'voiceProfile',
        subBuilder: VoiceProfile.create)
    ..aOM<EnrollmentMetadata>(3, _omitFieldNames ? '' : 'metadata',
        subBuilder: EnrollmentMetadata.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVoiceEnrollmentResponse clone() =>
      GetVoiceEnrollmentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVoiceEnrollmentResponse copyWith(
          void Function(GetVoiceEnrollmentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetVoiceEnrollmentResponse))
          as GetVoiceEnrollmentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVoiceEnrollmentResponse create() => GetVoiceEnrollmentResponse._();
  @$core.override
  GetVoiceEnrollmentResponse createEmptyInstance() => create();
  static $pb.PbList<GetVoiceEnrollmentResponse> createRepeated() =>
      $pb.PbList<GetVoiceEnrollmentResponse>();
  @$core.pragma('dart2js:noInline')
  static GetVoiceEnrollmentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVoiceEnrollmentResponse>(create);
  static GetVoiceEnrollmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get exists => $_getBF(0);
  @$pb.TagNumber(1)
  set exists($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExists() => $_has(0);
  @$pb.TagNumber(1)
  void clearExists() => $_clearField(1);

  @$pb.TagNumber(2)
  VoiceProfile get voiceProfile => $_getN(1);
  @$pb.TagNumber(2)
  set voiceProfile(VoiceProfile value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasVoiceProfile() => $_has(1);
  @$pb.TagNumber(2)
  void clearVoiceProfile() => $_clearField(2);
  @$pb.TagNumber(2)
  VoiceProfile ensureVoiceProfile() => $_ensure(1);

  @$pb.TagNumber(3)
  EnrollmentMetadata get metadata => $_getN(2);
  @$pb.TagNumber(3)
  set metadata(EnrollmentMetadata value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMetadata() => $_has(2);
  @$pb.TagNumber(3)
  void clearMetadata() => $_clearField(3);
  @$pb.TagNumber(3)
  EnrollmentMetadata ensureMetadata() => $_ensure(2);
}

/// Voice profile
class VoiceProfile extends $pb.GeneratedMessage {
  factory VoiceProfile({
    $core.String? userId,
    $core.String? enrollmentId,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? updatedAt,
    $core.int? samplesCount,
    $core.double? qualityScore,
    $core.int? verificationCount,
    $fixnum.Int64? lastVerifiedAt,
    $core.String? customVoiceId,
    $core.String? customVoiceProvider,
    $core.String? customVoiceStatus,
    $fixnum.Int64? customVoiceCreatedAt,
    $core.String? customVoiceError,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (enrollmentId != null) result.enrollmentId = enrollmentId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (samplesCount != null) result.samplesCount = samplesCount;
    if (qualityScore != null) result.qualityScore = qualityScore;
    if (verificationCount != null) result.verificationCount = verificationCount;
    if (lastVerifiedAt != null) result.lastVerifiedAt = lastVerifiedAt;
    if (customVoiceId != null) result.customVoiceId = customVoiceId;
    if (customVoiceProvider != null)
      result.customVoiceProvider = customVoiceProvider;
    if (customVoiceStatus != null) result.customVoiceStatus = customVoiceStatus;
    if (customVoiceCreatedAt != null)
      result.customVoiceCreatedAt = customVoiceCreatedAt;
    if (customVoiceError != null) result.customVoiceError = customVoiceError;
    return result;
  }

  VoiceProfile._();

  factory VoiceProfile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VoiceProfile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VoiceProfile',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'enrollmentId')
    ..aInt64(3, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(4, _omitFieldNames ? '' : 'updatedAt')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'samplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'qualityScore', $pb.PbFieldType.OF)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'verificationCount', $pb.PbFieldType.O3)
    ..aInt64(8, _omitFieldNames ? '' : 'lastVerifiedAt')
    ..aOS(9, _omitFieldNames ? '' : 'customVoiceId')
    ..aOS(10, _omitFieldNames ? '' : 'customVoiceProvider')
    ..aOS(11, _omitFieldNames ? '' : 'customVoiceStatus')
    ..aInt64(12, _omitFieldNames ? '' : 'customVoiceCreatedAt')
    ..aOS(13, _omitFieldNames ? '' : 'customVoiceError')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VoiceProfile clone() => VoiceProfile()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VoiceProfile copyWith(void Function(VoiceProfile) updates) =>
      super.copyWith((message) => updates(message as VoiceProfile))
          as VoiceProfile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VoiceProfile create() => VoiceProfile._();
  @$core.override
  VoiceProfile createEmptyInstance() => create();
  static $pb.PbList<VoiceProfile> createRepeated() =>
      $pb.PbList<VoiceProfile>();
  @$core.pragma('dart2js:noInline')
  static VoiceProfile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VoiceProfile>(create);
  static VoiceProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get enrollmentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set enrollmentId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEnrollmentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnrollmentId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get createdAt => $_getI64(2);
  @$pb.TagNumber(3)
  set createdAt($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get updatedAt => $_getI64(3);
  @$pb.TagNumber(4)
  set updatedAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUpdatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpdatedAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get samplesCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set samplesCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSamplesCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearSamplesCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get qualityScore => $_getN(5);
  @$pb.TagNumber(6)
  set qualityScore($core.double value) => $_setFloat(5, value);
  @$pb.TagNumber(6)
  $core.bool hasQualityScore() => $_has(5);
  @$pb.TagNumber(6)
  void clearQualityScore() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get verificationCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set verificationCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerificationCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get lastVerifiedAt => $_getI64(7);
  @$pb.TagNumber(8)
  set lastVerifiedAt($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLastVerifiedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastVerifiedAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get customVoiceId => $_getSZ(8);
  @$pb.TagNumber(9)
  set customVoiceId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCustomVoiceId() => $_has(8);
  @$pb.TagNumber(9)
  void clearCustomVoiceId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get customVoiceProvider => $_getSZ(9);
  @$pb.TagNumber(10)
  set customVoiceProvider($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCustomVoiceProvider() => $_has(9);
  @$pb.TagNumber(10)
  void clearCustomVoiceProvider() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get customVoiceStatus => $_getSZ(10);
  @$pb.TagNumber(11)
  set customVoiceStatus($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCustomVoiceStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearCustomVoiceStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get customVoiceCreatedAt => $_getI64(11);
  @$pb.TagNumber(12)
  set customVoiceCreatedAt($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCustomVoiceCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCustomVoiceCreatedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get customVoiceError => $_getSZ(12);
  @$pb.TagNumber(13)
  set customVoiceError($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCustomVoiceError() => $_has(12);
  @$pb.TagNumber(13)
  void clearCustomVoiceError() => $_clearField(13);
}

/// Enrollment metadata
class EnrollmentMetadata extends $pb.GeneratedMessage {
  factory EnrollmentMetadata({
    $core.String? deviceInfo,
    $core.String? audioQuality,
    $core.Iterable<$core.String>? sampleIds,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? customFields,
  }) {
    final result = create();
    if (deviceInfo != null) result.deviceInfo = deviceInfo;
    if (audioQuality != null) result.audioQuality = audioQuality;
    if (sampleIds != null) result.sampleIds.addAll(sampleIds);
    if (customFields != null) result.customFields.addEntries(customFields);
    return result;
  }

  EnrollmentMetadata._();

  factory EnrollmentMetadata.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EnrollmentMetadata.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnrollmentMetadata',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceInfo')
    ..aOS(2, _omitFieldNames ? '' : 'audioQuality')
    ..pPS(3, _omitFieldNames ? '' : 'sampleIds')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'customFields',
        entryClassName: 'EnrollmentMetadata.CustomFieldsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('voicebiometrics'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnrollmentMetadata clone() => EnrollmentMetadata()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnrollmentMetadata copyWith(void Function(EnrollmentMetadata) updates) =>
      super.copyWith((message) => updates(message as EnrollmentMetadata))
          as EnrollmentMetadata;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnrollmentMetadata create() => EnrollmentMetadata._();
  @$core.override
  EnrollmentMetadata createEmptyInstance() => create();
  static $pb.PbList<EnrollmentMetadata> createRepeated() =>
      $pb.PbList<EnrollmentMetadata>();
  @$core.pragma('dart2js:noInline')
  static EnrollmentMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnrollmentMetadata>(create);
  static EnrollmentMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceInfo => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceInfo($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInfo() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get audioQuality => $_getSZ(1);
  @$pb.TagNumber(2)
  set audioQuality($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAudioQuality() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudioQuality() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get sampleIds => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get customFields => $_getMap(3);
}

/// Audio format
class AudioFormat extends $pb.GeneratedMessage {
  factory AudioFormat({
    $core.String? codec,
    $core.int? sampleRate,
    $core.int? channels,
    $core.int? bitDepth,
  }) {
    final result = create();
    if (codec != null) result.codec = codec;
    if (sampleRate != null) result.sampleRate = sampleRate;
    if (channels != null) result.channels = channels;
    if (bitDepth != null) result.bitDepth = bitDepth;
    return result;
  }

  AudioFormat._();

  factory AudioFormat.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioFormat.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioFormat',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'codec')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'sampleRate', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'bitDepth', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFormat clone() => AudioFormat()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFormat copyWith(void Function(AudioFormat) updates) =>
      super.copyWith((message) => updates(message as AudioFormat))
          as AudioFormat;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioFormat create() => AudioFormat._();
  @$core.override
  AudioFormat createEmptyInstance() => create();
  static $pb.PbList<AudioFormat> createRepeated() => $pb.PbList<AudioFormat>();
  @$core.pragma('dart2js:noInline')
  static AudioFormat getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioFormat>(create);
  static AudioFormat? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get codec => $_getSZ(0);
  @$pb.TagNumber(1)
  set codec($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCodec() => $_has(0);
  @$pb.TagNumber(1)
  void clearCodec() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get sampleRate => $_getIZ(1);
  @$pb.TagNumber(2)
  set sampleRate($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSampleRate() => $_has(1);
  @$pb.TagNumber(2)
  void clearSampleRate() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get channels => $_getIZ(2);
  @$pb.TagNumber(3)
  set channels($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChannels() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannels() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get bitDepth => $_getIZ(3);
  @$pb.TagNumber(4)
  set bitDepth($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBitDepth() => $_has(3);
  @$pb.TagNumber(4)
  void clearBitDepth() => $_clearField(4);
}

/// Custom voice cloning status
class GetCustomVoiceStatusRequest extends $pb.GeneratedMessage {
  factory GetCustomVoiceStatusRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetCustomVoiceStatusRequest._();

  factory GetCustomVoiceStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCustomVoiceStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCustomVoiceStatusRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomVoiceStatusRequest clone() =>
      GetCustomVoiceStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomVoiceStatusRequest copyWith(
          void Function(GetCustomVoiceStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCustomVoiceStatusRequest))
          as GetCustomVoiceStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCustomVoiceStatusRequest create() =>
      GetCustomVoiceStatusRequest._();
  @$core.override
  GetCustomVoiceStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetCustomVoiceStatusRequest> createRepeated() =>
      $pb.PbList<GetCustomVoiceStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCustomVoiceStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomVoiceStatusRequest>(create);
  static GetCustomVoiceStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class GetCustomVoiceStatusResponse extends $pb.GeneratedMessage {
  factory GetCustomVoiceStatusResponse({
    $core.bool? hasCustomVoice,
    $core.String? customVoiceId,
    $core.String? customVoiceProvider,
    $core.String? customVoiceStatus,
    $fixnum.Int64? customVoiceCreatedAt,
    $core.String? customVoiceError,
    $core.bool? enabled,
  }) {
    final result = create();
    if (hasCustomVoice != null) result.hasCustomVoice = hasCustomVoice;
    if (customVoiceId != null) result.customVoiceId = customVoiceId;
    if (customVoiceProvider != null)
      result.customVoiceProvider = customVoiceProvider;
    if (customVoiceStatus != null) result.customVoiceStatus = customVoiceStatus;
    if (customVoiceCreatedAt != null)
      result.customVoiceCreatedAt = customVoiceCreatedAt;
    if (customVoiceError != null) result.customVoiceError = customVoiceError;
    if (enabled != null) result.enabled = enabled;
    return result;
  }

  GetCustomVoiceStatusResponse._();

  factory GetCustomVoiceStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCustomVoiceStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCustomVoiceStatusResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'hasCustomVoice')
    ..aOS(2, _omitFieldNames ? '' : 'customVoiceId')
    ..aOS(3, _omitFieldNames ? '' : 'customVoiceProvider')
    ..aOS(4, _omitFieldNames ? '' : 'customVoiceStatus')
    ..aInt64(5, _omitFieldNames ? '' : 'customVoiceCreatedAt')
    ..aOS(6, _omitFieldNames ? '' : 'customVoiceError')
    ..aOB(7, _omitFieldNames ? '' : 'enabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomVoiceStatusResponse clone() =>
      GetCustomVoiceStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomVoiceStatusResponse copyWith(
          void Function(GetCustomVoiceStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCustomVoiceStatusResponse))
          as GetCustomVoiceStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCustomVoiceStatusResponse create() =>
      GetCustomVoiceStatusResponse._();
  @$core.override
  GetCustomVoiceStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetCustomVoiceStatusResponse> createRepeated() =>
      $pb.PbList<GetCustomVoiceStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCustomVoiceStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomVoiceStatusResponse>(create);
  static GetCustomVoiceStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get hasCustomVoice => $_getBF(0);
  @$pb.TagNumber(1)
  set hasCustomVoice($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHasCustomVoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearHasCustomVoice() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get customVoiceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set customVoiceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCustomVoiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomVoiceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get customVoiceProvider => $_getSZ(2);
  @$pb.TagNumber(3)
  set customVoiceProvider($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCustomVoiceProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomVoiceProvider() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get customVoiceStatus => $_getSZ(3);
  @$pb.TagNumber(4)
  set customVoiceStatus($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCustomVoiceStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearCustomVoiceStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get customVoiceCreatedAt => $_getI64(4);
  @$pb.TagNumber(5)
  set customVoiceCreatedAt($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCustomVoiceCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCustomVoiceCreatedAt() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get customVoiceError => $_getSZ(5);
  @$pb.TagNumber(6)
  set customVoiceError($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCustomVoiceError() => $_has(5);
  @$pb.TagNumber(6)
  void clearCustomVoiceError() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get enabled => $_getBF(6);
  @$pb.TagNumber(7)
  set enabled($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEnabled() => $_has(6);
  @$pb.TagNumber(7)
  void clearEnabled() => $_clearField(7);
}

/// Enable/disable custom voice
class SetCustomVoiceEnabledRequest extends $pb.GeneratedMessage {
  factory SetCustomVoiceEnabledRequest({
    $core.String? userId,
    $core.bool? enabled,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (enabled != null) result.enabled = enabled;
    return result;
  }

  SetCustomVoiceEnabledRequest._();

  factory SetCustomVoiceEnabledRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetCustomVoiceEnabledRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetCustomVoiceEnabledRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOB(2, _omitFieldNames ? '' : 'enabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetCustomVoiceEnabledRequest clone() =>
      SetCustomVoiceEnabledRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetCustomVoiceEnabledRequest copyWith(
          void Function(SetCustomVoiceEnabledRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SetCustomVoiceEnabledRequest))
          as SetCustomVoiceEnabledRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetCustomVoiceEnabledRequest create() =>
      SetCustomVoiceEnabledRequest._();
  @$core.override
  SetCustomVoiceEnabledRequest createEmptyInstance() => create();
  static $pb.PbList<SetCustomVoiceEnabledRequest> createRepeated() =>
      $pb.PbList<SetCustomVoiceEnabledRequest>();
  @$core.pragma('dart2js:noInline')
  static SetCustomVoiceEnabledRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetCustomVoiceEnabledRequest>(create);
  static SetCustomVoiceEnabledRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get enabled => $_getBF(1);
  @$pb.TagNumber(2)
  set enabled($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEnabled() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnabled() => $_clearField(2);
}

class SetCustomVoiceEnabledResponse extends $pb.GeneratedMessage {
  factory SetCustomVoiceEnabledResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? customVoiceStatus,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (customVoiceStatus != null) result.customVoiceStatus = customVoiceStatus;
    return result;
  }

  SetCustomVoiceEnabledResponse._();

  factory SetCustomVoiceEnabledResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetCustomVoiceEnabledResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetCustomVoiceEnabledResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'customVoiceStatus')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetCustomVoiceEnabledResponse clone() =>
      SetCustomVoiceEnabledResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetCustomVoiceEnabledResponse copyWith(
          void Function(SetCustomVoiceEnabledResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SetCustomVoiceEnabledResponse))
          as SetCustomVoiceEnabledResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetCustomVoiceEnabledResponse create() =>
      SetCustomVoiceEnabledResponse._();
  @$core.override
  SetCustomVoiceEnabledResponse createEmptyInstance() => create();
  static $pb.PbList<SetCustomVoiceEnabledResponse> createRepeated() =>
      $pb.PbList<SetCustomVoiceEnabledResponse>();
  @$core.pragma('dart2js:noInline')
  static SetCustomVoiceEnabledResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetCustomVoiceEnabledResponse>(create);
  static SetCustomVoiceEnabledResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get customVoiceStatus => $_getSZ(2);
  @$pb.TagNumber(3)
  set customVoiceStatus($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCustomVoiceStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomVoiceStatus() => $_clearField(3);
}

/// Re-trigger voice cloning
class RetriggerVoiceCloningRequest extends $pb.GeneratedMessage {
  factory RetriggerVoiceCloningRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  RetriggerVoiceCloningRequest._();

  factory RetriggerVoiceCloningRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RetriggerVoiceCloningRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RetriggerVoiceCloningRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetriggerVoiceCloningRequest clone() =>
      RetriggerVoiceCloningRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetriggerVoiceCloningRequest copyWith(
          void Function(RetriggerVoiceCloningRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RetriggerVoiceCloningRequest))
          as RetriggerVoiceCloningRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RetriggerVoiceCloningRequest create() =>
      RetriggerVoiceCloningRequest._();
  @$core.override
  RetriggerVoiceCloningRequest createEmptyInstance() => create();
  static $pb.PbList<RetriggerVoiceCloningRequest> createRepeated() =>
      $pb.PbList<RetriggerVoiceCloningRequest>();
  @$core.pragma('dart2js:noInline')
  static RetriggerVoiceCloningRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RetriggerVoiceCloningRequest>(create);
  static RetriggerVoiceCloningRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class RetriggerVoiceCloningResponse extends $pb.GeneratedMessage {
  factory RetriggerVoiceCloningResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? customVoiceStatus,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (customVoiceStatus != null) result.customVoiceStatus = customVoiceStatus;
    return result;
  }

  RetriggerVoiceCloningResponse._();

  factory RetriggerVoiceCloningResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RetriggerVoiceCloningResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RetriggerVoiceCloningResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'customVoiceStatus')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetriggerVoiceCloningResponse clone() =>
      RetriggerVoiceCloningResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetriggerVoiceCloningResponse copyWith(
          void Function(RetriggerVoiceCloningResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RetriggerVoiceCloningResponse))
          as RetriggerVoiceCloningResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RetriggerVoiceCloningResponse create() =>
      RetriggerVoiceCloningResponse._();
  @$core.override
  RetriggerVoiceCloningResponse createEmptyInstance() => create();
  static $pb.PbList<RetriggerVoiceCloningResponse> createRepeated() =>
      $pb.PbList<RetriggerVoiceCloningResponse>();
  @$core.pragma('dart2js:noInline')
  static RetriggerVoiceCloningResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RetriggerVoiceCloningResponse>(create);
  static RetriggerVoiceCloningResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get customVoiceStatus => $_getSZ(2);
  @$pb.TagNumber(3)
  set customVoiceStatus($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCustomVoiceStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomVoiceStatus() => $_clearField(3);
}

/// Update cloning status (called by voice-agent-gateway after provider cloning)
class UpdateCloningStatusRequest extends $pb.GeneratedMessage {
  factory UpdateCloningStatusRequest({
    $core.String? userId,
    $core.String? voiceId,
    $core.String? provider,
    $core.String? status,
    $core.String? error,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (voiceId != null) result.voiceId = voiceId;
    if (provider != null) result.provider = provider;
    if (status != null) result.status = status;
    if (error != null) result.error = error;
    return result;
  }

  UpdateCloningStatusRequest._();

  factory UpdateCloningStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCloningStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCloningStatusRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'voiceId')
    ..aOS(3, _omitFieldNames ? '' : 'provider')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCloningStatusRequest clone() =>
      UpdateCloningStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCloningStatusRequest copyWith(
          void Function(UpdateCloningStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateCloningStatusRequest))
          as UpdateCloningStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCloningStatusRequest create() => UpdateCloningStatusRequest._();
  @$core.override
  UpdateCloningStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateCloningStatusRequest> createRepeated() =>
      $pb.PbList<UpdateCloningStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateCloningStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCloningStatusRequest>(create);
  static UpdateCloningStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get voiceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set voiceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVoiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVoiceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get provider => $_getSZ(2);
  @$pb.TagNumber(3)
  set provider($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearProvider() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get error => $_getSZ(4);
  @$pb.TagNumber(5)
  set error($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasError() => $_has(4);
  @$pb.TagNumber(5)
  void clearError() => $_clearField(5);
}

class UpdateCloningStatusResponse extends $pb.GeneratedMessage {
  factory UpdateCloningStatusResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? customVoiceStatus,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (customVoiceStatus != null) result.customVoiceStatus = customVoiceStatus;
    return result;
  }

  UpdateCloningStatusResponse._();

  factory UpdateCloningStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCloningStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCloningStatusResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'customVoiceStatus')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCloningStatusResponse clone() =>
      UpdateCloningStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCloningStatusResponse copyWith(
          void Function(UpdateCloningStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateCloningStatusResponse))
          as UpdateCloningStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCloningStatusResponse create() =>
      UpdateCloningStatusResponse._();
  @$core.override
  UpdateCloningStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateCloningStatusResponse> createRepeated() =>
      $pb.PbList<UpdateCloningStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateCloningStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCloningStatusResponse>(create);
  static UpdateCloningStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get customVoiceStatus => $_getSZ(2);
  @$pb.TagNumber(3)
  set customVoiceStatus($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCustomVoiceStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomVoiceStatus() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
