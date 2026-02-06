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

import 'user.pb.dart' as $37;

export 'user.pb.dart';

@$pb.GrpcServiceName('pb.UserService')
class UserServiceClient extends $grpc.Client {
  static final _$createUser = $grpc.ClientMethod<$37.CreateUserRequest, $37.CreateUserResponse>(
      '/pb.UserService/CreateUser',
      ($37.CreateUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.CreateUserResponse.fromBuffer(value));
  static final _$getUserProfile = $grpc.ClientMethod<$37.GetUserProfileRequest, $37.GetUserProfileResponse>(
      '/pb.UserService/GetUserProfile',
      ($37.GetUserProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.GetUserProfileResponse.fromBuffer(value));
  static final _$updateUserProfile = $grpc.ClientMethod<$37.UpdateUserProfileRequest, $37.UpdateUserProfileResponse>(
      '/pb.UserService/UpdateUserProfile',
      ($37.UpdateUserProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.UpdateUserProfileResponse.fromBuffer(value));
  static final _$updatePassword = $grpc.ClientMethod<$37.UpdatePasswordRequest, $37.UpdatePasswordResponse>(
      '/pb.UserService/UpdatePassword',
      ($37.UpdatePasswordRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.UpdatePasswordResponse.fromBuffer(value));
  static final _$updatePreferences = $grpc.ClientMethod<$37.UpdatePreferencesRequest, $37.UpdatePreferencesResponse>(
      '/pb.UserService/UpdatePreferences',
      ($37.UpdatePreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.UpdatePreferencesResponse.fromBuffer(value));
  static final _$uploadIDDocument = $grpc.ClientMethod<$37.UploadIDDocumentRequest, $37.UploadIDDocumentResponse>(
      '/pb.UserService/UploadIDDocument',
      ($37.UploadIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.UploadIDDocumentResponse.fromBuffer(value));
  static final _$getIDDocuments = $grpc.ClientMethod<$37.GetIDDocumentsRequest, $37.GetIDDocumentsResponse>(
      '/pb.UserService/GetIDDocuments',
      ($37.GetIDDocumentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.GetIDDocumentsResponse.fromBuffer(value));
  static final _$verifyIDDocument = $grpc.ClientMethod<$37.VerifyIDDocumentRequest, $37.VerifyIDDocumentResponse>(
      '/pb.UserService/VerifyIDDocument',
      ($37.VerifyIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.VerifyIDDocumentResponse.fromBuffer(value));
  static final _$registerFace = $grpc.ClientMethod<$37.UserRegisterFaceRequest, $37.UserRegisterFaceResponse>(
      '/pb.UserService/RegisterFace',
      ($37.UserRegisterFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.UserRegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace = $grpc.ClientMethod<$37.UserVerifyFaceRequest, $37.UserVerifyFaceResponse>(
      '/pb.UserService/VerifyFace',
      ($37.UserVerifyFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.UserVerifyFaceResponse.fromBuffer(value));
  static final _$getFacialData = $grpc.ClientMethod<$37.GetFacialDataRequest, $37.GetFacialDataResponse>(
      '/pb.UserService/GetFacialData',
      ($37.GetFacialDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.GetFacialDataResponse.fromBuffer(value));
  static final _$setPasscode = $grpc.ClientMethod<$37.SetPasscodeRequest, $37.SetPasscodeResponse>(
      '/pb.UserService/SetPasscode',
      ($37.SetPasscodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.SetPasscodeResponse.fromBuffer(value));
  static final _$verifyPasscode = $grpc.ClientMethod<$37.VerifyPasscodeRequest, $37.VerifyPasscodeResponse>(
      '/pb.UserService/VerifyPasscode',
      ($37.VerifyPasscodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.VerifyPasscodeResponse.fromBuffer(value));
  static final _$removePasscode = $grpc.ClientMethod<$37.RemovePasscodeRequest, $37.RemovePasscodeResponse>(
      '/pb.UserService/RemovePasscode',
      ($37.RemovePasscodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.RemovePasscodeResponse.fromBuffer(value));
  static final _$checkPasscodeExists = $grpc.ClientMethod<$37.CheckPasscodeExistsRequest, $37.CheckPasscodeExistsResponse>(
      '/pb.UserService/CheckPasscodeExists',
      ($37.CheckPasscodeExistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.CheckPasscodeExistsResponse.fromBuffer(value));
  static final _$updateDevicePermissions = $grpc.ClientMethod<$37.UpdateDevicePermissionsRequest, $37.UpdateDevicePermissionsResponse>(
      '/pb.UserService/UpdateDevicePermissions',
      ($37.UpdateDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.UpdateDevicePermissionsResponse.fromBuffer(value));
  static final _$getDevicePermissions = $grpc.ClientMethod<$37.GetDevicePermissionsRequest, $37.GetDevicePermissionsResponse>(
      '/pb.UserService/GetDevicePermissions',
      ($37.GetDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $37.GetDevicePermissionsResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$37.CreateUserResponse> createUser($37.CreateUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetUserProfileResponse> getUserProfile($37.GetUserProfileRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$37.UpdateUserProfileResponse> updateUserProfile($37.UpdateUserProfileRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$37.UpdatePasswordResponse> updatePassword($37.UpdatePasswordRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePassword, request, options: options);
  }

  $grpc.ResponseFuture<$37.UpdatePreferencesResponse> updatePreferences($37.UpdatePreferencesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePreferences, request, options: options);
  }

  $grpc.ResponseFuture<$37.UploadIDDocumentResponse> uploadIDDocument($37.UploadIDDocumentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetIDDocumentsResponse> getIDDocuments($37.GetIDDocumentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$37.VerifyIDDocumentResponse> verifyIDDocument($37.VerifyIDDocumentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$37.UserRegisterFaceResponse> registerFace($37.UserRegisterFaceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$37.UserVerifyFaceResponse> verifyFace($37.UserVerifyFaceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetFacialDataResponse> getFacialData($37.GetFacialDataRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFacialData, request, options: options);
  }

  $grpc.ResponseFuture<$37.SetPasscodeResponse> setPasscode($37.SetPasscodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$37.VerifyPasscodeResponse> verifyPasscode($37.VerifyPasscodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$37.RemovePasscodeResponse> removePasscode($37.RemovePasscodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removePasscode, request, options: options);
  }

  $grpc.ResponseFuture<$37.CheckPasscodeExistsResponse> checkPasscodeExists($37.CheckPasscodeExistsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkPasscodeExists, request, options: options);
  }

  $grpc.ResponseFuture<$37.UpdateDevicePermissionsResponse> updateDevicePermissions($37.UpdateDevicePermissionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDevicePermissions, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetDevicePermissionsResponse> getDevicePermissions($37.GetDevicePermissionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDevicePermissions, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$37.CreateUserRequest, $37.CreateUserResponse>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.CreateUserRequest.fromBuffer(value),
        ($37.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetUserProfileRequest, $37.GetUserProfileResponse>(
        'GetUserProfile',
        getUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.GetUserProfileRequest.fromBuffer(value),
        ($37.GetUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.UpdateUserProfileRequest, $37.UpdateUserProfileResponse>(
        'UpdateUserProfile',
        updateUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.UpdateUserProfileRequest.fromBuffer(value),
        ($37.UpdateUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.UpdatePasswordRequest, $37.UpdatePasswordResponse>(
        'UpdatePassword',
        updatePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.UpdatePasswordRequest.fromBuffer(value),
        ($37.UpdatePasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.UpdatePreferencesRequest, $37.UpdatePreferencesResponse>(
        'UpdatePreferences',
        updatePreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.UpdatePreferencesRequest.fromBuffer(value),
        ($37.UpdatePreferencesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.UploadIDDocumentRequest, $37.UploadIDDocumentResponse>(
        'UploadIDDocument',
        uploadIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.UploadIDDocumentRequest.fromBuffer(value),
        ($37.UploadIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetIDDocumentsRequest, $37.GetIDDocumentsResponse>(
        'GetIDDocuments',
        getIDDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.GetIDDocumentsRequest.fromBuffer(value),
        ($37.GetIDDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.VerifyIDDocumentRequest, $37.VerifyIDDocumentResponse>(
        'VerifyIDDocument',
        verifyIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.VerifyIDDocumentRequest.fromBuffer(value),
        ($37.VerifyIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.UserRegisterFaceRequest, $37.UserRegisterFaceResponse>(
        'RegisterFace',
        registerFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.UserRegisterFaceRequest.fromBuffer(value),
        ($37.UserRegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.UserVerifyFaceRequest, $37.UserVerifyFaceResponse>(
        'VerifyFace',
        verifyFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.UserVerifyFaceRequest.fromBuffer(value),
        ($37.UserVerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetFacialDataRequest, $37.GetFacialDataResponse>(
        'GetFacialData',
        getFacialData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.GetFacialDataRequest.fromBuffer(value),
        ($37.GetFacialDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.SetPasscodeRequest, $37.SetPasscodeResponse>(
        'SetPasscode',
        setPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.SetPasscodeRequest.fromBuffer(value),
        ($37.SetPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.VerifyPasscodeRequest, $37.VerifyPasscodeResponse>(
        'VerifyPasscode',
        verifyPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.VerifyPasscodeRequest.fromBuffer(value),
        ($37.VerifyPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.RemovePasscodeRequest, $37.RemovePasscodeResponse>(
        'RemovePasscode',
        removePasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.RemovePasscodeRequest.fromBuffer(value),
        ($37.RemovePasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.CheckPasscodeExistsRequest, $37.CheckPasscodeExistsResponse>(
        'CheckPasscodeExists',
        checkPasscodeExists_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.CheckPasscodeExistsRequest.fromBuffer(value),
        ($37.CheckPasscodeExistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.UpdateDevicePermissionsRequest, $37.UpdateDevicePermissionsResponse>(
        'UpdateDevicePermissions',
        updateDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.UpdateDevicePermissionsRequest.fromBuffer(value),
        ($37.UpdateDevicePermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetDevicePermissionsRequest, $37.GetDevicePermissionsResponse>(
        'GetDevicePermissions',
        getDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $37.GetDevicePermissionsRequest.fromBuffer(value),
        ($37.GetDevicePermissionsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$37.CreateUserResponse> createUser_Pre($grpc.ServiceCall call, $async.Future<$37.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$37.GetUserProfileResponse> getUserProfile_Pre($grpc.ServiceCall call, $async.Future<$37.GetUserProfileRequest> request) async {
    return getUserProfile(call, await request);
  }

  $async.Future<$37.UpdateUserProfileResponse> updateUserProfile_Pre($grpc.ServiceCall call, $async.Future<$37.UpdateUserProfileRequest> request) async {
    return updateUserProfile(call, await request);
  }

  $async.Future<$37.UpdatePasswordResponse> updatePassword_Pre($grpc.ServiceCall call, $async.Future<$37.UpdatePasswordRequest> request) async {
    return updatePassword(call, await request);
  }

  $async.Future<$37.UpdatePreferencesResponse> updatePreferences_Pre($grpc.ServiceCall call, $async.Future<$37.UpdatePreferencesRequest> request) async {
    return updatePreferences(call, await request);
  }

  $async.Future<$37.UploadIDDocumentResponse> uploadIDDocument_Pre($grpc.ServiceCall call, $async.Future<$37.UploadIDDocumentRequest> request) async {
    return uploadIDDocument(call, await request);
  }

  $async.Future<$37.GetIDDocumentsResponse> getIDDocuments_Pre($grpc.ServiceCall call, $async.Future<$37.GetIDDocumentsRequest> request) async {
    return getIDDocuments(call, await request);
  }

  $async.Future<$37.VerifyIDDocumentResponse> verifyIDDocument_Pre($grpc.ServiceCall call, $async.Future<$37.VerifyIDDocumentRequest> request) async {
    return verifyIDDocument(call, await request);
  }

  $async.Future<$37.UserRegisterFaceResponse> registerFace_Pre($grpc.ServiceCall call, $async.Future<$37.UserRegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$37.UserVerifyFaceResponse> verifyFace_Pre($grpc.ServiceCall call, $async.Future<$37.UserVerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$37.GetFacialDataResponse> getFacialData_Pre($grpc.ServiceCall call, $async.Future<$37.GetFacialDataRequest> request) async {
    return getFacialData(call, await request);
  }

  $async.Future<$37.SetPasscodeResponse> setPasscode_Pre($grpc.ServiceCall call, $async.Future<$37.SetPasscodeRequest> request) async {
    return setPasscode(call, await request);
  }

  $async.Future<$37.VerifyPasscodeResponse> verifyPasscode_Pre($grpc.ServiceCall call, $async.Future<$37.VerifyPasscodeRequest> request) async {
    return verifyPasscode(call, await request);
  }

  $async.Future<$37.RemovePasscodeResponse> removePasscode_Pre($grpc.ServiceCall call, $async.Future<$37.RemovePasscodeRequest> request) async {
    return removePasscode(call, await request);
  }

  $async.Future<$37.CheckPasscodeExistsResponse> checkPasscodeExists_Pre($grpc.ServiceCall call, $async.Future<$37.CheckPasscodeExistsRequest> request) async {
    return checkPasscodeExists(call, await request);
  }

  $async.Future<$37.UpdateDevicePermissionsResponse> updateDevicePermissions_Pre($grpc.ServiceCall call, $async.Future<$37.UpdateDevicePermissionsRequest> request) async {
    return updateDevicePermissions(call, await request);
  }

  $async.Future<$37.GetDevicePermissionsResponse> getDevicePermissions_Pre($grpc.ServiceCall call, $async.Future<$37.GetDevicePermissionsRequest> request) async {
    return getDevicePermissions(call, await request);
  }

  $async.Future<$37.CreateUserResponse> createUser($grpc.ServiceCall call, $37.CreateUserRequest request);
  $async.Future<$37.GetUserProfileResponse> getUserProfile($grpc.ServiceCall call, $37.GetUserProfileRequest request);
  $async.Future<$37.UpdateUserProfileResponse> updateUserProfile($grpc.ServiceCall call, $37.UpdateUserProfileRequest request);
  $async.Future<$37.UpdatePasswordResponse> updatePassword($grpc.ServiceCall call, $37.UpdatePasswordRequest request);
  $async.Future<$37.UpdatePreferencesResponse> updatePreferences($grpc.ServiceCall call, $37.UpdatePreferencesRequest request);
  $async.Future<$37.UploadIDDocumentResponse> uploadIDDocument($grpc.ServiceCall call, $37.UploadIDDocumentRequest request);
  $async.Future<$37.GetIDDocumentsResponse> getIDDocuments($grpc.ServiceCall call, $37.GetIDDocumentsRequest request);
  $async.Future<$37.VerifyIDDocumentResponse> verifyIDDocument($grpc.ServiceCall call, $37.VerifyIDDocumentRequest request);
  $async.Future<$37.UserRegisterFaceResponse> registerFace($grpc.ServiceCall call, $37.UserRegisterFaceRequest request);
  $async.Future<$37.UserVerifyFaceResponse> verifyFace($grpc.ServiceCall call, $37.UserVerifyFaceRequest request);
  $async.Future<$37.GetFacialDataResponse> getFacialData($grpc.ServiceCall call, $37.GetFacialDataRequest request);
  $async.Future<$37.SetPasscodeResponse> setPasscode($grpc.ServiceCall call, $37.SetPasscodeRequest request);
  $async.Future<$37.VerifyPasscodeResponse> verifyPasscode($grpc.ServiceCall call, $37.VerifyPasscodeRequest request);
  $async.Future<$37.RemovePasscodeResponse> removePasscode($grpc.ServiceCall call, $37.RemovePasscodeRequest request);
  $async.Future<$37.CheckPasscodeExistsResponse> checkPasscodeExists($grpc.ServiceCall call, $37.CheckPasscodeExistsRequest request);
  $async.Future<$37.UpdateDevicePermissionsResponse> updateDevicePermissions($grpc.ServiceCall call, $37.UpdateDevicePermissionsRequest request);
  $async.Future<$37.GetDevicePermissionsResponse> getDevicePermissions($grpc.ServiceCall call, $37.GetDevicePermissionsRequest request);
}
