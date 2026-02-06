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

import 'kyc.pb.dart' as $25;

export 'kyc.pb.dart';

@$pb.GrpcServiceName('kyc.KYCService')
class KYCServiceClient extends $grpc.Client {
  static final _$getKYCStatus = $grpc.ClientMethod<$25.GetKYCStatusRequest, $25.GetKYCStatusResponse>(
      '/kyc.KYCService/GetKYCStatus',
      ($25.GetKYCStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $25.GetKYCStatusResponse.fromBuffer(value));
  static final _$getCountryRequirements = $grpc.ClientMethod<$25.GetCountryRequirementsRequest, $25.GetCountryRequirementsResponse>(
      '/kyc.KYCService/GetCountryRequirements',
      ($25.GetCountryRequirementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $25.GetCountryRequirementsResponse.fromBuffer(value));
  static final _$initiateKYC = $grpc.ClientMethod<$25.InitiateKYCRequest, $25.InitiateKYCResponse>(
      '/kyc.KYCService/InitiateKYC',
      ($25.InitiateKYCRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $25.InitiateKYCResponse.fromBuffer(value));
  static final _$verifyID = $grpc.ClientMethod<$25.VerifyIDRequest, $25.VerifyIDResponse>(
      '/kyc.KYCService/VerifyID',
      ($25.VerifyIDRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $25.VerifyIDResponse.fromBuffer(value));
  static final _$uploadDocument = $grpc.ClientMethod<$25.UploadDocumentRequest, $25.VerifyIDResponse>(
      '/kyc.KYCService/UploadDocument',
      ($25.UploadDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $25.VerifyIDResponse.fromBuffer(value));
  static final _$getUserDocuments = $grpc.ClientMethod<$25.GetUserDocumentsRequest, $25.GetUserDocumentsResponse>(
      '/kyc.KYCService/GetUserDocuments',
      ($25.GetUserDocumentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $25.GetUserDocumentsResponse.fromBuffer(value));
  static final _$skipKYCUpgrade = $grpc.ClientMethod<$25.SkipKYCRequest, $25.SkipKYCResponse>(
      '/kyc.KYCService/SkipKYCUpgrade',
      ($25.SkipKYCRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $25.SkipKYCResponse.fromBuffer(value));

  KYCServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$25.GetKYCStatusResponse> getKYCStatus($25.GetKYCStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getKYCStatus, request, options: options);
  }

  $grpc.ResponseFuture<$25.GetCountryRequirementsResponse> getCountryRequirements($25.GetCountryRequirementsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCountryRequirements, request, options: options);
  }

  $grpc.ResponseFuture<$25.InitiateKYCResponse> initiateKYC($25.InitiateKYCRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateKYC, request, options: options);
  }

  $grpc.ResponseFuture<$25.VerifyIDResponse> verifyID($25.VerifyIDRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyID, request, options: options);
  }

  $grpc.ResponseFuture<$25.VerifyIDResponse> uploadDocument($25.UploadDocumentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadDocument, request, options: options);
  }

  $grpc.ResponseFuture<$25.GetUserDocumentsResponse> getUserDocuments($25.GetUserDocumentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$25.SkipKYCResponse> skipKYCUpgrade($25.SkipKYCRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$skipKYCUpgrade, request, options: options);
  }
}

@$pb.GrpcServiceName('kyc.KYCService')
abstract class KYCServiceBase extends $grpc.Service {
  $core.String get $name => 'kyc.KYCService';

  KYCServiceBase() {
    $addMethod($grpc.ServiceMethod<$25.GetKYCStatusRequest, $25.GetKYCStatusResponse>(
        'GetKYCStatus',
        getKYCStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $25.GetKYCStatusRequest.fromBuffer(value),
        ($25.GetKYCStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetCountryRequirementsRequest, $25.GetCountryRequirementsResponse>(
        'GetCountryRequirements',
        getCountryRequirements_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $25.GetCountryRequirementsRequest.fromBuffer(value),
        ($25.GetCountryRequirementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.InitiateKYCRequest, $25.InitiateKYCResponse>(
        'InitiateKYC',
        initiateKYC_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $25.InitiateKYCRequest.fromBuffer(value),
        ($25.InitiateKYCResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.VerifyIDRequest, $25.VerifyIDResponse>(
        'VerifyID',
        verifyID_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $25.VerifyIDRequest.fromBuffer(value),
        ($25.VerifyIDResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.UploadDocumentRequest, $25.VerifyIDResponse>(
        'UploadDocument',
        uploadDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $25.UploadDocumentRequest.fromBuffer(value),
        ($25.VerifyIDResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetUserDocumentsRequest, $25.GetUserDocumentsResponse>(
        'GetUserDocuments',
        getUserDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $25.GetUserDocumentsRequest.fromBuffer(value),
        ($25.GetUserDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.SkipKYCRequest, $25.SkipKYCResponse>(
        'SkipKYCUpgrade',
        skipKYCUpgrade_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $25.SkipKYCRequest.fromBuffer(value),
        ($25.SkipKYCResponse value) => value.writeToBuffer()));
  }

  $async.Future<$25.GetKYCStatusResponse> getKYCStatus_Pre($grpc.ServiceCall call, $async.Future<$25.GetKYCStatusRequest> request) async {
    return getKYCStatus(call, await request);
  }

  $async.Future<$25.GetCountryRequirementsResponse> getCountryRequirements_Pre($grpc.ServiceCall call, $async.Future<$25.GetCountryRequirementsRequest> request) async {
    return getCountryRequirements(call, await request);
  }

  $async.Future<$25.InitiateKYCResponse> initiateKYC_Pre($grpc.ServiceCall call, $async.Future<$25.InitiateKYCRequest> request) async {
    return initiateKYC(call, await request);
  }

  $async.Future<$25.VerifyIDResponse> verifyID_Pre($grpc.ServiceCall call, $async.Future<$25.VerifyIDRequest> request) async {
    return verifyID(call, await request);
  }

  $async.Future<$25.VerifyIDResponse> uploadDocument_Pre($grpc.ServiceCall call, $async.Future<$25.UploadDocumentRequest> request) async {
    return uploadDocument(call, await request);
  }

  $async.Future<$25.GetUserDocumentsResponse> getUserDocuments_Pre($grpc.ServiceCall call, $async.Future<$25.GetUserDocumentsRequest> request) async {
    return getUserDocuments(call, await request);
  }

  $async.Future<$25.SkipKYCResponse> skipKYCUpgrade_Pre($grpc.ServiceCall call, $async.Future<$25.SkipKYCRequest> request) async {
    return skipKYCUpgrade(call, await request);
  }

  $async.Future<$25.GetKYCStatusResponse> getKYCStatus($grpc.ServiceCall call, $25.GetKYCStatusRequest request);
  $async.Future<$25.GetCountryRequirementsResponse> getCountryRequirements($grpc.ServiceCall call, $25.GetCountryRequirementsRequest request);
  $async.Future<$25.InitiateKYCResponse> initiateKYC($grpc.ServiceCall call, $25.InitiateKYCRequest request);
  $async.Future<$25.VerifyIDResponse> verifyID($grpc.ServiceCall call, $25.VerifyIDRequest request);
  $async.Future<$25.VerifyIDResponse> uploadDocument($grpc.ServiceCall call, $25.UploadDocumentRequest request);
  $async.Future<$25.GetUserDocumentsResponse> getUserDocuments($grpc.ServiceCall call, $25.GetUserDocumentsRequest request);
  $async.Future<$25.SkipKYCResponse> skipKYCUpgrade($grpc.ServiceCall call, $25.SkipKYCRequest request);
}
