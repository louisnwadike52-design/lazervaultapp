///
//  Generated code. Do not modify.
//  source: voice-biometrics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'voice-biometrics.pbenum.dart';

export 'voice-biometrics.pbenum.dart';

class EnrollVoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EnrollVoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..p<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioSamples', $pb.PbFieldType.PY)
    ..aOM<AudioFormat>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'format', subBuilder: AudioFormat.create)
    ..m<$core.String, $core.String>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'EnrollVoiceRequest.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('voicebiometrics'))
    ..hasRequiredFields = false
  ;

  EnrollVoiceRequest._() : super();
  factory EnrollVoiceRequest({
    $core.String? userId,
    $core.Iterable<$core.List<$core.int>>? audioSamples,
    AudioFormat? format,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (audioSamples != null) {
      _result.audioSamples.addAll(audioSamples);
    }
    if (format != null) {
      _result.format = format;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    return _result;
  }
  factory EnrollVoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnrollVoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnrollVoiceRequest clone() => EnrollVoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnrollVoiceRequest copyWith(void Function(EnrollVoiceRequest) updates) => super.copyWith((message) => updates(message as EnrollVoiceRequest)) as EnrollVoiceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EnrollVoiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enrollmentId')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'samplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'qualityScore', $pb.PbFieldType.OF)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<VoiceProfile>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'voiceProfile', subBuilder: VoiceProfile.create)
    ..hasRequiredFields = false
  ;

  EnrollVoiceResponse._() : super();
  factory EnrollVoiceResponse({
    $core.bool? success,
    $core.String? enrollmentId,
    $core.int? samplesCount,
    $core.double? qualityScore,
    $core.String? message,
    VoiceProfile? voiceProfile,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (enrollmentId != null) {
      _result.enrollmentId = enrollmentId;
    }
    if (samplesCount != null) {
      _result.samplesCount = samplesCount;
    }
    if (qualityScore != null) {
      _result.qualityScore = qualityScore;
    }
    if (message != null) {
      _result.message = message;
    }
    if (voiceProfile != null) {
      _result.voiceProfile = voiceProfile;
    }
    return _result;
  }
  factory EnrollVoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnrollVoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnrollVoiceResponse clone() => EnrollVoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnrollVoiceResponse copyWith(void Function(EnrollVoiceResponse) updates) => super.copyWith((message) => updates(message as EnrollVoiceResponse)) as EnrollVoiceResponse; // ignore: deprecated_member_use
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

class VerifyVoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyVoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioSample', $pb.PbFieldType.OY)
    ..aOM<AudioFormat>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'format', subBuilder: AudioFormat.create)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'threshold', $pb.PbFieldType.OF)
    ..m<$core.String, $core.String>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'VerifyVoiceRequest.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('voicebiometrics'))
    ..hasRequiredFields = false
  ;

  VerifyVoiceRequest._() : super();
  factory VerifyVoiceRequest({
    $core.String? userId,
    $core.List<$core.int>? audioSample,
    AudioFormat? format,
    $core.double? threshold,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (audioSample != null) {
      _result.audioSample = audioSample;
    }
    if (format != null) {
      _result.format = format;
    }
    if (threshold != null) {
      _result.threshold = threshold;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    return _result;
  }
  factory VerifyVoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyVoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyVoiceRequest clone() => VerifyVoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyVoiceRequest copyWith(void Function(VerifyVoiceRequest) updates) => super.copyWith((message) => updates(message as VerifyVoiceRequest)) as VerifyVoiceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyVoiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verified')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'similarityScore', $pb.PbFieldType.OF)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confidence', $pb.PbFieldType.OF)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..e<VerificationStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: VerificationStatus.VERIFICATION_UNKNOWN, valueOf: VerificationStatus.valueOf, enumValues: VerificationStatus.values)
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationTimestamp')
    ..hasRequiredFields = false
  ;

  VerifyVoiceResponse._() : super();
  factory VerifyVoiceResponse({
    $core.bool? verified,
    $core.double? similarityScore,
    $core.double? confidence,
    $core.String? message,
    VerificationStatus? status,
    $fixnum.Int64? verificationTimestamp,
  }) {
    final _result = create();
    if (verified != null) {
      _result.verified = verified;
    }
    if (similarityScore != null) {
      _result.similarityScore = similarityScore;
    }
    if (confidence != null) {
      _result.confidence = confidence;
    }
    if (message != null) {
      _result.message = message;
    }
    if (status != null) {
      _result.status = status;
    }
    if (verificationTimestamp != null) {
      _result.verificationTimestamp = verificationTimestamp;
    }
    return _result;
  }
  factory VerifyVoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyVoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyVoiceResponse clone() => VerifyVoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyVoiceResponse copyWith(void Function(VerifyVoiceResponse) updates) => super.copyWith((message) => updates(message as VerifyVoiceResponse)) as VerifyVoiceResponse; // ignore: deprecated_member_use
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

class CheckEnrollmentStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckEnrollmentStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  CheckEnrollmentStatusRequest._() : super();
  factory CheckEnrollmentStatusRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory CheckEnrollmentStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckEnrollmentStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckEnrollmentStatusRequest clone() => CheckEnrollmentStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckEnrollmentStatusRequest copyWith(void Function(CheckEnrollmentStatusRequest) updates) => super.copyWith((message) => updates(message as CheckEnrollmentStatusRequest)) as CheckEnrollmentStatusRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckEnrollmentStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isEnrolled')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enrollmentId')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enrolledAt')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'samplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'qualityScore', $pb.PbFieldType.OF)
    ..aOM<VoiceProfile>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'voiceProfile', subBuilder: VoiceProfile.create)
    ..hasRequiredFields = false
  ;

  CheckEnrollmentStatusResponse._() : super();
  factory CheckEnrollmentStatusResponse({
    $core.bool? isEnrolled,
    $core.String? enrollmentId,
    $fixnum.Int64? enrolledAt,
    $core.int? samplesCount,
    $core.double? qualityScore,
    VoiceProfile? voiceProfile,
  }) {
    final _result = create();
    if (isEnrolled != null) {
      _result.isEnrolled = isEnrolled;
    }
    if (enrollmentId != null) {
      _result.enrollmentId = enrollmentId;
    }
    if (enrolledAt != null) {
      _result.enrolledAt = enrolledAt;
    }
    if (samplesCount != null) {
      _result.samplesCount = samplesCount;
    }
    if (qualityScore != null) {
      _result.qualityScore = qualityScore;
    }
    if (voiceProfile != null) {
      _result.voiceProfile = voiceProfile;
    }
    return _result;
  }
  factory CheckEnrollmentStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckEnrollmentStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckEnrollmentStatusResponse clone() => CheckEnrollmentStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckEnrollmentStatusResponse copyWith(void Function(CheckEnrollmentStatusResponse) updates) => super.copyWith((message) => updates(message as CheckEnrollmentStatusResponse)) as CheckEnrollmentStatusResponse; // ignore: deprecated_member_use
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

class DeleteVoiceEnrollmentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteVoiceEnrollmentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  DeleteVoiceEnrollmentRequest._() : super();
  factory DeleteVoiceEnrollmentRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory DeleteVoiceEnrollmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteVoiceEnrollmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteVoiceEnrollmentRequest clone() => DeleteVoiceEnrollmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteVoiceEnrollmentRequest copyWith(void Function(DeleteVoiceEnrollmentRequest) updates) => super.copyWith((message) => updates(message as DeleteVoiceEnrollmentRequest)) as DeleteVoiceEnrollmentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteVoiceEnrollmentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteVoiceEnrollmentResponse._() : super();
  factory DeleteVoiceEnrollmentResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DeleteVoiceEnrollmentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteVoiceEnrollmentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteVoiceEnrollmentResponse clone() => DeleteVoiceEnrollmentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteVoiceEnrollmentResponse copyWith(void Function(DeleteVoiceEnrollmentResponse) updates) => super.copyWith((message) => updates(message as DeleteVoiceEnrollmentResponse)) as DeleteVoiceEnrollmentResponse; // ignore: deprecated_member_use
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

class UpdateVoiceEnrollmentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateVoiceEnrollmentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..p<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioSamples', $pb.PbFieldType.PY)
    ..aOM<AudioFormat>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'format', subBuilder: AudioFormat.create)
    ..hasRequiredFields = false
  ;

  UpdateVoiceEnrollmentRequest._() : super();
  factory UpdateVoiceEnrollmentRequest({
    $core.String? userId,
    $core.Iterable<$core.List<$core.int>>? audioSamples,
    AudioFormat? format,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (audioSamples != null) {
      _result.audioSamples.addAll(audioSamples);
    }
    if (format != null) {
      _result.format = format;
    }
    return _result;
  }
  factory UpdateVoiceEnrollmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateVoiceEnrollmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateVoiceEnrollmentRequest clone() => UpdateVoiceEnrollmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateVoiceEnrollmentRequest copyWith(void Function(UpdateVoiceEnrollmentRequest) updates) => super.copyWith((message) => updates(message as UpdateVoiceEnrollmentRequest)) as UpdateVoiceEnrollmentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateVoiceEnrollmentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newSamplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedQualityScore', $pb.PbFieldType.OF)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateVoiceEnrollmentResponse._() : super();
  factory UpdateVoiceEnrollmentResponse({
    $core.bool? success,
    $core.int? newSamplesCount,
    $core.double? updatedQualityScore,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (newSamplesCount != null) {
      _result.newSamplesCount = newSamplesCount;
    }
    if (updatedQualityScore != null) {
      _result.updatedQualityScore = updatedQualityScore;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateVoiceEnrollmentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateVoiceEnrollmentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateVoiceEnrollmentResponse clone() => UpdateVoiceEnrollmentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateVoiceEnrollmentResponse copyWith(void Function(UpdateVoiceEnrollmentResponse) updates) => super.copyWith((message) => updates(message as UpdateVoiceEnrollmentResponse)) as UpdateVoiceEnrollmentResponse; // ignore: deprecated_member_use
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

class GetVoiceEnrollmentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetVoiceEnrollmentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetVoiceEnrollmentRequest._() : super();
  factory GetVoiceEnrollmentRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetVoiceEnrollmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVoiceEnrollmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVoiceEnrollmentRequest clone() => GetVoiceEnrollmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVoiceEnrollmentRequest copyWith(void Function(GetVoiceEnrollmentRequest) updates) => super.copyWith((message) => updates(message as GetVoiceEnrollmentRequest)) as GetVoiceEnrollmentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetVoiceEnrollmentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'exists')
    ..aOM<VoiceProfile>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'voiceProfile', subBuilder: VoiceProfile.create)
    ..aOM<EnrollmentMetadata>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', subBuilder: EnrollmentMetadata.create)
    ..hasRequiredFields = false
  ;

  GetVoiceEnrollmentResponse._() : super();
  factory GetVoiceEnrollmentResponse({
    $core.bool? exists,
    VoiceProfile? voiceProfile,
    EnrollmentMetadata? metadata,
  }) {
    final _result = create();
    if (exists != null) {
      _result.exists = exists;
    }
    if (voiceProfile != null) {
      _result.voiceProfile = voiceProfile;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    return _result;
  }
  factory GetVoiceEnrollmentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVoiceEnrollmentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVoiceEnrollmentResponse clone() => GetVoiceEnrollmentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVoiceEnrollmentResponse copyWith(void Function(GetVoiceEnrollmentResponse) updates) => super.copyWith((message) => updates(message as GetVoiceEnrollmentResponse)) as GetVoiceEnrollmentResponse; // ignore: deprecated_member_use
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

class VoiceProfile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VoiceProfile', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enrollmentId')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'samplesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'qualityScore', $pb.PbFieldType.OF)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationCount', $pb.PbFieldType.O3)
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastVerifiedAt')
    ..hasRequiredFields = false
  ;

  VoiceProfile._() : super();
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
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (enrollmentId != null) {
      _result.enrollmentId = enrollmentId;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (samplesCount != null) {
      _result.samplesCount = samplesCount;
    }
    if (qualityScore != null) {
      _result.qualityScore = qualityScore;
    }
    if (verificationCount != null) {
      _result.verificationCount = verificationCount;
    }
    if (lastVerifiedAt != null) {
      _result.lastVerifiedAt = lastVerifiedAt;
    }
    return _result;
  }
  factory VoiceProfile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VoiceProfile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VoiceProfile clone() => VoiceProfile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VoiceProfile copyWith(void Function(VoiceProfile) updates) => super.copyWith((message) => updates(message as VoiceProfile)) as VoiceProfile; // ignore: deprecated_member_use
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

class EnrollmentMetadata extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EnrollmentMetadata', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceInfo')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioQuality')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sampleIds')
    ..m<$core.String, $core.String>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customFields', entryClassName: 'EnrollmentMetadata.CustomFieldsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('voicebiometrics'))
    ..hasRequiredFields = false
  ;

  EnrollmentMetadata._() : super();
  factory EnrollmentMetadata({
    $core.String? deviceInfo,
    $core.String? audioQuality,
    $core.Iterable<$core.String>? sampleIds,
    $core.Map<$core.String, $core.String>? customFields,
  }) {
    final _result = create();
    if (deviceInfo != null) {
      _result.deviceInfo = deviceInfo;
    }
    if (audioQuality != null) {
      _result.audioQuality = audioQuality;
    }
    if (sampleIds != null) {
      _result.sampleIds.addAll(sampleIds);
    }
    if (customFields != null) {
      _result.customFields.addAll(customFields);
    }
    return _result;
  }
  factory EnrollmentMetadata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnrollmentMetadata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnrollmentMetadata clone() => EnrollmentMetadata()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnrollmentMetadata copyWith(void Function(EnrollmentMetadata) updates) => super.copyWith((message) => updates(message as EnrollmentMetadata)) as EnrollmentMetadata; // ignore: deprecated_member_use
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

class AudioFormat extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AudioFormat', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voicebiometrics'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'codec')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sampleRate', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bitDepth', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AudioFormat._() : super();
  factory AudioFormat({
    $core.String? codec,
    $core.int? sampleRate,
    $core.int? channels,
    $core.int? bitDepth,
  }) {
    final _result = create();
    if (codec != null) {
      _result.codec = codec;
    }
    if (sampleRate != null) {
      _result.sampleRate = sampleRate;
    }
    if (channels != null) {
      _result.channels = channels;
    }
    if (bitDepth != null) {
      _result.bitDepth = bitDepth;
    }
    return _result;
  }
  factory AudioFormat.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AudioFormat.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AudioFormat clone() => AudioFormat()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AudioFormat copyWith(void Function(AudioFormat) updates) => super.copyWith((message) => updates(message as AudioFormat)) as AudioFormat; // ignore: deprecated_member_use
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

