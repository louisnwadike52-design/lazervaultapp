//
//  Generated code. Do not modify.
//  source: kyc.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'kyc.pb.dart' as $0;

export 'kyc.pb.dart';

@$pb.GrpcServiceName('kyc.KYCService')
class KYCServiceClient extends $grpc.Client {
  static final _$getKYCStatus = $grpc.ClientMethod<$0.GetKYCStatusRequest, $0.GetKYCStatusResponse>(
      '/kyc.KYCService/GetKYCStatus',
      ($0.GetKYCStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetKYCStatusResponse.fromBuffer(value));
  static final _$getCountryRequirements = $grpc.ClientMethod<$0.GetCountryRequirementsRequest, $0.GetCountryRequirementsResponse>(
      '/kyc.KYCService/GetCountryRequirements',
      ($0.GetCountryRequirementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCountryRequirementsResponse.fromBuffer(value));
  static final _$initiateKYC = $grpc.ClientMethod<$0.InitiateKYCRequest, $0.InitiateKYCResponse>(
      '/kyc.KYCService/InitiateKYC',
      ($0.InitiateKYCRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.InitiateKYCResponse.fromBuffer(value));
  static final _$verifyID = $grpc.ClientMethod<$0.VerifyIDRequest, $0.VerifyIDResponse>(
      '/kyc.KYCService/VerifyID',
      ($0.VerifyIDRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyIDResponse.fromBuffer(value));
  static final _$uploadDocument = $grpc.ClientMethod<$0.UploadDocumentRequest, $0.VerifyIDResponse>(
      '/kyc.KYCService/UploadDocument',
      ($0.UploadDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyIDResponse.fromBuffer(value));
  static final _$getUserDocuments = $grpc.ClientMethod<$0.GetUserDocumentsRequest, $0.GetUserDocumentsResponse>(
      '/kyc.KYCService/GetUserDocuments',
      ($0.GetUserDocumentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserDocumentsResponse.fromBuffer(value));
  static final _$skipKYCUpgrade = $grpc.ClientMethod<$0.SkipKYCRequest, $0.SkipKYCResponse>(
      '/kyc.KYCService/SkipKYCUpgrade',
      ($0.SkipKYCRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SkipKYCResponse.fromBuffer(value));
  static final _$createVerificationSession = $grpc.ClientMethod<$0.CreateVerificationSessionRequest, $0.CreateVerificationSessionResponse>(
      '/kyc.KYCService/CreateVerificationSession',
      ($0.CreateVerificationSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateVerificationSessionResponse.fromBuffer(value));
  static final _$confirmVerification = $grpc.ClientMethod<$0.ConfirmVerificationRequest, $0.ConfirmVerificationResponse>(
      '/kyc.KYCService/ConfirmVerification',
      ($0.ConfirmVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ConfirmVerificationResponse.fromBuffer(value));
  static final _$getDocumentUploadURL = $grpc.ClientMethod<$0.GetDocumentUploadURLRequest, $0.GetDocumentUploadURLResponse>(
      '/kyc.KYCService/GetDocumentUploadURL',
      ($0.GetDocumentUploadURLRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetDocumentUploadURLResponse.fromBuffer(value));
  static final _$submitDocumentsForReview = $grpc.ClientMethod<$0.SubmitDocumentsForReviewRequest, $0.SubmitDocumentsForReviewResponse>(
      '/kyc.KYCService/SubmitDocumentsForReview',
      ($0.SubmitDocumentsForReviewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SubmitDocumentsForReviewResponse.fromBuffer(value));
  static final _$getPendingReviews = $grpc.ClientMethod<$0.GetPendingReviewsRequest, $0.GetPendingReviewsResponse>(
      '/kyc.KYCService/GetPendingReviews',
      ($0.GetPendingReviewsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPendingReviewsResponse.fromBuffer(value));
  static final _$reviewDocument = $grpc.ClientMethod<$0.ReviewDocumentRequest, $0.ReviewDocumentResponse>(
      '/kyc.KYCService/ReviewDocument',
      ($0.ReviewDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ReviewDocumentResponse.fromBuffer(value));

  KYCServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetKYCStatusResponse> getKYCStatus($0.GetKYCStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getKYCStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCountryRequirementsResponse> getCountryRequirements($0.GetCountryRequirementsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCountryRequirements, request, options: options);
  }

  $grpc.ResponseFuture<$0.InitiateKYCResponse> initiateKYC($0.InitiateKYCRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateKYC, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyIDResponse> verifyID($0.VerifyIDRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyID, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyIDResponse> uploadDocument($0.UploadDocumentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadDocument, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserDocumentsResponse> getUserDocuments($0.GetUserDocumentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$0.SkipKYCResponse> skipKYCUpgrade($0.SkipKYCRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$skipKYCUpgrade, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateVerificationSessionResponse> createVerificationSession($0.CreateVerificationSessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVerificationSession, request, options: options);
  }

  $grpc.ResponseFuture<$0.ConfirmVerificationResponse> confirmVerification($0.ConfirmVerificationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$confirmVerification, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDocumentUploadURLResponse> getDocumentUploadURL($0.GetDocumentUploadURLRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDocumentUploadURL, request, options: options);
  }

  $grpc.ResponseFuture<$0.SubmitDocumentsForReviewResponse> submitDocumentsForReview($0.SubmitDocumentsForReviewRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitDocumentsForReview, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPendingReviewsResponse> getPendingReviews($0.GetPendingReviewsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingReviews, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReviewDocumentResponse> reviewDocument($0.ReviewDocumentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$reviewDocument, request, options: options);
  }
}

@$pb.GrpcServiceName('kyc.KYCService')
abstract class KYCServiceBase extends $grpc.Service {
  $core.String get $name => 'kyc.KYCService';

  KYCServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetKYCStatusRequest, $0.GetKYCStatusResponse>(
        'GetKYCStatus',
        getKYCStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetKYCStatusRequest.fromBuffer(value),
        ($0.GetKYCStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCountryRequirementsRequest, $0.GetCountryRequirementsResponse>(
        'GetCountryRequirements',
        getCountryRequirements_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCountryRequirementsRequest.fromBuffer(value),
        ($0.GetCountryRequirementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiateKYCRequest, $0.InitiateKYCResponse>(
        'InitiateKYC',
        initiateKYC_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InitiateKYCRequest.fromBuffer(value),
        ($0.InitiateKYCResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyIDRequest, $0.VerifyIDResponse>(
        'VerifyID',
        verifyID_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyIDRequest.fromBuffer(value),
        ($0.VerifyIDResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadDocumentRequest, $0.VerifyIDResponse>(
        'UploadDocument',
        uploadDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UploadDocumentRequest.fromBuffer(value),
        ($0.VerifyIDResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserDocumentsRequest, $0.GetUserDocumentsResponse>(
        'GetUserDocuments',
        getUserDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserDocumentsRequest.fromBuffer(value),
        ($0.GetUserDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SkipKYCRequest, $0.SkipKYCResponse>(
        'SkipKYCUpgrade',
        skipKYCUpgrade_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SkipKYCRequest.fromBuffer(value),
        ($0.SkipKYCResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateVerificationSessionRequest, $0.CreateVerificationSessionResponse>(
        'CreateVerificationSession',
        createVerificationSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateVerificationSessionRequest.fromBuffer(value),
        ($0.CreateVerificationSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConfirmVerificationRequest, $0.ConfirmVerificationResponse>(
        'ConfirmVerification',
        confirmVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ConfirmVerificationRequest.fromBuffer(value),
        ($0.ConfirmVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDocumentUploadURLRequest, $0.GetDocumentUploadURLResponse>(
        'GetDocumentUploadURL',
        getDocumentUploadURL_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetDocumentUploadURLRequest.fromBuffer(value),
        ($0.GetDocumentUploadURLResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubmitDocumentsForReviewRequest, $0.SubmitDocumentsForReviewResponse>(
        'SubmitDocumentsForReview',
        submitDocumentsForReview_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SubmitDocumentsForReviewRequest.fromBuffer(value),
        ($0.SubmitDocumentsForReviewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPendingReviewsRequest, $0.GetPendingReviewsResponse>(
        'GetPendingReviews',
        getPendingReviews_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPendingReviewsRequest.fromBuffer(value),
        ($0.GetPendingReviewsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReviewDocumentRequest, $0.ReviewDocumentResponse>(
        'ReviewDocument',
        reviewDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ReviewDocumentRequest.fromBuffer(value),
        ($0.ReviewDocumentResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetKYCStatusResponse> getKYCStatus_Pre($grpc.ServiceCall call, $async.Future<$0.GetKYCStatusRequest> request) async {
    return getKYCStatus(call, await request);
  }

  $async.Future<$0.GetCountryRequirementsResponse> getCountryRequirements_Pre($grpc.ServiceCall call, $async.Future<$0.GetCountryRequirementsRequest> request) async {
    return getCountryRequirements(call, await request);
  }

  $async.Future<$0.InitiateKYCResponse> initiateKYC_Pre($grpc.ServiceCall call, $async.Future<$0.InitiateKYCRequest> request) async {
    return initiateKYC(call, await request);
  }

  $async.Future<$0.VerifyIDResponse> verifyID_Pre($grpc.ServiceCall call, $async.Future<$0.VerifyIDRequest> request) async {
    return verifyID(call, await request);
  }

  $async.Future<$0.VerifyIDResponse> uploadDocument_Pre($grpc.ServiceCall call, $async.Future<$0.UploadDocumentRequest> request) async {
    return uploadDocument(call, await request);
  }

  $async.Future<$0.GetUserDocumentsResponse> getUserDocuments_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserDocumentsRequest> request) async {
    return getUserDocuments(call, await request);
  }

  $async.Future<$0.SkipKYCResponse> skipKYCUpgrade_Pre($grpc.ServiceCall call, $async.Future<$0.SkipKYCRequest> request) async {
    return skipKYCUpgrade(call, await request);
  }

  $async.Future<$0.CreateVerificationSessionResponse> createVerificationSession_Pre($grpc.ServiceCall call, $async.Future<$0.CreateVerificationSessionRequest> request) async {
    return createVerificationSession(call, await request);
  }

  $async.Future<$0.ConfirmVerificationResponse> confirmVerification_Pre($grpc.ServiceCall call, $async.Future<$0.ConfirmVerificationRequest> request) async {
    return confirmVerification(call, await request);
  }

  $async.Future<$0.GetDocumentUploadURLResponse> getDocumentUploadURL_Pre($grpc.ServiceCall call, $async.Future<$0.GetDocumentUploadURLRequest> request) async {
    return getDocumentUploadURL(call, await request);
  }

  $async.Future<$0.SubmitDocumentsForReviewResponse> submitDocumentsForReview_Pre($grpc.ServiceCall call, $async.Future<$0.SubmitDocumentsForReviewRequest> request) async {
    return submitDocumentsForReview(call, await request);
  }

  $async.Future<$0.GetPendingReviewsResponse> getPendingReviews_Pre($grpc.ServiceCall call, $async.Future<$0.GetPendingReviewsRequest> request) async {
    return getPendingReviews(call, await request);
  }

  $async.Future<$0.ReviewDocumentResponse> reviewDocument_Pre($grpc.ServiceCall call, $async.Future<$0.ReviewDocumentRequest> request) async {
    return reviewDocument(call, await request);
  }

  $async.Future<$0.GetKYCStatusResponse> getKYCStatus($grpc.ServiceCall call, $0.GetKYCStatusRequest request);
  $async.Future<$0.GetCountryRequirementsResponse> getCountryRequirements($grpc.ServiceCall call, $0.GetCountryRequirementsRequest request);
  $async.Future<$0.InitiateKYCResponse> initiateKYC($grpc.ServiceCall call, $0.InitiateKYCRequest request);
  $async.Future<$0.VerifyIDResponse> verifyID($grpc.ServiceCall call, $0.VerifyIDRequest request);
  $async.Future<$0.VerifyIDResponse> uploadDocument($grpc.ServiceCall call, $0.UploadDocumentRequest request);
  $async.Future<$0.GetUserDocumentsResponse> getUserDocuments($grpc.ServiceCall call, $0.GetUserDocumentsRequest request);
  $async.Future<$0.SkipKYCResponse> skipKYCUpgrade($grpc.ServiceCall call, $0.SkipKYCRequest request);
  $async.Future<$0.CreateVerificationSessionResponse> createVerificationSession($grpc.ServiceCall call, $0.CreateVerificationSessionRequest request);
  $async.Future<$0.ConfirmVerificationResponse> confirmVerification($grpc.ServiceCall call, $0.ConfirmVerificationRequest request);
  $async.Future<$0.GetDocumentUploadURLResponse> getDocumentUploadURL($grpc.ServiceCall call, $0.GetDocumentUploadURLRequest request);
  $async.Future<$0.SubmitDocumentsForReviewResponse> submitDocumentsForReview($grpc.ServiceCall call, $0.SubmitDocumentsForReviewRequest request);
  $async.Future<$0.GetPendingReviewsResponse> getPendingReviews($grpc.ServiceCall call, $0.GetPendingReviewsRequest request);
  $async.Future<$0.ReviewDocumentResponse> reviewDocument($grpc.ServiceCall call, $0.ReviewDocumentRequest request);
}
