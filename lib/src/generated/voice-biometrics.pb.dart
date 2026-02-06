//
//  Generated code. Do not modify.
//  source: voice-biometrics.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'voice-biometrics.pbenum.dart';

export 'voice-biometrics.pbenum.dart';

/// Enroll voice request
class EnrollVoiceRequest extends $pb.GeneratedMessage {
  factory EnrollVoiceRequest({
    $core.String? userId,
    $core.Iterable<$core.List<$core.int>>? audioSamples,
    AudioFormat? format,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (audioSamples != null) {
      $result.audioSamples.addAll(audioSamples);
    }
    if (format != null) {
      $result.format = format;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  EnrollVoiceRequest._() : super();
  factory EnrollVoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnrollVoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EnrollVoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..p<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'audioSamples', $pb.PbFieldType.PY)
    ..aOM<AudioFormat>(3, _omitFieldNames ? '' : 'format', subBuilder: AudioFormat.create)
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'metadata', entryClassName: 'EnrollVoiceRequest.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('voicebiometrics'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnrollVoiceRequest clone() => EnrollVoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnrollVoiceRequest copyWith(void Function(EnrollVoiceRequest) updates) => super.copyWith((message) => updates(message as EnrollVoiceRequest)) as EnrollVoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnrollVoiceRequest create() => EnrollVoiceRequest._();
  EnrollVoiceRequest createEmptyInstance() => create();
  static $pb.PbList<EnrollVoiceRequest> createRepeated() => $pb.PbList<EnrollVoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static EnrollVoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnrollVoiceRequest>(create);
  static EnrollVoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.List<$core.int>> get audioSamples => $_getList(1);

  @$pb.TagNumber(3)
  AudioFormat get format => $_getN(2);
  @$pb.TagNumber(3)
  set format(AudioFormat v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFormat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFormat() => clearField(3);
  @$pb.TagNumber(3)
  AudioFormat ensureFormat() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);
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
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (enrollmentId != null) {
      $result.enrollmentId = enrollmentId;
    }
    if (samplesCount != null) {
      $result.samplesCount = samplesCount;
    }
    if (qualityScore != null) {
      $result.qualityScore = qualityScore;
    }
    if (message != null) {
      $result.message = message;
    }
    if (voiceProfile != null) {
      $result.voiceProfile = voiceProfile;
    }
    return $result;
  }
  EnrollVoiceResponse._() : super();
  factory EnrollVoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnrollVoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EnrollVoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'enrollmentId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'samplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'qualityScore', $pb.PbFieldType.OF)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..aOM<VoiceProfile>(6, _omitFieldNames ? '' : 'voiceProfile', subBuilder: VoiceProfile.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnrollVoiceResponse clone() => EnrollVoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnrollVoiceResponse copyWith(void Function(EnrollVoiceResponse) updates) => super.copyWith((message) => updates(message as EnrollVoiceResponse)) as EnrollVoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnrollVoiceResponse create() => EnrollVoiceResponse._();
  EnrollVoiceResponse createEmptyInstance() => create();
  static $pb.PbList<EnrollVoiceResponse> createRepeated() => $pb.PbList<EnrollVoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static EnrollVoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnrollVoiceResponse>(create);
  static EnrollVoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get enrollmentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set enrollmentId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnrollmentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnrollmentId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get samplesCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set samplesCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSamplesCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearSamplesCount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get qualityScore => $_getN(3);
  @$pb.TagNumber(4)
  set qualityScore($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasQualityScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearQualityScore() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);

  @$pb.TagNumber(6)
  VoiceProfile get voiceProfile => $_getN(5);
  @$pb.TagNumber(6)
  set voiceProfile(VoiceProfile v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVoiceProfile() => $_has(5);
  @$pb.TagNumber(6)
  void clearVoiceProfile() => clearField(6);
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
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (audioSample != null) {
      $result.audioSample = audioSample;
    }
    if (format != null) {
      $result.format = format;
    }
    if (threshold != null) {
      $result.threshold = threshold;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  VerifyVoiceRequest._() : super();
  factory VerifyVoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyVoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyVoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'audioSample', $pb.PbFieldType.OY)
    ..aOM<AudioFormat>(3, _omitFieldNames ? '' : 'format', subBuilder: AudioFormat.create)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'threshold', $pb.PbFieldType.OF)
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'metadata', entryClassName: 'VerifyVoiceRequest.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('voicebiometrics'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyVoiceRequest clone() => VerifyVoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyVoiceRequest copyWith(void Function(VerifyVoiceRequest) updates) => super.copyWith((message) => updates(message as VerifyVoiceRequest)) as VerifyVoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyVoiceRequest create() => VerifyVoiceRequest._();
  VerifyVoiceRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyVoiceRequest> createRepeated() => $pb.PbList<VerifyVoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyVoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyVoiceRequest>(create);
  static VerifyVoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get audioSample => $_getN(1);
  @$pb.TagNumber(2)
  set audioSample($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAudioSample() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudioSample() => clearField(2);

  @$pb.TagNumber(3)
  AudioFormat get format => $_getN(2);
  @$pb.TagNumber(3)
  set format(AudioFormat v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFormat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFormat() => clearField(3);
  @$pb.TagNumber(3)
  AudioFormat ensureFormat() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get threshold => $_getN(3);
  @$pb.TagNumber(4)
  set threshold($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasThreshold() => $_has(3);
  @$pb.TagNumber(4)
  void clearThreshold() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(4);
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
    final $result = create();
    if (verified != null) {
      $result.verified = verified;
    }
    if (similarityScore != null) {
      $result.similarityScore = similarityScore;
    }
    if (confidence != null) {
      $result.confidence = confidence;
    }
    if (message != null) {
      $result.message = message;
    }
    if (status != null) {
      $result.status = status;
    }
    if (verificationTimestamp != null) {
      $result.verificationTimestamp = verificationTimestamp;
    }
    return $result;
  }
  VerifyVoiceResponse._() : super();
  factory VerifyVoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyVoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyVoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'verified')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'similarityScore', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'confidence', $pb.PbFieldType.OF)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..e<VerificationStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: VerificationStatus.VERIFICATION_UNKNOWN, valueOf: VerificationStatus.valueOf, enumValues: VerificationStatus.values)
    ..aInt64(6, _omitFieldNames ? '' : 'verificationTimestamp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyVoiceResponse clone() => VerifyVoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyVoiceResponse copyWith(void Function(VerifyVoiceResponse) updates) => super.copyWith((message) => updates(message as VerifyVoiceResponse)) as VerifyVoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyVoiceResponse create() => VerifyVoiceResponse._();
  VerifyVoiceResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyVoiceResponse> createRepeated() => $pb.PbList<VerifyVoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyVoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyVoiceResponse>(create);
  static VerifyVoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get verified => $_getBF(0);
  @$pb.TagNumber(1)
  set verified($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVerified() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerified() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get similarityScore => $_getN(1);
  @$pb.TagNumber(2)
  set similarityScore($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSimilarityScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearSimilarityScore() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get confidence => $_getN(2);
  @$pb.TagNumber(3)
  set confidence($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfidence() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfidence() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);

  @$pb.TagNumber(5)
  VerificationStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(VerificationStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get verificationTimestamp => $_getI64(5);
  @$pb.TagNumber(6)
  set verificationTimestamp($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerificationTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationTimestamp() => clearField(6);
}

/// Check enrollment status
class CheckEnrollmentStatusRequest extends $pb.GeneratedMessage {
  factory CheckEnrollmentStatusRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  CheckEnrollmentStatusRequest._() : super();
  factory CheckEnrollmentStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckEnrollmentStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckEnrollmentStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckEnrollmentStatusRequest clone() => CheckEnrollmentStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckEnrollmentStatusRequest copyWith(void Function(CheckEnrollmentStatusRequest) updates) => super.copyWith((message) => updates(message as CheckEnrollmentStatusRequest)) as CheckEnrollmentStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckEnrollmentStatusRequest create() => CheckEnrollmentStatusRequest._();
  CheckEnrollmentStatusRequest createEmptyInstance() => create();
  static $pb.PbList<CheckEnrollmentStatusRequest> createRepeated() => $pb.PbList<CheckEnrollmentStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckEnrollmentStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckEnrollmentStatusRequest>(create);
  static CheckEnrollmentStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
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
    final $result = create();
    if (isEnrolled != null) {
      $result.isEnrolled = isEnrolled;
    }
    if (enrollmentId != null) {
      $result.enrollmentId = enrollmentId;
    }
    if (enrolledAt != null) {
      $result.enrolledAt = enrolledAt;
    }
    if (samplesCount != null) {
      $result.samplesCount = samplesCount;
    }
    if (qualityScore != null) {
      $result.qualityScore = qualityScore;
    }
    if (voiceProfile != null) {
      $result.voiceProfile = voiceProfile;
    }
    return $result;
  }
  CheckEnrollmentStatusResponse._() : super();
  factory CheckEnrollmentStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckEnrollmentStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckEnrollmentStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isEnrolled')
    ..aOS(2, _omitFieldNames ? '' : 'enrollmentId')
    ..aInt64(3, _omitFieldNames ? '' : 'enrolledAt')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'samplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'qualityScore', $pb.PbFieldType.OF)
    ..aOM<VoiceProfile>(6, _omitFieldNames ? '' : 'voiceProfile', subBuilder: VoiceProfile.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckEnrollmentStatusResponse clone() => CheckEnrollmentStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckEnrollmentStatusResponse copyWith(void Function(CheckEnrollmentStatusResponse) updates) => super.copyWith((message) => updates(message as CheckEnrollmentStatusResponse)) as CheckEnrollmentStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckEnrollmentStatusResponse create() => CheckEnrollmentStatusResponse._();
  CheckEnrollmentStatusResponse createEmptyInstance() => create();
  static $pb.PbList<CheckEnrollmentStatusResponse> createRepeated() => $pb.PbList<CheckEnrollmentStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckEnrollmentStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckEnrollmentStatusResponse>(create);
  static CheckEnrollmentStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isEnrolled => $_getBF(0);
  @$pb.TagNumber(1)
  set isEnrolled($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsEnrolled() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsEnrolled() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get enrollmentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set enrollmentId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnrollmentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnrollmentId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get enrolledAt => $_getI64(2);
  @$pb.TagNumber(3)
  set enrolledAt($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEnrolledAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearEnrolledAt() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get samplesCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set samplesCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSamplesCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearSamplesCount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get qualityScore => $_getN(4);
  @$pb.TagNumber(5)
  set qualityScore($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasQualityScore() => $_has(4);
  @$pb.TagNumber(5)
  void clearQualityScore() => clearField(5);

  @$pb.TagNumber(6)
  VoiceProfile get voiceProfile => $_getN(5);
  @$pb.TagNumber(6)
  set voiceProfile(VoiceProfile v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVoiceProfile() => $_has(5);
  @$pb.TagNumber(6)
  void clearVoiceProfile() => clearField(6);
  @$pb.TagNumber(6)
  VoiceProfile ensureVoiceProfile() => $_ensure(5);
}

/// Delete enrollment
class DeleteVoiceEnrollmentRequest extends $pb.GeneratedMessage {
  factory DeleteVoiceEnrollmentRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  DeleteVoiceEnrollmentRequest._() : super();
  factory DeleteVoiceEnrollmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteVoiceEnrollmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteVoiceEnrollmentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteVoiceEnrollmentRequest clone() => DeleteVoiceEnrollmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteVoiceEnrollmentRequest copyWith(void Function(DeleteVoiceEnrollmentRequest) updates) => super.copyWith((message) => updates(message as DeleteVoiceEnrollmentRequest)) as DeleteVoiceEnrollmentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteVoiceEnrollmentRequest create() => DeleteVoiceEnrollmentRequest._();
  DeleteVoiceEnrollmentRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteVoiceEnrollmentRequest> createRepeated() => $pb.PbList<DeleteVoiceEnrollmentRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteVoiceEnrollmentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteVoiceEnrollmentRequest>(create);
  static DeleteVoiceEnrollmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class DeleteVoiceEnrollmentResponse extends $pb.GeneratedMessage {
  factory DeleteVoiceEnrollmentResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  DeleteVoiceEnrollmentResponse._() : super();
  factory DeleteVoiceEnrollmentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteVoiceEnrollmentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteVoiceEnrollmentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteVoiceEnrollmentResponse clone() => DeleteVoiceEnrollmentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteVoiceEnrollmentResponse copyWith(void Function(DeleteVoiceEnrollmentResponse) updates) => super.copyWith((message) => updates(message as DeleteVoiceEnrollmentResponse)) as DeleteVoiceEnrollmentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteVoiceEnrollmentResponse create() => DeleteVoiceEnrollmentResponse._();
  DeleteVoiceEnrollmentResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteVoiceEnrollmentResponse> createRepeated() => $pb.PbList<DeleteVoiceEnrollmentResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteVoiceEnrollmentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteVoiceEnrollmentResponse>(create);
  static DeleteVoiceEnrollmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// Update enrollment
class UpdateVoiceEnrollmentRequest extends $pb.GeneratedMessage {
  factory UpdateVoiceEnrollmentRequest({
    $core.String? userId,
    $core.Iterable<$core.List<$core.int>>? audioSamples,
    AudioFormat? format,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (audioSamples != null) {
      $result.audioSamples.addAll(audioSamples);
    }
    if (format != null) {
      $result.format = format;
    }
    return $result;
  }
  UpdateVoiceEnrollmentRequest._() : super();
  factory UpdateVoiceEnrollmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateVoiceEnrollmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateVoiceEnrollmentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..p<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'audioSamples', $pb.PbFieldType.PY)
    ..aOM<AudioFormat>(3, _omitFieldNames ? '' : 'format', subBuilder: AudioFormat.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateVoiceEnrollmentRequest clone() => UpdateVoiceEnrollmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateVoiceEnrollmentRequest copyWith(void Function(UpdateVoiceEnrollmentRequest) updates) => super.copyWith((message) => updates(message as UpdateVoiceEnrollmentRequest)) as UpdateVoiceEnrollmentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateVoiceEnrollmentRequest create() => UpdateVoiceEnrollmentRequest._();
  UpdateVoiceEnrollmentRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateVoiceEnrollmentRequest> createRepeated() => $pb.PbList<UpdateVoiceEnrollmentRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateVoiceEnrollmentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateVoiceEnrollmentRequest>(create);
  static UpdateVoiceEnrollmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.List<$core.int>> get audioSamples => $_getList(1);

  @$pb.TagNumber(3)
  AudioFormat get format => $_getN(2);
  @$pb.TagNumber(3)
  set format(AudioFormat v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFormat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFormat() => clearField(3);
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
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (newSamplesCount != null) {
      $result.newSamplesCount = newSamplesCount;
    }
    if (updatedQualityScore != null) {
      $result.updatedQualityScore = updatedQualityScore;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateVoiceEnrollmentResponse._() : super();
  factory UpdateVoiceEnrollmentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateVoiceEnrollmentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateVoiceEnrollmentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'newSamplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'updatedQualityScore', $pb.PbFieldType.OF)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateVoiceEnrollmentResponse clone() => UpdateVoiceEnrollmentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateVoiceEnrollmentResponse copyWith(void Function(UpdateVoiceEnrollmentResponse) updates) => super.copyWith((message) => updates(message as UpdateVoiceEnrollmentResponse)) as UpdateVoiceEnrollmentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateVoiceEnrollmentResponse create() => UpdateVoiceEnrollmentResponse._();
  UpdateVoiceEnrollmentResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateVoiceEnrollmentResponse> createRepeated() => $pb.PbList<UpdateVoiceEnrollmentResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateVoiceEnrollmentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateVoiceEnrollmentResponse>(create);
  static UpdateVoiceEnrollmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get newSamplesCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set newSamplesCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewSamplesCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewSamplesCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get updatedQualityScore => $_getN(2);
  @$pb.TagNumber(3)
  set updatedQualityScore($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpdatedQualityScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedQualityScore() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

/// Get enrollment details
class GetVoiceEnrollmentRequest extends $pb.GeneratedMessage {
  factory GetVoiceEnrollmentRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GetVoiceEnrollmentRequest._() : super();
  factory GetVoiceEnrollmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVoiceEnrollmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVoiceEnrollmentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVoiceEnrollmentRequest clone() => GetVoiceEnrollmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVoiceEnrollmentRequest copyWith(void Function(GetVoiceEnrollmentRequest) updates) => super.copyWith((message) => updates(message as GetVoiceEnrollmentRequest)) as GetVoiceEnrollmentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVoiceEnrollmentRequest create() => GetVoiceEnrollmentRequest._();
  GetVoiceEnrollmentRequest createEmptyInstance() => create();
  static $pb.PbList<GetVoiceEnrollmentRequest> createRepeated() => $pb.PbList<GetVoiceEnrollmentRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVoiceEnrollmentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVoiceEnrollmentRequest>(create);
  static GetVoiceEnrollmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GetVoiceEnrollmentResponse extends $pb.GeneratedMessage {
  factory GetVoiceEnrollmentResponse({
    $core.bool? exists,
    VoiceProfile? voiceProfile,
    EnrollmentMetadata? metadata,
  }) {
    final $result = create();
    if (exists != null) {
      $result.exists = exists;
    }
    if (voiceProfile != null) {
      $result.voiceProfile = voiceProfile;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    return $result;
  }
  GetVoiceEnrollmentResponse._() : super();
  factory GetVoiceEnrollmentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVoiceEnrollmentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVoiceEnrollmentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'exists')
    ..aOM<VoiceProfile>(2, _omitFieldNames ? '' : 'voiceProfile', subBuilder: VoiceProfile.create)
    ..aOM<EnrollmentMetadata>(3, _omitFieldNames ? '' : 'metadata', subBuilder: EnrollmentMetadata.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVoiceEnrollmentResponse clone() => GetVoiceEnrollmentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVoiceEnrollmentResponse copyWith(void Function(GetVoiceEnrollmentResponse) updates) => super.copyWith((message) => updates(message as GetVoiceEnrollmentResponse)) as GetVoiceEnrollmentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVoiceEnrollmentResponse create() => GetVoiceEnrollmentResponse._();
  GetVoiceEnrollmentResponse createEmptyInstance() => create();
  static $pb.PbList<GetVoiceEnrollmentResponse> createRepeated() => $pb.PbList<GetVoiceEnrollmentResponse>();
  @$core.pragma('dart2js:noInline')
  static GetVoiceEnrollmentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVoiceEnrollmentResponse>(create);
  static GetVoiceEnrollmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get exists => $_getBF(0);
  @$pb.TagNumber(1)
  set exists($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasExists() => $_has(0);
  @$pb.TagNumber(1)
  void clearExists() => clearField(1);

  @$pb.TagNumber(2)
  VoiceProfile get voiceProfile => $_getN(1);
  @$pb.TagNumber(2)
  set voiceProfile(VoiceProfile v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasVoiceProfile() => $_has(1);
  @$pb.TagNumber(2)
  void clearVoiceProfile() => clearField(2);
  @$pb.TagNumber(2)
  VoiceProfile ensureVoiceProfile() => $_ensure(1);

  @$pb.TagNumber(3)
  EnrollmentMetadata get metadata => $_getN(2);
  @$pb.TagNumber(3)
  set metadata(EnrollmentMetadata v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMetadata() => $_has(2);
  @$pb.TagNumber(3)
  void clearMetadata() => clearField(3);
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
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (enrollmentId != null) {
      $result.enrollmentId = enrollmentId;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (samplesCount != null) {
      $result.samplesCount = samplesCount;
    }
    if (qualityScore != null) {
      $result.qualityScore = qualityScore;
    }
    if (verificationCount != null) {
      $result.verificationCount = verificationCount;
    }
    if (lastVerifiedAt != null) {
      $result.lastVerifiedAt = lastVerifiedAt;
    }
    return $result;
  }
  VoiceProfile._() : super();
  factory VoiceProfile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VoiceProfile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VoiceProfile', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'enrollmentId')
    ..aInt64(3, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(4, _omitFieldNames ? '' : 'updatedAt')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'samplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'qualityScore', $pb.PbFieldType.OF)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'verificationCount', $pb.PbFieldType.O3)
    ..aInt64(8, _omitFieldNames ? '' : 'lastVerifiedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VoiceProfile clone() => VoiceProfile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VoiceProfile copyWith(void Function(VoiceProfile) updates) => super.copyWith((message) => updates(message as VoiceProfile)) as VoiceProfile;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VoiceProfile create() => VoiceProfile._();
  VoiceProfile createEmptyInstance() => create();
  static $pb.PbList<VoiceProfile> createRepeated() => $pb.PbList<VoiceProfile>();
  @$core.pragma('dart2js:noInline')
  static VoiceProfile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VoiceProfile>(create);
  static VoiceProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get enrollmentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set enrollmentId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnrollmentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnrollmentId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get createdAt => $_getI64(2);
  @$pb.TagNumber(3)
  set createdAt($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get updatedAt => $_getI64(3);
  @$pb.TagNumber(4)
  set updatedAt($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUpdatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpdatedAt() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get samplesCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set samplesCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSamplesCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearSamplesCount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get qualityScore => $_getN(5);
  @$pb.TagNumber(6)
  set qualityScore($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasQualityScore() => $_has(5);
  @$pb.TagNumber(6)
  void clearQualityScore() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get verificationCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set verificationCount($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerificationCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationCount() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get lastVerifiedAt => $_getI64(7);
  @$pb.TagNumber(8)
  set lastVerifiedAt($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastVerifiedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastVerifiedAt() => clearField(8);
}

/// Enrollment metadata
class EnrollmentMetadata extends $pb.GeneratedMessage {
  factory EnrollmentMetadata({
    $core.String? deviceInfo,
    $core.String? audioQuality,
    $core.Iterable<$core.String>? sampleIds,
    $core.Map<$core.String, $core.String>? customFields,
  }) {
    final $result = create();
    if (deviceInfo != null) {
      $result.deviceInfo = deviceInfo;
    }
    if (audioQuality != null) {
      $result.audioQuality = audioQuality;
    }
    if (sampleIds != null) {
      $result.sampleIds.addAll(sampleIds);
    }
    if (customFields != null) {
      $result.customFields.addAll(customFields);
    }
    return $result;
  }
  EnrollmentMetadata._() : super();
  factory EnrollmentMetadata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnrollmentMetadata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EnrollmentMetadata', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceInfo')
    ..aOS(2, _omitFieldNames ? '' : 'audioQuality')
    ..pPS(3, _omitFieldNames ? '' : 'sampleIds')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'customFields', entryClassName: 'EnrollmentMetadata.CustomFieldsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('voicebiometrics'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnrollmentMetadata clone() => EnrollmentMetadata()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnrollmentMetadata copyWith(void Function(EnrollmentMetadata) updates) => super.copyWith((message) => updates(message as EnrollmentMetadata)) as EnrollmentMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnrollmentMetadata create() => EnrollmentMetadata._();
  EnrollmentMetadata createEmptyInstance() => create();
  static $pb.PbList<EnrollmentMetadata> createRepeated() => $pb.PbList<EnrollmentMetadata>();
  @$core.pragma('dart2js:noInline')
  static EnrollmentMetadata getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnrollmentMetadata>(create);
  static EnrollmentMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceInfo => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceInfo($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInfo() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get audioQuality => $_getSZ(1);
  @$pb.TagNumber(2)
  set audioQuality($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAudioQuality() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudioQuality() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get sampleIds => $_getList(2);

  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get customFields => $_getMap(3);
}

/// Audio format
class AudioFormat extends $pb.GeneratedMessage {
  factory AudioFormat({
    $core.String? codec,
    $core.int? sampleRate,
    $core.int? channels,
    $core.int? bitDepth,
  }) {
    final $result = create();
    if (codec != null) {
      $result.codec = codec;
    }
    if (sampleRate != null) {
      $result.sampleRate = sampleRate;
    }
    if (channels != null) {
      $result.channels = channels;
    }
    if (bitDepth != null) {
      $result.bitDepth = bitDepth;
    }
    return $result;
  }
  AudioFormat._() : super();
  factory AudioFormat.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AudioFormat.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AudioFormat', package: const $pb.PackageName(_omitMessageNames ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'codec')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'sampleRate', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'bitDepth', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AudioFormat clone() => AudioFormat()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AudioFormat copyWith(void Function(AudioFormat) updates) => super.copyWith((message) => updates(message as AudioFormat)) as AudioFormat;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioFormat create() => AudioFormat._();
  AudioFormat createEmptyInstance() => create();
  static $pb.PbList<AudioFormat> createRepeated() => $pb.PbList<AudioFormat>();
  @$core.pragma('dart2js:noInline')
  static AudioFormat getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AudioFormat>(create);
  static AudioFormat? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get codec => $_getSZ(0);
  @$pb.TagNumber(1)
  set codec($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCodec() => $_has(0);
  @$pb.TagNumber(1)
  void clearCodec() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get sampleRate => $_getIZ(1);
  @$pb.TagNumber(2)
  set sampleRate($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSampleRate() => $_has(1);
  @$pb.TagNumber(2)
  void clearSampleRate() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get channels => $_getIZ(2);
  @$pb.TagNumber(3)
  set channels($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannels() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannels() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get bitDepth => $_getIZ(3);
  @$pb.TagNumber(4)
  set bitDepth($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBitDepth() => $_has(3);
  @$pb.TagNumber(4)
  void clearBitDepth() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
