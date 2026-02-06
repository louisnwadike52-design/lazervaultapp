//
//  Generated code. Do not modify.
//  source: facial_recognition.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $42;

/// Register Face Request
class RegisterFaceRequest extends $pb.GeneratedMessage {
  factory RegisterFaceRequest({
    $core.String? userId,
    $core.String? faceId,
    $core.bool? allowDuplicates,
    $core.double? duplicateThreshold,
    $core.List<$core.int>? imageData,
    $core.String? imageFilename,
    $core.String? imageContentType,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (faceId != null) {
      $result.faceId = faceId;
    }
    if (allowDuplicates != null) {
      $result.allowDuplicates = allowDuplicates;
    }
    if (duplicateThreshold != null) {
      $result.duplicateThreshold = duplicateThreshold;
    }
    if (imageData != null) {
      $result.imageData = imageData;
    }
    if (imageFilename != null) {
      $result.imageFilename = imageFilename;
    }
    if (imageContentType != null) {
      $result.imageContentType = imageContentType;
    }
    return $result;
  }
  RegisterFaceRequest._() : super();
  factory RegisterFaceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterFaceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RegisterFaceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'user_id')
    ..aOS(2, _omitFieldNames ? '' : 'face_id')
    ..aOB(3, _omitFieldNames ? '' : 'allow_duplicates')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'duplicate_threshold', $pb.PbFieldType.OD)
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'image_data', $pb.PbFieldType.OY)
    ..aOS(6, _omitFieldNames ? '' : 'image_filename')
    ..aOS(7, _omitFieldNames ? '' : 'image_content_type')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterFaceRequest clone() => RegisterFaceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterFaceRequest copyWith(void Function(RegisterFaceRequest) updates) => super.copyWith((message) => updates(message as RegisterFaceRequest)) as RegisterFaceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterFaceRequest create() => RegisterFaceRequest._();
  RegisterFaceRequest createEmptyInstance() => create();
  static $pb.PbList<RegisterFaceRequest> createRepeated() => $pb.PbList<RegisterFaceRequest>();
  @$core.pragma('dart2js:noInline')
  static RegisterFaceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterFaceRequest>(create);
  static RegisterFaceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get faceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set faceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFaceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFaceId() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get allowDuplicates => $_getBF(2);
  @$pb.TagNumber(3)
  set allowDuplicates($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAllowDuplicates() => $_has(2);
  @$pb.TagNumber(3)
  void clearAllowDuplicates() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get duplicateThreshold => $_getN(3);
  @$pb.TagNumber(4)
  set duplicateThreshold($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDuplicateThreshold() => $_has(3);
  @$pb.TagNumber(4)
  void clearDuplicateThreshold() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get imageData => $_getN(4);
  @$pb.TagNumber(5)
  set imageData($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasImageData() => $_has(4);
  @$pb.TagNumber(5)
  void clearImageData() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get imageFilename => $_getSZ(5);
  @$pb.TagNumber(6)
  set imageFilename($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasImageFilename() => $_has(5);
  @$pb.TagNumber(6)
  void clearImageFilename() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get imageContentType => $_getSZ(6);
  @$pb.TagNumber(7)
  set imageContentType($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasImageContentType() => $_has(6);
  @$pb.TagNumber(7)
  void clearImageContentType() => clearField(7);
}

/// Register Face Response
class RegisterFaceResponse extends $pb.GeneratedMessage {
  factory RegisterFaceResponse({
    $core.bool? success,
    $core.String? faceId,
    $core.String? message,
    $core.String? error,
    $core.int? numFacesDetected,
    DuplicateDetails? duplicateDetails,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (faceId != null) {
      $result.faceId = faceId;
    }
    if (message != null) {
      $result.message = message;
    }
    if (error != null) {
      $result.error = error;
    }
    if (numFacesDetected != null) {
      $result.numFacesDetected = numFacesDetected;
    }
    if (duplicateDetails != null) {
      $result.duplicateDetails = duplicateDetails;
    }
    return $result;
  }
  RegisterFaceResponse._() : super();
  factory RegisterFaceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterFaceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RegisterFaceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'faceId')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOS(4, _omitFieldNames ? '' : 'error')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'numFacesDetected', $pb.PbFieldType.O3)
    ..aOM<DuplicateDetails>(6, _omitFieldNames ? '' : 'duplicateDetails', subBuilder: DuplicateDetails.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterFaceResponse clone() => RegisterFaceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterFaceResponse copyWith(void Function(RegisterFaceResponse) updates) => super.copyWith((message) => updates(message as RegisterFaceResponse)) as RegisterFaceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterFaceResponse create() => RegisterFaceResponse._();
  RegisterFaceResponse createEmptyInstance() => create();
  static $pb.PbList<RegisterFaceResponse> createRepeated() => $pb.PbList<RegisterFaceResponse>();
  @$core.pragma('dart2js:noInline')
  static RegisterFaceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterFaceResponse>(create);
  static RegisterFaceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get faceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set faceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFaceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFaceId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get error => $_getSZ(3);
  @$pb.TagNumber(4)
  set error($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasError() => $_has(3);
  @$pb.TagNumber(4)
  void clearError() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get numFacesDetected => $_getIZ(4);
  @$pb.TagNumber(5)
  set numFacesDetected($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNumFacesDetected() => $_has(4);
  @$pb.TagNumber(5)
  void clearNumFacesDetected() => clearField(5);

  @$pb.TagNumber(6)
  DuplicateDetails get duplicateDetails => $_getN(5);
  @$pb.TagNumber(6)
  set duplicateDetails(DuplicateDetails v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDuplicateDetails() => $_has(5);
  @$pb.TagNumber(6)
  void clearDuplicateDetails() => clearField(6);
  @$pb.TagNumber(6)
  DuplicateDetails ensureDuplicateDetails() => $_ensure(5);
}

/// Verify Face Request
class VerifyFaceRequest extends $pb.GeneratedMessage {
  factory VerifyFaceRequest({
    $core.String? userId,
    $core.double? threshold,
    $core.List<$core.int>? imageData,
    $core.String? imageFilename,
    $core.String? imageContentType,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (threshold != null) {
      $result.threshold = threshold;
    }
    if (imageData != null) {
      $result.imageData = imageData;
    }
    if (imageFilename != null) {
      $result.imageFilename = imageFilename;
    }
    if (imageContentType != null) {
      $result.imageContentType = imageContentType;
    }
    return $result;
  }
  VerifyFaceRequest._() : super();
  factory VerifyFaceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyFaceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyFaceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'user_id')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'threshold', $pb.PbFieldType.OD)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'image_data', $pb.PbFieldType.OY)
    ..aOS(4, _omitFieldNames ? '' : 'image_filename')
    ..aOS(5, _omitFieldNames ? '' : 'image_content_type')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyFaceRequest clone() => VerifyFaceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyFaceRequest copyWith(void Function(VerifyFaceRequest) updates) => super.copyWith((message) => updates(message as VerifyFaceRequest)) as VerifyFaceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyFaceRequest create() => VerifyFaceRequest._();
  VerifyFaceRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyFaceRequest> createRepeated() => $pb.PbList<VerifyFaceRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyFaceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyFaceRequest>(create);
  static VerifyFaceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get threshold => $_getN(1);
  @$pb.TagNumber(2)
  set threshold($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasThreshold() => $_has(1);
  @$pb.TagNumber(2)
  void clearThreshold() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get imageData => $_getN(2);
  @$pb.TagNumber(3)
  set imageData($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasImageData() => $_has(2);
  @$pb.TagNumber(3)
  void clearImageData() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageFilename => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageFilename($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasImageFilename() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageFilename() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get imageContentType => $_getSZ(4);
  @$pb.TagNumber(5)
  set imageContentType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasImageContentType() => $_has(4);
  @$pb.TagNumber(5)
  void clearImageContentType() => clearField(5);
}

/// Verify Face Response
class VerifyFaceResponse extends $pb.GeneratedMessage {
  factory VerifyFaceResponse({
    $core.bool? success,
    $core.bool? verified,
    $core.double? confidence,
    $core.String? matchedFaceId,
    $core.double? threshold,
    $core.double? distance,
    $core.String? message,
    $core.String? error,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (verified != null) {
      $result.verified = verified;
    }
    if (confidence != null) {
      $result.confidence = confidence;
    }
    if (matchedFaceId != null) {
      $result.matchedFaceId = matchedFaceId;
    }
    if (threshold != null) {
      $result.threshold = threshold;
    }
    if (distance != null) {
      $result.distance = distance;
    }
    if (message != null) {
      $result.message = message;
    }
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  VerifyFaceResponse._() : super();
  factory VerifyFaceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyFaceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyFaceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOB(2, _omitFieldNames ? '' : 'verified')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'confidence', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'matchedFaceId')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'threshold', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'distance', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'message')
    ..aOS(8, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyFaceResponse clone() => VerifyFaceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyFaceResponse copyWith(void Function(VerifyFaceResponse) updates) => super.copyWith((message) => updates(message as VerifyFaceResponse)) as VerifyFaceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyFaceResponse create() => VerifyFaceResponse._();
  VerifyFaceResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyFaceResponse> createRepeated() => $pb.PbList<VerifyFaceResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyFaceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyFaceResponse>(create);
  static VerifyFaceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get verified => $_getBF(1);
  @$pb.TagNumber(2)
  set verified($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVerified() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerified() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get confidence => $_getN(2);
  @$pb.TagNumber(3)
  set confidence($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfidence() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfidence() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get matchedFaceId => $_getSZ(3);
  @$pb.TagNumber(4)
  set matchedFaceId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMatchedFaceId() => $_has(3);
  @$pb.TagNumber(4)
  void clearMatchedFaceId() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get threshold => $_getN(4);
  @$pb.TagNumber(5)
  set threshold($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasThreshold() => $_has(4);
  @$pb.TagNumber(5)
  void clearThreshold() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get distance => $_getN(5);
  @$pb.TagNumber(6)
  set distance($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDistance() => $_has(5);
  @$pb.TagNumber(6)
  void clearDistance() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get message => $_getSZ(6);
  @$pb.TagNumber(7)
  set message($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearMessage() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get error => $_getSZ(7);
  @$pb.TagNumber(8)
  set error($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasError() => $_has(7);
  @$pb.TagNumber(8)
  void clearError() => clearField(8);
}

/// Duplicate Details for Registration
class DuplicateDetails extends $pb.GeneratedMessage {
  factory DuplicateDetails({
    $core.bool? isDuplicate,
    $core.double? threshold,
    $core.int? totalMatches,
    PrimaryMatch? primaryMatch,
    $core.Iterable<Match>? allMatches,
    $core.String? message,
    $core.String? securityNote,
  }) {
    final $result = create();
    if (isDuplicate != null) {
      $result.isDuplicate = isDuplicate;
    }
    if (threshold != null) {
      $result.threshold = threshold;
    }
    if (totalMatches != null) {
      $result.totalMatches = totalMatches;
    }
    if (primaryMatch != null) {
      $result.primaryMatch = primaryMatch;
    }
    if (allMatches != null) {
      $result.allMatches.addAll(allMatches);
    }
    if (message != null) {
      $result.message = message;
    }
    if (securityNote != null) {
      $result.securityNote = securityNote;
    }
    return $result;
  }
  DuplicateDetails._() : super();
  factory DuplicateDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DuplicateDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DuplicateDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isDuplicate')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'threshold', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalMatches', $pb.PbFieldType.O3)
    ..aOM<PrimaryMatch>(4, _omitFieldNames ? '' : 'primaryMatch', subBuilder: PrimaryMatch.create)
    ..pc<Match>(5, _omitFieldNames ? '' : 'allMatches', $pb.PbFieldType.PM, subBuilder: Match.create)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..aOS(7, _omitFieldNames ? '' : 'securityNote')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DuplicateDetails clone() => DuplicateDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DuplicateDetails copyWith(void Function(DuplicateDetails) updates) => super.copyWith((message) => updates(message as DuplicateDetails)) as DuplicateDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DuplicateDetails create() => DuplicateDetails._();
  DuplicateDetails createEmptyInstance() => create();
  static $pb.PbList<DuplicateDetails> createRepeated() => $pb.PbList<DuplicateDetails>();
  @$core.pragma('dart2js:noInline')
  static DuplicateDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DuplicateDetails>(create);
  static DuplicateDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isDuplicate => $_getBF(0);
  @$pb.TagNumber(1)
  set isDuplicate($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsDuplicate() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsDuplicate() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get threshold => $_getN(1);
  @$pb.TagNumber(2)
  set threshold($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasThreshold() => $_has(1);
  @$pb.TagNumber(2)
  void clearThreshold() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalMatches => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalMatches($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalMatches() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalMatches() => clearField(3);

  @$pb.TagNumber(4)
  PrimaryMatch get primaryMatch => $_getN(3);
  @$pb.TagNumber(4)
  set primaryMatch(PrimaryMatch v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPrimaryMatch() => $_has(3);
  @$pb.TagNumber(4)
  void clearPrimaryMatch() => clearField(4);
  @$pb.TagNumber(4)
  PrimaryMatch ensurePrimaryMatch() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.List<Match> get allMatches => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get securityNote => $_getSZ(6);
  @$pb.TagNumber(7)
  set securityNote($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSecurityNote() => $_has(6);
  @$pb.TagNumber(7)
  void clearSecurityNote() => clearField(7);
}

/// Primary Match Details
class PrimaryMatch extends $pb.GeneratedMessage {
  factory PrimaryMatch({
    $core.String? userId,
    $core.String? faceId,
    $core.double? confidence,
    $core.String? registeredAt,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (faceId != null) {
      $result.faceId = faceId;
    }
    if (confidence != null) {
      $result.confidence = confidence;
    }
    if (registeredAt != null) {
      $result.registeredAt = registeredAt;
    }
    return $result;
  }
  PrimaryMatch._() : super();
  factory PrimaryMatch.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PrimaryMatch.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PrimaryMatch', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'faceId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'confidence', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'registeredAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PrimaryMatch clone() => PrimaryMatch()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PrimaryMatch copyWith(void Function(PrimaryMatch) updates) => super.copyWith((message) => updates(message as PrimaryMatch)) as PrimaryMatch;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PrimaryMatch create() => PrimaryMatch._();
  PrimaryMatch createEmptyInstance() => create();
  static $pb.PbList<PrimaryMatch> createRepeated() => $pb.PbList<PrimaryMatch>();
  @$core.pragma('dart2js:noInline')
  static PrimaryMatch getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PrimaryMatch>(create);
  static PrimaryMatch? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get faceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set faceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFaceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFaceId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get confidence => $_getN(2);
  @$pb.TagNumber(3)
  set confidence($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfidence() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfidence() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get registeredAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set registeredAt($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRegisteredAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearRegisteredAt() => clearField(4);
}

/// Match Details
class Match extends $pb.GeneratedMessage {
  factory Match({
    $core.String? userId,
    $core.String? faceId,
    $core.double? confidence,
    $core.String? registeredAt,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (faceId != null) {
      $result.faceId = faceId;
    }
    if (confidence != null) {
      $result.confidence = confidence;
    }
    if (registeredAt != null) {
      $result.registeredAt = registeredAt;
    }
    return $result;
  }
  Match._() : super();
  factory Match.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Match.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Match', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'faceId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'confidence', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'registeredAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Match clone() => Match()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Match copyWith(void Function(Match) updates) => super.copyWith((message) => updates(message as Match)) as Match;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Match create() => Match._();
  Match createEmptyInstance() => create();
  static $pb.PbList<Match> createRepeated() => $pb.PbList<Match>();
  @$core.pragma('dart2js:noInline')
  static Match getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Match>(create);
  static Match? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get faceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set faceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFaceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFaceId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get confidence => $_getN(2);
  @$pb.TagNumber(3)
  set confidence($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfidence() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfidence() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get registeredAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set registeredAt($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRegisteredAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearRegisteredAt() => clearField(4);
}

/// Health Check Request
class HealthCheckRequest extends $pb.GeneratedMessage {
  factory HealthCheckRequest() => create();
  HealthCheckRequest._() : super();
  factory HealthCheckRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthCheckRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HealthCheckRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HealthCheckRequest clone() => HealthCheckRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HealthCheckRequest copyWith(void Function(HealthCheckRequest) updates) => super.copyWith((message) => updates(message as HealthCheckRequest)) as HealthCheckRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthCheckRequest create() => HealthCheckRequest._();
  HealthCheckRequest createEmptyInstance() => create();
  static $pb.PbList<HealthCheckRequest> createRepeated() => $pb.PbList<HealthCheckRequest>();
  @$core.pragma('dart2js:noInline')
  static HealthCheckRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HealthCheckRequest>(create);
  static HealthCheckRequest? _defaultInstance;
}

/// Health Check Response
class HealthCheckResponse extends $pb.GeneratedMessage {
  factory HealthCheckResponse({
    $core.bool? healthy,
    $core.String? message,
    $core.String? serviceVersion,
    $42.Timestamp? timestamp,
  }) {
    final $result = create();
    if (healthy != null) {
      $result.healthy = healthy;
    }
    if (message != null) {
      $result.message = message;
    }
    if (serviceVersion != null) {
      $result.serviceVersion = serviceVersion;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  HealthCheckResponse._() : super();
  factory HealthCheckResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthCheckResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HealthCheckResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'healthy')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'service_version')
    ..aOM<$42.Timestamp>(4, _omitFieldNames ? '' : 'timestamp', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HealthCheckResponse clone() => HealthCheckResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HealthCheckResponse copyWith(void Function(HealthCheckResponse) updates) => super.copyWith((message) => updates(message as HealthCheckResponse)) as HealthCheckResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthCheckResponse create() => HealthCheckResponse._();
  HealthCheckResponse createEmptyInstance() => create();
  static $pb.PbList<HealthCheckResponse> createRepeated() => $pb.PbList<HealthCheckResponse>();
  @$core.pragma('dart2js:noInline')
  static HealthCheckResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HealthCheckResponse>(create);
  static HealthCheckResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get healthy => $_getBF(0);
  @$pb.TagNumber(1)
  set healthy($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHealthy() => $_has(0);
  @$pb.TagNumber(1)
  void clearHealthy() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get serviceVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set serviceVersion($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasServiceVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceVersion() => clearField(3);

  @$pb.TagNumber(4)
  $42.Timestamp get timestamp => $_getN(3);
  @$pb.TagNumber(4)
  set timestamp($42.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);
  @$pb.TagNumber(4)
  $42.Timestamp ensureTimestamp() => $_ensure(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
