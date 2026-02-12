//
//  Generated code. Do not modify.
//  source: user.proto
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

import 'user.pb.dart' as $0;

export 'user.pb.dart';

@$pb.GrpcServiceName('pb.UserService')
class UserServiceClient extends $grpc.Client {
  static final _$createUser = $grpc.ClientMethod<$0.CreateUserRequest, $0.CreateUserResponse>(
      '/pb.UserService/CreateUser',
      ($0.CreateUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateUserResponse.fromBuffer(value));
  static final _$getUserProfile = $grpc.ClientMethod<$0.GetUserProfileRequest, $0.GetUserProfileResponse>(
      '/pb.UserService/GetUserProfile',
      ($0.GetUserProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserProfileResponse.fromBuffer(value));
  static final _$updateUserProfile = $grpc.ClientMethod<$0.UpdateUserProfileRequest, $0.UpdateUserProfileResponse>(
      '/pb.UserService/UpdateUserProfile',
      ($0.UpdateUserProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateUserProfileResponse.fromBuffer(value));
  static final _$updatePassword = $grpc.ClientMethod<$0.UpdatePasswordRequest, $0.UpdatePasswordResponse>(
      '/pb.UserService/UpdatePassword',
      ($0.UpdatePasswordRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdatePasswordResponse.fromBuffer(value));
  static final _$updatePreferences = $grpc.ClientMethod<$0.UpdatePreferencesRequest, $0.UpdatePreferencesResponse>(
      '/pb.UserService/UpdatePreferences',
      ($0.UpdatePreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdatePreferencesResponse.fromBuffer(value));
  static final _$uploadIDDocument = $grpc.ClientMethod<$0.UploadIDDocumentRequest, $0.UploadIDDocumentResponse>(
      '/pb.UserService/UploadIDDocument',
      ($0.UploadIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UploadIDDocumentResponse.fromBuffer(value));
  static final _$getIDDocuments = $grpc.ClientMethod<$0.GetIDDocumentsRequest, $0.GetIDDocumentsResponse>(
      '/pb.UserService/GetIDDocuments',
      ($0.GetIDDocumentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetIDDocumentsResponse.fromBuffer(value));
  static final _$verifyIDDocument = $grpc.ClientMethod<$0.VerifyIDDocumentRequest, $0.VerifyIDDocumentResponse>(
      '/pb.UserService/VerifyIDDocument',
      ($0.VerifyIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyIDDocumentResponse.fromBuffer(value));
  static final _$registerFace = $grpc.ClientMethod<$0.UserRegisterFaceRequest, $0.UserRegisterFaceResponse>(
      '/pb.UserService/RegisterFace',
      ($0.UserRegisterFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UserRegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace = $grpc.ClientMethod<$0.UserVerifyFaceRequest, $0.UserVerifyFaceResponse>(
      '/pb.UserService/VerifyFace',
      ($0.UserVerifyFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UserVerifyFaceResponse.fromBuffer(value));
  static final _$getFacialData = $grpc.ClientMethod<$0.GetFacialDataRequest, $0.GetFacialDataResponse>(
      '/pb.UserService/GetFacialData',
      ($0.GetFacialDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetFacialDataResponse.fromBuffer(value));
  static final _$setPasscode = $grpc.ClientMethod<$0.SetPasscodeRequest, $0.SetPasscodeResponse>(
      '/pb.UserService/SetPasscode',
      ($0.SetPasscodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SetPasscodeResponse.fromBuffer(value));
  static final _$verifyPasscode = $grpc.ClientMethod<$0.VerifyPasscodeRequest, $0.VerifyPasscodeResponse>(
      '/pb.UserService/VerifyPasscode',
      ($0.VerifyPasscodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyPasscodeResponse.fromBuffer(value));
  static final _$removePasscode = $grpc.ClientMethod<$0.RemovePasscodeRequest, $0.RemovePasscodeResponse>(
      '/pb.UserService/RemovePasscode',
      ($0.RemovePasscodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RemovePasscodeResponse.fromBuffer(value));
  static final _$checkPasscodeExists = $grpc.ClientMethod<$0.CheckPasscodeExistsRequest, $0.CheckPasscodeExistsResponse>(
      '/pb.UserService/CheckPasscodeExists',
      ($0.CheckPasscodeExistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CheckPasscodeExistsResponse.fromBuffer(value));
  static final _$updateDevicePermissions = $grpc.ClientMethod<$0.UpdateDevicePermissionsRequest, $0.UpdateDevicePermissionsResponse>(
      '/pb.UserService/UpdateDevicePermissions',
      ($0.UpdateDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateDevicePermissionsResponse.fromBuffer(value));
  static final _$getDevicePermissions = $grpc.ClientMethod<$0.GetDevicePermissionsRequest, $0.GetDevicePermissionsResponse>(
      '/pb.UserService/GetDevicePermissions',
      ($0.GetDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetDevicePermissionsResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateUserResponse> createUser($0.CreateUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserProfileResponse> getUserProfile($0.GetUserProfileRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateUserProfileResponse> updateUserProfile($0.UpdateUserProfileRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdatePasswordResponse> updatePassword($0.UpdatePasswordRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePassword, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdatePreferencesResponse> updatePreferences($0.UpdatePreferencesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePreferences, request, options: options);
  }

  $grpc.ResponseFuture<$0.UploadIDDocumentResponse> uploadIDDocument($0.UploadIDDocumentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetIDDocumentsResponse> getIDDocuments($0.GetIDDocumentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyIDDocumentResponse> verifyIDDocument($0.VerifyIDDocumentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserRegisterFaceResponse> registerFace($0.UserRegisterFaceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserVerifyFaceResponse> verifyFace($0.UserVerifyFaceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFacialDataResponse> getFacialData($0.GetFacialDataRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFacialData, request, options: options);
  }

  $grpc.ResponseFuture<$0.SetPasscodeResponse> setPasscode($0.SetPasscodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyPasscodeResponse> verifyPasscode($0.VerifyPasscodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$0.RemovePasscodeResponse> removePasscode($0.RemovePasscodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removePasscode, request, options: options);
  }

  $grpc.ResponseFuture<$0.CheckPasscodeExistsResponse> checkPasscodeExists($0.CheckPasscodeExistsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkPasscodeExists, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateDevicePermissionsResponse> updateDevicePermissions($0.UpdateDevicePermissionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDevicePermissions, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDevicePermissionsResponse> getDevicePermissions($0.GetDevicePermissionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDevicePermissions, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateUserRequest, $0.CreateUserResponse>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateUserRequest.fromBuffer(value),
        ($0.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserProfileRequest, $0.GetUserProfileResponse>(
        'GetUserProfile',
        getUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserProfileRequest.fromBuffer(value),
        ($0.GetUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateUserProfileRequest, $0.UpdateUserProfileResponse>(
        'UpdateUserProfile',
        updateUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateUserProfileRequest.fromBuffer(value),
        ($0.UpdateUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdatePasswordRequest, $0.UpdatePasswordResponse>(
        'UpdatePassword',
        updatePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdatePasswordRequest.fromBuffer(value),
        ($0.UpdatePasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdatePreferencesRequest, $0.UpdatePreferencesResponse>(
        'UpdatePreferences',
        updatePreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdatePreferencesRequest.fromBuffer(value),
        ($0.UpdatePreferencesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadIDDocumentRequest, $0.UploadIDDocumentResponse>(
        'UploadIDDocument',
        uploadIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UploadIDDocumentRequest.fromBuffer(value),
        ($0.UploadIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetIDDocumentsRequest, $0.GetIDDocumentsResponse>(
        'GetIDDocuments',
        getIDDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetIDDocumentsRequest.fromBuffer(value),
        ($0.GetIDDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyIDDocumentRequest, $0.VerifyIDDocumentResponse>(
        'VerifyIDDocument',
        verifyIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyIDDocumentRequest.fromBuffer(value),
        ($0.VerifyIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UserRegisterFaceRequest, $0.UserRegisterFaceResponse>(
        'RegisterFace',
        registerFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UserRegisterFaceRequest.fromBuffer(value),
        ($0.UserRegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UserVerifyFaceRequest, $0.UserVerifyFaceResponse>(
        'VerifyFace',
        verifyFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UserVerifyFaceRequest.fromBuffer(value),
        ($0.UserVerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFacialDataRequest, $0.GetFacialDataResponse>(
        'GetFacialData',
        getFacialData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetFacialDataRequest.fromBuffer(value),
        ($0.GetFacialDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetPasscodeRequest, $0.SetPasscodeResponse>(
        'SetPasscode',
        setPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SetPasscodeRequest.fromBuffer(value),
        ($0.SetPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyPasscodeRequest, $0.VerifyPasscodeResponse>(
        'VerifyPasscode',
        verifyPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyPasscodeRequest.fromBuffer(value),
        ($0.VerifyPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemovePasscodeRequest, $0.RemovePasscodeResponse>(
        'RemovePasscode',
        removePasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RemovePasscodeRequest.fromBuffer(value),
        ($0.RemovePasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CheckPasscodeExistsRequest, $0.CheckPasscodeExistsResponse>(
        'CheckPasscodeExists',
        checkPasscodeExists_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CheckPasscodeExistsRequest.fromBuffer(value),
        ($0.CheckPasscodeExistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateDevicePermissionsRequest, $0.UpdateDevicePermissionsResponse>(
        'UpdateDevicePermissions',
        updateDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateDevicePermissionsRequest.fromBuffer(value),
        ($0.UpdateDevicePermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDevicePermissionsRequest, $0.GetDevicePermissionsResponse>(
        'GetDevicePermissions',
        getDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetDevicePermissionsRequest.fromBuffer(value),
        ($0.GetDevicePermissionsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateUserResponse> createUser_Pre($grpc.ServiceCall call, $async.Future<$0.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$0.GetUserProfileResponse> getUserProfile_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserProfileRequest> request) async {
    return getUserProfile(call, await request);
  }

  $async.Future<$0.UpdateUserProfileResponse> updateUserProfile_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateUserProfileRequest> request) async {
    return updateUserProfile(call, await request);
  }

  $async.Future<$0.UpdatePasswordResponse> updatePassword_Pre($grpc.ServiceCall call, $async.Future<$0.UpdatePasswordRequest> request) async {
    return updatePassword(call, await request);
  }

  $async.Future<$0.UpdatePreferencesResponse> updatePreferences_Pre($grpc.ServiceCall call, $async.Future<$0.UpdatePreferencesRequest> request) async {
    return updatePreferences(call, await request);
  }

  $async.Future<$0.UploadIDDocumentResponse> uploadIDDocument_Pre($grpc.ServiceCall call, $async.Future<$0.UploadIDDocumentRequest> request) async {
    return uploadIDDocument(call, await request);
  }

  $async.Future<$0.GetIDDocumentsResponse> getIDDocuments_Pre($grpc.ServiceCall call, $async.Future<$0.GetIDDocumentsRequest> request) async {
    return getIDDocuments(call, await request);
  }

  $async.Future<$0.VerifyIDDocumentResponse> verifyIDDocument_Pre($grpc.ServiceCall call, $async.Future<$0.VerifyIDDocumentRequest> request) async {
    return verifyIDDocument(call, await request);
  }

  $async.Future<$0.UserRegisterFaceResponse> registerFace_Pre($grpc.ServiceCall call, $async.Future<$0.UserRegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$0.UserVerifyFaceResponse> verifyFace_Pre($grpc.ServiceCall call, $async.Future<$0.UserVerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$0.GetFacialDataResponse> getFacialData_Pre($grpc.ServiceCall call, $async.Future<$0.GetFacialDataRequest> request) async {
    return getFacialData(call, await request);
  }

  $async.Future<$0.SetPasscodeResponse> setPasscode_Pre($grpc.ServiceCall call, $async.Future<$0.SetPasscodeRequest> request) async {
    return setPasscode(call, await request);
  }

  $async.Future<$0.VerifyPasscodeResponse> verifyPasscode_Pre($grpc.ServiceCall call, $async.Future<$0.VerifyPasscodeRequest> request) async {
    return verifyPasscode(call, await request);
  }

  $async.Future<$0.RemovePasscodeResponse> removePasscode_Pre($grpc.ServiceCall call, $async.Future<$0.RemovePasscodeRequest> request) async {
    return removePasscode(call, await request);
  }

  $async.Future<$0.CheckPasscodeExistsResponse> checkPasscodeExists_Pre($grpc.ServiceCall call, $async.Future<$0.CheckPasscodeExistsRequest> request) async {
    return checkPasscodeExists(call, await request);
  }

  $async.Future<$0.UpdateDevicePermissionsResponse> updateDevicePermissions_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateDevicePermissionsRequest> request) async {
    return updateDevicePermissions(call, await request);
  }

  $async.Future<$0.GetDevicePermissionsResponse> getDevicePermissions_Pre($grpc.ServiceCall call, $async.Future<$0.GetDevicePermissionsRequest> request) async {
    return getDevicePermissions(call, await request);
  }

  $async.Future<$0.CreateUserResponse> createUser($grpc.ServiceCall call, $0.CreateUserRequest request);
  $async.Future<$0.GetUserProfileResponse> getUserProfile($grpc.ServiceCall call, $0.GetUserProfileRequest request);
  $async.Future<$0.UpdateUserProfileResponse> updateUserProfile($grpc.ServiceCall call, $0.UpdateUserProfileRequest request);
  $async.Future<$0.UpdatePasswordResponse> updatePassword($grpc.ServiceCall call, $0.UpdatePasswordRequest request);
  $async.Future<$0.UpdatePreferencesResponse> updatePreferences($grpc.ServiceCall call, $0.UpdatePreferencesRequest request);
  $async.Future<$0.UploadIDDocumentResponse> uploadIDDocument($grpc.ServiceCall call, $0.UploadIDDocumentRequest request);
  $async.Future<$0.GetIDDocumentsResponse> getIDDocuments($grpc.ServiceCall call, $0.GetIDDocumentsRequest request);
  $async.Future<$0.VerifyIDDocumentResponse> verifyIDDocument($grpc.ServiceCall call, $0.VerifyIDDocumentRequest request);
  $async.Future<$0.UserRegisterFaceResponse> registerFace($grpc.ServiceCall call, $0.UserRegisterFaceRequest request);
  $async.Future<$0.UserVerifyFaceResponse> verifyFace($grpc.ServiceCall call, $0.UserVerifyFaceRequest request);
  $async.Future<$0.GetFacialDataResponse> getFacialData($grpc.ServiceCall call, $0.GetFacialDataRequest request);
  $async.Future<$0.SetPasscodeResponse> setPasscode($grpc.ServiceCall call, $0.SetPasscodeRequest request);
  $async.Future<$0.VerifyPasscodeResponse> verifyPasscode($grpc.ServiceCall call, $0.VerifyPasscodeRequest request);
  $async.Future<$0.RemovePasscodeResponse> removePasscode($grpc.ServiceCall call, $0.RemovePasscodeRequest request);
  $async.Future<$0.CheckPasscodeExistsResponse> checkPasscodeExists($grpc.ServiceCall call, $0.CheckPasscodeExistsRequest request);
  $async.Future<$0.UpdateDevicePermissionsResponse> updateDevicePermissions($grpc.ServiceCall call, $0.UpdateDevicePermissionsRequest request);
  $async.Future<$0.GetDevicePermissionsResponse> getDevicePermissions($grpc.ServiceCall call, $0.GetDevicePermissionsRequest request);
}
