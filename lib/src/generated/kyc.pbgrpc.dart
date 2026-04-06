///
//  Generated code. Do not modify.
//  source: kyc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'kyc.pb.dart' as $26;
export 'kyc.pb.dart';

class KYCServiceClient extends $grpc.Client {
  static final _$getKYCStatus =
      $grpc.ClientMethod<$26.GetKYCStatusRequest, $26.GetKYCStatusResponse>(
          '/kyc.KYCService/GetKYCStatus',
          ($26.GetKYCStatusRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.GetKYCStatusResponse.fromBuffer(value));
  static final _$getCountryRequirements = $grpc.ClientMethod<
          $26.GetCountryRequirementsRequest,
          $26.GetCountryRequirementsResponse>(
      '/kyc.KYCService/GetCountryRequirements',
      ($26.GetCountryRequirementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetCountryRequirementsResponse.fromBuffer(value));
  static final _$initiateKYC =
      $grpc.ClientMethod<$26.InitiateKYCRequest, $26.InitiateKYCResponse>(
          '/kyc.KYCService/InitiateKYC',
          ($26.InitiateKYCRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.InitiateKYCResponse.fromBuffer(value));
  static final _$verifyID =
      $grpc.ClientMethod<$26.VerifyIDRequest, $26.VerifyIDResponse>(
          '/kyc.KYCService/VerifyID',
          ($26.VerifyIDRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.VerifyIDResponse.fromBuffer(value));
  static final _$uploadDocument =
      $grpc.ClientMethod<$26.UploadDocumentRequest, $26.VerifyIDResponse>(
          '/kyc.KYCService/UploadDocument',
          ($26.UploadDocumentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.VerifyIDResponse.fromBuffer(value));
  static final _$getUserDocuments = $grpc.ClientMethod<
          $26.GetUserDocumentsRequest, $26.GetUserDocumentsResponse>(
      '/kyc.KYCService/GetUserDocuments',
      ($26.GetUserDocumentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetUserDocumentsResponse.fromBuffer(value));
  static final _$skipKYCUpgrade =
      $grpc.ClientMethod<$26.SkipKYCRequest, $26.SkipKYCResponse>(
          '/kyc.KYCService/SkipKYCUpgrade',
          ($26.SkipKYCRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.SkipKYCResponse.fromBuffer(value));
  static final _$createVerificationSession = $grpc.ClientMethod<
          $26.CreateVerificationSessionRequest,
          $26.CreateVerificationSessionResponse>(
      '/kyc.KYCService/CreateVerificationSession',
      ($26.CreateVerificationSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.CreateVerificationSessionResponse.fromBuffer(value));
  static final _$confirmVerification = $grpc.ClientMethod<
          $26.ConfirmVerificationRequest, $26.ConfirmVerificationResponse>(
      '/kyc.KYCService/ConfirmVerification',
      ($26.ConfirmVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.ConfirmVerificationResponse.fromBuffer(value));
  static final _$getDocumentUploadURL = $grpc.ClientMethod<
          $26.GetDocumentUploadURLRequest, $26.GetDocumentUploadURLResponse>(
      '/kyc.KYCService/GetDocumentUploadURL',
      ($26.GetDocumentUploadURLRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetDocumentUploadURLResponse.fromBuffer(value));
  static final _$submitDocumentsForReview = $grpc.ClientMethod<
          $26.SubmitDocumentsForReviewRequest,
          $26.SubmitDocumentsForReviewResponse>(
      '/kyc.KYCService/SubmitDocumentsForReview',
      ($26.SubmitDocumentsForReviewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.SubmitDocumentsForReviewResponse.fromBuffer(value));
  static final _$getPendingReviews = $grpc.ClientMethod<
          $26.GetPendingReviewsRequest, $26.GetPendingReviewsResponse>(
      '/kyc.KYCService/GetPendingReviews',
      ($26.GetPendingReviewsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetPendingReviewsResponse.fromBuffer(value));
  static final _$reviewDocument =
      $grpc.ClientMethod<$26.ReviewDocumentRequest, $26.ReviewDocumentResponse>(
          '/kyc.KYCService/ReviewDocument',
          ($26.ReviewDocumentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.ReviewDocumentResponse.fromBuffer(value));

  KYCServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$26.GetKYCStatusResponse> getKYCStatus(
      $26.GetKYCStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getKYCStatus, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetCountryRequirementsResponse>
      getCountryRequirements($26.GetCountryRequirementsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCountryRequirements, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.InitiateKYCResponse> initiateKYC(
      $26.InitiateKYCRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateKYC, request, options: options);
  }

  $grpc.ResponseFuture<$26.VerifyIDResponse> verifyID(
      $26.VerifyIDRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyID, request, options: options);
  }

  $grpc.ResponseFuture<$26.VerifyIDResponse> uploadDocument(
      $26.UploadDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadDocument, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetUserDocumentsResponse> getUserDocuments(
      $26.GetUserDocumentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$26.SkipKYCResponse> skipKYCUpgrade(
      $26.SkipKYCRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$skipKYCUpgrade, request, options: options);
  }

  $grpc.ResponseFuture<$26.CreateVerificationSessionResponse>
      createVerificationSession($26.CreateVerificationSessionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVerificationSession, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.ConfirmVerificationResponse> confirmVerification(
      $26.ConfirmVerificationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$confirmVerification, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetDocumentUploadURLResponse> getDocumentUploadURL(
      $26.GetDocumentUploadURLRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDocumentUploadURL, request, options: options);
  }

  $grpc.ResponseFuture<$26.SubmitDocumentsForReviewResponse>
      submitDocumentsForReview($26.SubmitDocumentsForReviewRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitDocumentsForReview, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.GetPendingReviewsResponse> getPendingReviews(
      $26.GetPendingReviewsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingReviews, request, options: options);
  }

  $grpc.ResponseFuture<$26.ReviewDocumentResponse> reviewDocument(
      $26.ReviewDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$reviewDocument, request, options: options);
  }
}

abstract class KYCServiceBase extends $grpc.Service {
  $core.String get $name => 'kyc.KYCService';

  KYCServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$26.GetKYCStatusRequest, $26.GetKYCStatusResponse>(
            'GetKYCStatus',
            getKYCStatus_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $26.GetKYCStatusRequest.fromBuffer(value),
            ($26.GetKYCStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetCountryRequirementsRequest,
            $26.GetCountryRequirementsResponse>(
        'GetCountryRequirements',
        getCountryRequirements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetCountryRequirementsRequest.fromBuffer(value),
        ($26.GetCountryRequirementsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$26.InitiateKYCRequest, $26.InitiateKYCResponse>(
            'InitiateKYC',
            initiateKYC_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $26.InitiateKYCRequest.fromBuffer(value),
            ($26.InitiateKYCResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.VerifyIDRequest, $26.VerifyIDResponse>(
        'VerifyID',
        verifyID_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.VerifyIDRequest.fromBuffer(value),
        ($26.VerifyIDResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$26.UploadDocumentRequest, $26.VerifyIDResponse>(
            'UploadDocument',
            uploadDocument_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $26.UploadDocumentRequest.fromBuffer(value),
            ($26.VerifyIDResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetUserDocumentsRequest,
            $26.GetUserDocumentsResponse>(
        'GetUserDocuments',
        getUserDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetUserDocumentsRequest.fromBuffer(value),
        ($26.GetUserDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.SkipKYCRequest, $26.SkipKYCResponse>(
        'SkipKYCUpgrade',
        skipKYCUpgrade_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $26.SkipKYCRequest.fromBuffer(value),
        ($26.SkipKYCResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.CreateVerificationSessionRequest,
            $26.CreateVerificationSessionResponse>(
        'CreateVerificationSession',
        createVerificationSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.CreateVerificationSessionRequest.fromBuffer(value),
        ($26.CreateVerificationSessionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.ConfirmVerificationRequest,
            $26.ConfirmVerificationResponse>(
        'ConfirmVerification',
        confirmVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ConfirmVerificationRequest.fromBuffer(value),
        ($26.ConfirmVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetDocumentUploadURLRequest,
            $26.GetDocumentUploadURLResponse>(
        'GetDocumentUploadURL',
        getDocumentUploadURL_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetDocumentUploadURLRequest.fromBuffer(value),
        ($26.GetDocumentUploadURLResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.SubmitDocumentsForReviewRequest,
            $26.SubmitDocumentsForReviewResponse>(
        'SubmitDocumentsForReview',
        submitDocumentsForReview_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.SubmitDocumentsForReviewRequest.fromBuffer(value),
        ($26.SubmitDocumentsForReviewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetPendingReviewsRequest,
            $26.GetPendingReviewsResponse>(
        'GetPendingReviews',
        getPendingReviews_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetPendingReviewsRequest.fromBuffer(value),
        ($26.GetPendingReviewsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.ReviewDocumentRequest,
            $26.ReviewDocumentResponse>(
        'ReviewDocument',
        reviewDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ReviewDocumentRequest.fromBuffer(value),
        ($26.ReviewDocumentResponse value) => value.writeToBuffer()));
  }

  $async.Future<$26.GetKYCStatusResponse> getKYCStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.GetKYCStatusRequest> request) async {
    return getKYCStatus(call, await request);
  }

  $async.Future<$26.GetCountryRequirementsResponse> getCountryRequirements_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.GetCountryRequirementsRequest> request) async {
    return getCountryRequirements(call, await request);
  }

  $async.Future<$26.InitiateKYCResponse> initiateKYC_Pre($grpc.ServiceCall call,
      $async.Future<$26.InitiateKYCRequest> request) async {
    return initiateKYC(call, await request);
  }

  $async.Future<$26.VerifyIDResponse> verifyID_Pre($grpc.ServiceCall call,
      $async.Future<$26.VerifyIDRequest> request) async {
    return verifyID(call, await request);
  }

  $async.Future<$26.VerifyIDResponse> uploadDocument_Pre($grpc.ServiceCall call,
      $async.Future<$26.UploadDocumentRequest> request) async {
    return uploadDocument(call, await request);
  }

  $async.Future<$26.GetUserDocumentsResponse> getUserDocuments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.GetUserDocumentsRequest> request) async {
    return getUserDocuments(call, await request);
  }

  $async.Future<$26.SkipKYCResponse> skipKYCUpgrade_Pre(
      $grpc.ServiceCall call, $async.Future<$26.SkipKYCRequest> request) async {
    return skipKYCUpgrade(call, await request);
  }

  $async.Future<$26.CreateVerificationSessionResponse>
      createVerificationSession_Pre($grpc.ServiceCall call,
          $async.Future<$26.CreateVerificationSessionRequest> request) async {
    return createVerificationSession(call, await request);
  }

  $async.Future<$26.ConfirmVerificationResponse> confirmVerification_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.ConfirmVerificationRequest> request) async {
    return confirmVerification(call, await request);
  }

  $async.Future<$26.GetDocumentUploadURLResponse> getDocumentUploadURL_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.GetDocumentUploadURLRequest> request) async {
    return getDocumentUploadURL(call, await request);
  }

  $async.Future<$26.SubmitDocumentsForReviewResponse>
      submitDocumentsForReview_Pre($grpc.ServiceCall call,
          $async.Future<$26.SubmitDocumentsForReviewRequest> request) async {
    return submitDocumentsForReview(call, await request);
  }

  $async.Future<$26.GetPendingReviewsResponse> getPendingReviews_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.GetPendingReviewsRequest> request) async {
    return getPendingReviews(call, await request);
  }

  $async.Future<$26.ReviewDocumentResponse> reviewDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.ReviewDocumentRequest> request) async {
    return reviewDocument(call, await request);
  }

  $async.Future<$26.GetKYCStatusResponse> getKYCStatus(
      $grpc.ServiceCall call, $26.GetKYCStatusRequest request);
  $async.Future<$26.GetCountryRequirementsResponse> getCountryRequirements(
      $grpc.ServiceCall call, $26.GetCountryRequirementsRequest request);
  $async.Future<$26.InitiateKYCResponse> initiateKYC(
      $grpc.ServiceCall call, $26.InitiateKYCRequest request);
  $async.Future<$26.VerifyIDResponse> verifyID(
      $grpc.ServiceCall call, $26.VerifyIDRequest request);
  $async.Future<$26.VerifyIDResponse> uploadDocument(
      $grpc.ServiceCall call, $26.UploadDocumentRequest request);
  $async.Future<$26.GetUserDocumentsResponse> getUserDocuments(
      $grpc.ServiceCall call, $26.GetUserDocumentsRequest request);
  $async.Future<$26.SkipKYCResponse> skipKYCUpgrade(
      $grpc.ServiceCall call, $26.SkipKYCRequest request);
  $async.Future<$26.CreateVerificationSessionResponse>
      createVerificationSession(
          $grpc.ServiceCall call, $26.CreateVerificationSessionRequest request);
  $async.Future<$26.ConfirmVerificationResponse> confirmVerification(
      $grpc.ServiceCall call, $26.ConfirmVerificationRequest request);
  $async.Future<$26.GetDocumentUploadURLResponse> getDocumentUploadURL(
      $grpc.ServiceCall call, $26.GetDocumentUploadURLRequest request);
  $async.Future<$26.SubmitDocumentsForReviewResponse> submitDocumentsForReview(
      $grpc.ServiceCall call, $26.SubmitDocumentsForReviewRequest request);
  $async.Future<$26.GetPendingReviewsResponse> getPendingReviews(
      $grpc.ServiceCall call, $26.GetPendingReviewsRequest request);
  $async.Future<$26.ReviewDocumentResponse> reviewDocument(
      $grpc.ServiceCall call, $26.ReviewDocumentRequest request);
}
