///
//  Generated code. Do not modify.
//  source: kyc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'kyc.pb.dart' as $27;
export 'kyc.pb.dart';

class KYCServiceClient extends $grpc.Client {
  static final _$getKYCStatus =
      $grpc.ClientMethod<$27.GetKYCStatusRequest, $27.GetKYCStatusResponse>(
          '/kyc.KYCService/GetKYCStatus',
          ($27.GetKYCStatusRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.GetKYCStatusResponse.fromBuffer(value));
  static final _$getCountryRequirements = $grpc.ClientMethod<
          $27.GetCountryRequirementsRequest,
          $27.GetCountryRequirementsResponse>(
      '/kyc.KYCService/GetCountryRequirements',
      ($27.GetCountryRequirementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetCountryRequirementsResponse.fromBuffer(value));
  static final _$initiateKYC =
      $grpc.ClientMethod<$27.InitiateKYCRequest, $27.InitiateKYCResponse>(
          '/kyc.KYCService/InitiateKYC',
          ($27.InitiateKYCRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.InitiateKYCResponse.fromBuffer(value));
  static final _$verifyID =
      $grpc.ClientMethod<$27.VerifyIDRequest, $27.VerifyIDResponse>(
          '/kyc.KYCService/VerifyID',
          ($27.VerifyIDRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.VerifyIDResponse.fromBuffer(value));
  static final _$uploadDocument =
      $grpc.ClientMethod<$27.UploadDocumentRequest, $27.VerifyIDResponse>(
          '/kyc.KYCService/UploadDocument',
          ($27.UploadDocumentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.VerifyIDResponse.fromBuffer(value));
  static final _$getUserDocuments = $grpc.ClientMethod<
          $27.GetUserDocumentsRequest, $27.GetUserDocumentsResponse>(
      '/kyc.KYCService/GetUserDocuments',
      ($27.GetUserDocumentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetUserDocumentsResponse.fromBuffer(value));
  static final _$skipKYCUpgrade =
      $grpc.ClientMethod<$27.SkipKYCRequest, $27.SkipKYCResponse>(
          '/kyc.KYCService/SkipKYCUpgrade',
          ($27.SkipKYCRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.SkipKYCResponse.fromBuffer(value));
  static final _$createVerificationSession = $grpc.ClientMethod<
          $27.CreateVerificationSessionRequest,
          $27.CreateVerificationSessionResponse>(
      '/kyc.KYCService/CreateVerificationSession',
      ($27.CreateVerificationSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.CreateVerificationSessionResponse.fromBuffer(value));
  static final _$confirmVerification = $grpc.ClientMethod<
          $27.ConfirmVerificationRequest, $27.ConfirmVerificationResponse>(
      '/kyc.KYCService/ConfirmVerification',
      ($27.ConfirmVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.ConfirmVerificationResponse.fromBuffer(value));
  static final _$getDocumentUploadURL = $grpc.ClientMethod<
          $27.GetDocumentUploadURLRequest, $27.GetDocumentUploadURLResponse>(
      '/kyc.KYCService/GetDocumentUploadURL',
      ($27.GetDocumentUploadURLRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetDocumentUploadURLResponse.fromBuffer(value));
  static final _$submitDocumentsForReview = $grpc.ClientMethod<
          $27.SubmitDocumentsForReviewRequest,
          $27.SubmitDocumentsForReviewResponse>(
      '/kyc.KYCService/SubmitDocumentsForReview',
      ($27.SubmitDocumentsForReviewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.SubmitDocumentsForReviewResponse.fromBuffer(value));
  static final _$getPendingReviews = $grpc.ClientMethod<
          $27.GetPendingReviewsRequest, $27.GetPendingReviewsResponse>(
      '/kyc.KYCService/GetPendingReviews',
      ($27.GetPendingReviewsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetPendingReviewsResponse.fromBuffer(value));
  static final _$reviewDocument =
      $grpc.ClientMethod<$27.ReviewDocumentRequest, $27.ReviewDocumentResponse>(
          '/kyc.KYCService/ReviewDocument',
          ($27.ReviewDocumentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.ReviewDocumentResponse.fromBuffer(value));

  KYCServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$27.GetKYCStatusResponse> getKYCStatus(
      $27.GetKYCStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getKYCStatus, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetCountryRequirementsResponse>
      getCountryRequirements($27.GetCountryRequirementsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCountryRequirements, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.InitiateKYCResponse> initiateKYC(
      $27.InitiateKYCRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateKYC, request, options: options);
  }

  $grpc.ResponseFuture<$27.VerifyIDResponse> verifyID(
      $27.VerifyIDRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyID, request, options: options);
  }

  $grpc.ResponseFuture<$27.VerifyIDResponse> uploadDocument(
      $27.UploadDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadDocument, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetUserDocumentsResponse> getUserDocuments(
      $27.GetUserDocumentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$27.SkipKYCResponse> skipKYCUpgrade(
      $27.SkipKYCRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$skipKYCUpgrade, request, options: options);
  }

  $grpc.ResponseFuture<$27.CreateVerificationSessionResponse>
      createVerificationSession($27.CreateVerificationSessionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVerificationSession, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.ConfirmVerificationResponse> confirmVerification(
      $27.ConfirmVerificationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$confirmVerification, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetDocumentUploadURLResponse> getDocumentUploadURL(
      $27.GetDocumentUploadURLRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDocumentUploadURL, request, options: options);
  }

  $grpc.ResponseFuture<$27.SubmitDocumentsForReviewResponse>
      submitDocumentsForReview($27.SubmitDocumentsForReviewRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitDocumentsForReview, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.GetPendingReviewsResponse> getPendingReviews(
      $27.GetPendingReviewsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingReviews, request, options: options);
  }

  $grpc.ResponseFuture<$27.ReviewDocumentResponse> reviewDocument(
      $27.ReviewDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$reviewDocument, request, options: options);
  }
}

abstract class KYCServiceBase extends $grpc.Service {
  $core.String get $name => 'kyc.KYCService';

  KYCServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$27.GetKYCStatusRequest, $27.GetKYCStatusResponse>(
            'GetKYCStatus',
            getKYCStatus_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $27.GetKYCStatusRequest.fromBuffer(value),
            ($27.GetKYCStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetCountryRequirementsRequest,
            $27.GetCountryRequirementsResponse>(
        'GetCountryRequirements',
        getCountryRequirements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetCountryRequirementsRequest.fromBuffer(value),
        ($27.GetCountryRequirementsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$27.InitiateKYCRequest, $27.InitiateKYCResponse>(
            'InitiateKYC',
            initiateKYC_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $27.InitiateKYCRequest.fromBuffer(value),
            ($27.InitiateKYCResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.VerifyIDRequest, $27.VerifyIDResponse>(
        'VerifyID',
        verifyID_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $27.VerifyIDRequest.fromBuffer(value),
        ($27.VerifyIDResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$27.UploadDocumentRequest, $27.VerifyIDResponse>(
            'UploadDocument',
            uploadDocument_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $27.UploadDocumentRequest.fromBuffer(value),
            ($27.VerifyIDResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetUserDocumentsRequest,
            $27.GetUserDocumentsResponse>(
        'GetUserDocuments',
        getUserDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetUserDocumentsRequest.fromBuffer(value),
        ($27.GetUserDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.SkipKYCRequest, $27.SkipKYCResponse>(
        'SkipKYCUpgrade',
        skipKYCUpgrade_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $27.SkipKYCRequest.fromBuffer(value),
        ($27.SkipKYCResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.CreateVerificationSessionRequest,
            $27.CreateVerificationSessionResponse>(
        'CreateVerificationSession',
        createVerificationSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.CreateVerificationSessionRequest.fromBuffer(value),
        ($27.CreateVerificationSessionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.ConfirmVerificationRequest,
            $27.ConfirmVerificationResponse>(
        'ConfirmVerification',
        confirmVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.ConfirmVerificationRequest.fromBuffer(value),
        ($27.ConfirmVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetDocumentUploadURLRequest,
            $27.GetDocumentUploadURLResponse>(
        'GetDocumentUploadURL',
        getDocumentUploadURL_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetDocumentUploadURLRequest.fromBuffer(value),
        ($27.GetDocumentUploadURLResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.SubmitDocumentsForReviewRequest,
            $27.SubmitDocumentsForReviewResponse>(
        'SubmitDocumentsForReview',
        submitDocumentsForReview_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.SubmitDocumentsForReviewRequest.fromBuffer(value),
        ($27.SubmitDocumentsForReviewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetPendingReviewsRequest,
            $27.GetPendingReviewsResponse>(
        'GetPendingReviews',
        getPendingReviews_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetPendingReviewsRequest.fromBuffer(value),
        ($27.GetPendingReviewsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.ReviewDocumentRequest,
            $27.ReviewDocumentResponse>(
        'ReviewDocument',
        reviewDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.ReviewDocumentRequest.fromBuffer(value),
        ($27.ReviewDocumentResponse value) => value.writeToBuffer()));
  }

  $async.Future<$27.GetKYCStatusResponse> getKYCStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.GetKYCStatusRequest> request) async {
    return getKYCStatus(call, await request);
  }

  $async.Future<$27.GetCountryRequirementsResponse> getCountryRequirements_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.GetCountryRequirementsRequest> request) async {
    return getCountryRequirements(call, await request);
  }

  $async.Future<$27.InitiateKYCResponse> initiateKYC_Pre($grpc.ServiceCall call,
      $async.Future<$27.InitiateKYCRequest> request) async {
    return initiateKYC(call, await request);
  }

  $async.Future<$27.VerifyIDResponse> verifyID_Pre($grpc.ServiceCall call,
      $async.Future<$27.VerifyIDRequest> request) async {
    return verifyID(call, await request);
  }

  $async.Future<$27.VerifyIDResponse> uploadDocument_Pre($grpc.ServiceCall call,
      $async.Future<$27.UploadDocumentRequest> request) async {
    return uploadDocument(call, await request);
  }

  $async.Future<$27.GetUserDocumentsResponse> getUserDocuments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.GetUserDocumentsRequest> request) async {
    return getUserDocuments(call, await request);
  }

  $async.Future<$27.SkipKYCResponse> skipKYCUpgrade_Pre(
      $grpc.ServiceCall call, $async.Future<$27.SkipKYCRequest> request) async {
    return skipKYCUpgrade(call, await request);
  }

  $async.Future<$27.CreateVerificationSessionResponse>
      createVerificationSession_Pre($grpc.ServiceCall call,
          $async.Future<$27.CreateVerificationSessionRequest> request) async {
    return createVerificationSession(call, await request);
  }

  $async.Future<$27.ConfirmVerificationResponse> confirmVerification_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.ConfirmVerificationRequest> request) async {
    return confirmVerification(call, await request);
  }

  $async.Future<$27.GetDocumentUploadURLResponse> getDocumentUploadURL_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.GetDocumentUploadURLRequest> request) async {
    return getDocumentUploadURL(call, await request);
  }

  $async.Future<$27.SubmitDocumentsForReviewResponse>
      submitDocumentsForReview_Pre($grpc.ServiceCall call,
          $async.Future<$27.SubmitDocumentsForReviewRequest> request) async {
    return submitDocumentsForReview(call, await request);
  }

  $async.Future<$27.GetPendingReviewsResponse> getPendingReviews_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.GetPendingReviewsRequest> request) async {
    return getPendingReviews(call, await request);
  }

  $async.Future<$27.ReviewDocumentResponse> reviewDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.ReviewDocumentRequest> request) async {
    return reviewDocument(call, await request);
  }

  $async.Future<$27.GetKYCStatusResponse> getKYCStatus(
      $grpc.ServiceCall call, $27.GetKYCStatusRequest request);
  $async.Future<$27.GetCountryRequirementsResponse> getCountryRequirements(
      $grpc.ServiceCall call, $27.GetCountryRequirementsRequest request);
  $async.Future<$27.InitiateKYCResponse> initiateKYC(
      $grpc.ServiceCall call, $27.InitiateKYCRequest request);
  $async.Future<$27.VerifyIDResponse> verifyID(
      $grpc.ServiceCall call, $27.VerifyIDRequest request);
  $async.Future<$27.VerifyIDResponse> uploadDocument(
      $grpc.ServiceCall call, $27.UploadDocumentRequest request);
  $async.Future<$27.GetUserDocumentsResponse> getUserDocuments(
      $grpc.ServiceCall call, $27.GetUserDocumentsRequest request);
  $async.Future<$27.SkipKYCResponse> skipKYCUpgrade(
      $grpc.ServiceCall call, $27.SkipKYCRequest request);
  $async.Future<$27.CreateVerificationSessionResponse>
      createVerificationSession(
          $grpc.ServiceCall call, $27.CreateVerificationSessionRequest request);
  $async.Future<$27.ConfirmVerificationResponse> confirmVerification(
      $grpc.ServiceCall call, $27.ConfirmVerificationRequest request);
  $async.Future<$27.GetDocumentUploadURLResponse> getDocumentUploadURL(
      $grpc.ServiceCall call, $27.GetDocumentUploadURLRequest request);
  $async.Future<$27.SubmitDocumentsForReviewResponse> submitDocumentsForReview(
      $grpc.ServiceCall call, $27.SubmitDocumentsForReviewRequest request);
  $async.Future<$27.GetPendingReviewsResponse> getPendingReviews(
      $grpc.ServiceCall call, $27.GetPendingReviewsRequest request);
  $async.Future<$27.ReviewDocumentResponse> reviewDocument(
      $grpc.ServiceCall call, $27.ReviewDocumentRequest request);
}
