///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $41;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$createUser =
      $grpc.ClientMethod<$41.CreateUserRequest, $41.CreateUserResponse>(
          '/pb.UserService/CreateUser',
          ($41.CreateUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $41.CreateUserResponse.fromBuffer(value));
  static final _$getUserProfile =
      $grpc.ClientMethod<$41.GetUserProfileRequest, $41.GetUserProfileResponse>(
          '/pb.UserService/GetUserProfile',
          ($41.GetUserProfileRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $41.GetUserProfileResponse.fromBuffer(value));
  static final _$updateUserProfile = $grpc.ClientMethod<
          $41.UpdateUserProfileRequest, $41.UpdateUserProfileResponse>(
      '/pb.UserService/UpdateUserProfile',
      ($41.UpdateUserProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.UpdateUserProfileResponse.fromBuffer(value));
  static final _$updatePassword =
      $grpc.ClientMethod<$41.UpdatePasswordRequest, $41.UpdatePasswordResponse>(
          '/pb.UserService/UpdatePassword',
          ($41.UpdatePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $41.UpdatePasswordResponse.fromBuffer(value));
  static final _$updatePreferences = $grpc.ClientMethod<
          $41.UpdatePreferencesRequest, $41.UpdatePreferencesResponse>(
      '/pb.UserService/UpdatePreferences',
      ($41.UpdatePreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.UpdatePreferencesResponse.fromBuffer(value));
  static final _$uploadIDDocument = $grpc.ClientMethod<
          $41.UploadIDDocumentRequest, $41.UploadIDDocumentResponse>(
      '/pb.UserService/UploadIDDocument',
      ($41.UploadIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.UploadIDDocumentResponse.fromBuffer(value));
  static final _$getIDDocuments =
      $grpc.ClientMethod<$41.GetIDDocumentsRequest, $41.GetIDDocumentsResponse>(
          '/pb.UserService/GetIDDocuments',
          ($41.GetIDDocumentsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $41.GetIDDocumentsResponse.fromBuffer(value));
  static final _$verifyIDDocument = $grpc.ClientMethod<
          $41.VerifyIDDocumentRequest, $41.VerifyIDDocumentResponse>(
      '/pb.UserService/VerifyIDDocument',
      ($41.VerifyIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.VerifyIDDocumentResponse.fromBuffer(value));
  static final _$registerFace = $grpc.ClientMethod<$41.UserRegisterFaceRequest,
          $41.UserRegisterFaceResponse>(
      '/pb.UserService/RegisterFace',
      ($41.UserRegisterFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.UserRegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace =
      $grpc.ClientMethod<$41.UserVerifyFaceRequest, $41.UserVerifyFaceResponse>(
          '/pb.UserService/VerifyFace',
          ($41.UserVerifyFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $41.UserVerifyFaceResponse.fromBuffer(value));
  static final _$getFacialData =
      $grpc.ClientMethod<$41.GetFacialDataRequest, $41.GetFacialDataResponse>(
          '/pb.UserService/GetFacialData',
          ($41.GetFacialDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $41.GetFacialDataResponse.fromBuffer(value));
  static final _$setPasscode =
      $grpc.ClientMethod<$41.SetPasscodeRequest, $41.SetPasscodeResponse>(
          '/pb.UserService/SetPasscode',
          ($41.SetPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $41.SetPasscodeResponse.fromBuffer(value));
  static final _$verifyPasscode =
      $grpc.ClientMethod<$41.VerifyPasscodeRequest, $41.VerifyPasscodeResponse>(
          '/pb.UserService/VerifyPasscode',
          ($41.VerifyPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $41.VerifyPasscodeResponse.fromBuffer(value));
  static final _$removePasscode =
      $grpc.ClientMethod<$41.RemovePasscodeRequest, $41.RemovePasscodeResponse>(
          '/pb.UserService/RemovePasscode',
          ($41.RemovePasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $41.RemovePasscodeResponse.fromBuffer(value));
  static final _$checkPasscodeExists = $grpc.ClientMethod<
          $41.CheckPasscodeExistsRequest, $41.CheckPasscodeExistsResponse>(
      '/pb.UserService/CheckPasscodeExists',
      ($41.CheckPasscodeExistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.CheckPasscodeExistsResponse.fromBuffer(value));
  static final _$updateDevicePermissions = $grpc.ClientMethod<
          $41.UpdateDevicePermissionsRequest,
          $41.UpdateDevicePermissionsResponse>(
      '/pb.UserService/UpdateDevicePermissions',
      ($41.UpdateDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.UpdateDevicePermissionsResponse.fromBuffer(value));
  static final _$getDevicePermissions = $grpc.ClientMethod<
          $41.GetDevicePermissionsRequest, $41.GetDevicePermissionsResponse>(
      '/pb.UserService/GetDevicePermissions',
      ($41.GetDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.GetDevicePermissionsResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$41.CreateUserResponse> createUser(
      $41.CreateUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$41.GetUserProfileResponse> getUserProfile(
      $41.GetUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$41.UpdateUserProfileResponse> updateUserProfile(
      $41.UpdateUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$41.UpdatePasswordResponse> updatePassword(
      $41.UpdatePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePassword, request, options: options);
  }

  $grpc.ResponseFuture<$41.UpdatePreferencesResponse> updatePreferences(
      $41.UpdatePreferencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePreferences, request, options: options);
  }

  $grpc.ResponseFuture<$41.UploadIDDocumentResponse> uploadIDDocument(
      $41.UploadIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$41.GetIDDocumentsResponse> getIDDocuments(
      $41.GetIDDocumentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$41.VerifyIDDocumentResponse> verifyIDDocument(
      $41.VerifyIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$41.UserRegisterFaceResponse> registerFace(
      $41.UserRegisterFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$41.UserVerifyFaceResponse> verifyFace(
      $41.UserVerifyFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$41.GetFacialDataResponse> getFacialData(
      $41.GetFacialDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFacialData, request, options: options);
  }

  $grpc.ResponseFuture<$41.SetPasscodeResponse> setPasscode(
      $41.SetPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$41.VerifyPasscodeResponse> verifyPasscode(
      $41.VerifyPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$41.RemovePasscodeResponse> removePasscode(
      $41.RemovePasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removePasscode, request, options: options);
  }

  $grpc.ResponseFuture<$41.CheckPasscodeExistsResponse> checkPasscodeExists(
      $41.CheckPasscodeExistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkPasscodeExists, request, options: options);
  }

  $grpc.ResponseFuture<$41.UpdateDevicePermissionsResponse>
      updateDevicePermissions($41.UpdateDevicePermissionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDevicePermissions, request,
        options: options);
  }

  $grpc.ResponseFuture<$41.GetDevicePermissionsResponse> getDevicePermissions(
      $41.GetDevicePermissionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDevicePermissions, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UserService';

  UserServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$41.CreateUserRequest, $41.CreateUserResponse>(
            'CreateUser',
            createUser_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $41.CreateUserRequest.fromBuffer(value),
            ($41.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.GetUserProfileRequest,
            $41.GetUserProfileResponse>(
        'GetUserProfile',
        getUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.GetUserProfileRequest.fromBuffer(value),
        ($41.GetUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.UpdateUserProfileRequest,
            $41.UpdateUserProfileResponse>(
        'UpdateUserProfile',
        updateUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.UpdateUserProfileRequest.fromBuffer(value),
        ($41.UpdateUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.UpdatePasswordRequest,
            $41.UpdatePasswordResponse>(
        'UpdatePassword',
        updatePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.UpdatePasswordRequest.fromBuffer(value),
        ($41.UpdatePasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.UpdatePreferencesRequest,
            $41.UpdatePreferencesResponse>(
        'UpdatePreferences',
        updatePreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.UpdatePreferencesRequest.fromBuffer(value),
        ($41.UpdatePreferencesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.UploadIDDocumentRequest,
            $41.UploadIDDocumentResponse>(
        'UploadIDDocument',
        uploadIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.UploadIDDocumentRequest.fromBuffer(value),
        ($41.UploadIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.GetIDDocumentsRequest,
            $41.GetIDDocumentsResponse>(
        'GetIDDocuments',
        getIDDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.GetIDDocumentsRequest.fromBuffer(value),
        ($41.GetIDDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.VerifyIDDocumentRequest,
            $41.VerifyIDDocumentResponse>(
        'VerifyIDDocument',
        verifyIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.VerifyIDDocumentRequest.fromBuffer(value),
        ($41.VerifyIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.UserRegisterFaceRequest,
            $41.UserRegisterFaceResponse>(
        'RegisterFace',
        registerFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.UserRegisterFaceRequest.fromBuffer(value),
        ($41.UserRegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.UserVerifyFaceRequest,
            $41.UserVerifyFaceResponse>(
        'VerifyFace',
        verifyFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.UserVerifyFaceRequest.fromBuffer(value),
        ($41.UserVerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.GetFacialDataRequest,
            $41.GetFacialDataResponse>(
        'GetFacialData',
        getFacialData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.GetFacialDataRequest.fromBuffer(value),
        ($41.GetFacialDataResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$41.SetPasscodeRequest, $41.SetPasscodeResponse>(
            'SetPasscode',
            setPasscode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $41.SetPasscodeRequest.fromBuffer(value),
            ($41.SetPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.VerifyPasscodeRequest,
            $41.VerifyPasscodeResponse>(
        'VerifyPasscode',
        verifyPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.VerifyPasscodeRequest.fromBuffer(value),
        ($41.VerifyPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.RemovePasscodeRequest,
            $41.RemovePasscodeResponse>(
        'RemovePasscode',
        removePasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.RemovePasscodeRequest.fromBuffer(value),
        ($41.RemovePasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.CheckPasscodeExistsRequest,
            $41.CheckPasscodeExistsResponse>(
        'CheckPasscodeExists',
        checkPasscodeExists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.CheckPasscodeExistsRequest.fromBuffer(value),
        ($41.CheckPasscodeExistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.UpdateDevicePermissionsRequest,
            $41.UpdateDevicePermissionsResponse>(
        'UpdateDevicePermissions',
        updateDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.UpdateDevicePermissionsRequest.fromBuffer(value),
        ($41.UpdateDevicePermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.GetDevicePermissionsRequest,
            $41.GetDevicePermissionsResponse>(
        'GetDevicePermissions',
        getDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.GetDevicePermissionsRequest.fromBuffer(value),
        ($41.GetDevicePermissionsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$41.CreateUserResponse> createUser_Pre($grpc.ServiceCall call,
      $async.Future<$41.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$41.GetUserProfileResponse> getUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.GetUserProfileRequest> request) async {
    return getUserProfile(call, await request);
  }

  $async.Future<$41.UpdateUserProfileResponse> updateUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.UpdateUserProfileRequest> request) async {
    return updateUserProfile(call, await request);
  }

  $async.Future<$41.UpdatePasswordResponse> updatePassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.UpdatePasswordRequest> request) async {
    return updatePassword(call, await request);
  }

  $async.Future<$41.UpdatePreferencesResponse> updatePreferences_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.UpdatePreferencesRequest> request) async {
    return updatePreferences(call, await request);
  }

  $async.Future<$41.UploadIDDocumentResponse> uploadIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.UploadIDDocumentRequest> request) async {
    return uploadIDDocument(call, await request);
  }

  $async.Future<$41.GetIDDocumentsResponse> getIDDocuments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.GetIDDocumentsRequest> request) async {
    return getIDDocuments(call, await request);
  }

  $async.Future<$41.VerifyIDDocumentResponse> verifyIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.VerifyIDDocumentRequest> request) async {
    return verifyIDDocument(call, await request);
  }

  $async.Future<$41.UserRegisterFaceResponse> registerFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.UserRegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$41.UserVerifyFaceResponse> verifyFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.UserVerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$41.GetFacialDataResponse> getFacialData_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.GetFacialDataRequest> request) async {
    return getFacialData(call, await request);
  }

  $async.Future<$41.SetPasscodeResponse> setPasscode_Pre($grpc.ServiceCall call,
      $async.Future<$41.SetPasscodeRequest> request) async {
    return setPasscode(call, await request);
  }

  $async.Future<$41.VerifyPasscodeResponse> verifyPasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.VerifyPasscodeRequest> request) async {
    return verifyPasscode(call, await request);
  }

  $async.Future<$41.RemovePasscodeResponse> removePasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.RemovePasscodeRequest> request) async {
    return removePasscode(call, await request);
  }

  $async.Future<$41.CheckPasscodeExistsResponse> checkPasscodeExists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.CheckPasscodeExistsRequest> request) async {
    return checkPasscodeExists(call, await request);
  }

  $async.Future<$41.UpdateDevicePermissionsResponse>
      updateDevicePermissions_Pre($grpc.ServiceCall call,
          $async.Future<$41.UpdateDevicePermissionsRequest> request) async {
    return updateDevicePermissions(call, await request);
  }

  $async.Future<$41.GetDevicePermissionsResponse> getDevicePermissions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.GetDevicePermissionsRequest> request) async {
    return getDevicePermissions(call, await request);
  }

  $async.Future<$41.CreateUserResponse> createUser(
      $grpc.ServiceCall call, $41.CreateUserRequest request);
  $async.Future<$41.GetUserProfileResponse> getUserProfile(
      $grpc.ServiceCall call, $41.GetUserProfileRequest request);
  $async.Future<$41.UpdateUserProfileResponse> updateUserProfile(
      $grpc.ServiceCall call, $41.UpdateUserProfileRequest request);
  $async.Future<$41.UpdatePasswordResponse> updatePassword(
      $grpc.ServiceCall call, $41.UpdatePasswordRequest request);
  $async.Future<$41.UpdatePreferencesResponse> updatePreferences(
      $grpc.ServiceCall call, $41.UpdatePreferencesRequest request);
  $async.Future<$41.UploadIDDocumentResponse> uploadIDDocument(
      $grpc.ServiceCall call, $41.UploadIDDocumentRequest request);
  $async.Future<$41.GetIDDocumentsResponse> getIDDocuments(
      $grpc.ServiceCall call, $41.GetIDDocumentsRequest request);
  $async.Future<$41.VerifyIDDocumentResponse> verifyIDDocument(
      $grpc.ServiceCall call, $41.VerifyIDDocumentRequest request);
  $async.Future<$41.UserRegisterFaceResponse> registerFace(
      $grpc.ServiceCall call, $41.UserRegisterFaceRequest request);
  $async.Future<$41.UserVerifyFaceResponse> verifyFace(
      $grpc.ServiceCall call, $41.UserVerifyFaceRequest request);
  $async.Future<$41.GetFacialDataResponse> getFacialData(
      $grpc.ServiceCall call, $41.GetFacialDataRequest request);
  $async.Future<$41.SetPasscodeResponse> setPasscode(
      $grpc.ServiceCall call, $41.SetPasscodeRequest request);
  $async.Future<$41.VerifyPasscodeResponse> verifyPasscode(
      $grpc.ServiceCall call, $41.VerifyPasscodeRequest request);
  $async.Future<$41.RemovePasscodeResponse> removePasscode(
      $grpc.ServiceCall call, $41.RemovePasscodeRequest request);
  $async.Future<$41.CheckPasscodeExistsResponse> checkPasscodeExists(
      $grpc.ServiceCall call, $41.CheckPasscodeExistsRequest request);
  $async.Future<$41.UpdateDevicePermissionsResponse> updateDevicePermissions(
      $grpc.ServiceCall call, $41.UpdateDevicePermissionsRequest request);
  $async.Future<$41.GetDevicePermissionsResponse> getDevicePermissions(
      $grpc.ServiceCall call, $41.GetDevicePermissionsRequest request);
}
