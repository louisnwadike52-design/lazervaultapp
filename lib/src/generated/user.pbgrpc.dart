///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $31;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$createUser =
      $grpc.ClientMethod<$31.CreateUserRequest, $31.CreateUserResponse>(
          '/pb.UserService/CreateUser',
          ($31.CreateUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.CreateUserResponse.fromBuffer(value));
  static final _$getUserProfile =
      $grpc.ClientMethod<$31.GetUserProfileRequest, $31.GetUserProfileResponse>(
          '/pb.UserService/GetUserProfile',
          ($31.GetUserProfileRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.GetUserProfileResponse.fromBuffer(value));
  static final _$updateUserProfile = $grpc.ClientMethod<
          $31.UpdateUserProfileRequest, $31.UpdateUserProfileResponse>(
      '/pb.UserService/UpdateUserProfile',
      ($31.UpdateUserProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.UpdateUserProfileResponse.fromBuffer(value));
  static final _$updatePassword =
      $grpc.ClientMethod<$31.UpdatePasswordRequest, $31.UpdatePasswordResponse>(
          '/pb.UserService/UpdatePassword',
          ($31.UpdatePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.UpdatePasswordResponse.fromBuffer(value));
  static final _$updatePreferences = $grpc.ClientMethod<
          $31.UpdatePreferencesRequest, $31.UpdatePreferencesResponse>(
      '/pb.UserService/UpdatePreferences',
      ($31.UpdatePreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.UpdatePreferencesResponse.fromBuffer(value));
  static final _$uploadIDDocument = $grpc.ClientMethod<
          $31.UploadIDDocumentRequest, $31.UploadIDDocumentResponse>(
      '/pb.UserService/UploadIDDocument',
      ($31.UploadIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.UploadIDDocumentResponse.fromBuffer(value));
  static final _$getIDDocuments =
      $grpc.ClientMethod<$31.GetIDDocumentsRequest, $31.GetIDDocumentsResponse>(
          '/pb.UserService/GetIDDocuments',
          ($31.GetIDDocumentsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.GetIDDocumentsResponse.fromBuffer(value));
  static final _$verifyIDDocument = $grpc.ClientMethod<
          $31.VerifyIDDocumentRequest, $31.VerifyIDDocumentResponse>(
      '/pb.UserService/VerifyIDDocument',
      ($31.VerifyIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.VerifyIDDocumentResponse.fromBuffer(value));
  static final _$registerFace = $grpc.ClientMethod<$31.UserRegisterFaceRequest,
          $31.UserRegisterFaceResponse>(
      '/pb.UserService/RegisterFace',
      ($31.UserRegisterFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.UserRegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace =
      $grpc.ClientMethod<$31.UserVerifyFaceRequest, $31.UserVerifyFaceResponse>(
          '/pb.UserService/VerifyFace',
          ($31.UserVerifyFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.UserVerifyFaceResponse.fromBuffer(value));
  static final _$getFacialData =
      $grpc.ClientMethod<$31.GetFacialDataRequest, $31.GetFacialDataResponse>(
          '/pb.UserService/GetFacialData',
          ($31.GetFacialDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.GetFacialDataResponse.fromBuffer(value));
  static final _$setPasscode =
      $grpc.ClientMethod<$31.SetPasscodeRequest, $31.SetPasscodeResponse>(
          '/pb.UserService/SetPasscode',
          ($31.SetPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.SetPasscodeResponse.fromBuffer(value));
  static final _$verifyPasscode =
      $grpc.ClientMethod<$31.VerifyPasscodeRequest, $31.VerifyPasscodeResponse>(
          '/pb.UserService/VerifyPasscode',
          ($31.VerifyPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.VerifyPasscodeResponse.fromBuffer(value));
  static final _$removePasscode =
      $grpc.ClientMethod<$31.RemovePasscodeRequest, $31.RemovePasscodeResponse>(
          '/pb.UserService/RemovePasscode',
          ($31.RemovePasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.RemovePasscodeResponse.fromBuffer(value));
  static final _$checkPasscodeExists = $grpc.ClientMethod<
          $31.CheckPasscodeExistsRequest, $31.CheckPasscodeExistsResponse>(
      '/pb.UserService/CheckPasscodeExists',
      ($31.CheckPasscodeExistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.CheckPasscodeExistsResponse.fromBuffer(value));
  static final _$updateDevicePermissions = $grpc.ClientMethod<
          $31.UpdateDevicePermissionsRequest,
          $31.UpdateDevicePermissionsResponse>(
      '/pb.UserService/UpdateDevicePermissions',
      ($31.UpdateDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.UpdateDevicePermissionsResponse.fromBuffer(value));
  static final _$getDevicePermissions = $grpc.ClientMethod<
          $31.GetDevicePermissionsRequest, $31.GetDevicePermissionsResponse>(
      '/pb.UserService/GetDevicePermissions',
      ($31.GetDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.GetDevicePermissionsResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$31.CreateUserResponse> createUser(
      $31.CreateUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$31.GetUserProfileResponse> getUserProfile(
      $31.GetUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$31.UpdateUserProfileResponse> updateUserProfile(
      $31.UpdateUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$31.UpdatePasswordResponse> updatePassword(
      $31.UpdatePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePassword, request, options: options);
  }

  $grpc.ResponseFuture<$31.UpdatePreferencesResponse> updatePreferences(
      $31.UpdatePreferencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePreferences, request, options: options);
  }

  $grpc.ResponseFuture<$31.UploadIDDocumentResponse> uploadIDDocument(
      $31.UploadIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$31.GetIDDocumentsResponse> getIDDocuments(
      $31.GetIDDocumentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$31.VerifyIDDocumentResponse> verifyIDDocument(
      $31.VerifyIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$31.UserRegisterFaceResponse> registerFace(
      $31.UserRegisterFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$31.UserVerifyFaceResponse> verifyFace(
      $31.UserVerifyFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$31.GetFacialDataResponse> getFacialData(
      $31.GetFacialDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFacialData, request, options: options);
  }

  $grpc.ResponseFuture<$31.SetPasscodeResponse> setPasscode(
      $31.SetPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$31.VerifyPasscodeResponse> verifyPasscode(
      $31.VerifyPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$31.RemovePasscodeResponse> removePasscode(
      $31.RemovePasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removePasscode, request, options: options);
  }

  $grpc.ResponseFuture<$31.CheckPasscodeExistsResponse> checkPasscodeExists(
      $31.CheckPasscodeExistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkPasscodeExists, request, options: options);
  }

  $grpc.ResponseFuture<$31.UpdateDevicePermissionsResponse>
      updateDevicePermissions($31.UpdateDevicePermissionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDevicePermissions, request,
        options: options);
  }

  $grpc.ResponseFuture<$31.GetDevicePermissionsResponse> getDevicePermissions(
      $31.GetDevicePermissionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDevicePermissions, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UserService';

  UserServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$31.CreateUserRequest, $31.CreateUserResponse>(
            'CreateUser',
            createUser_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $31.CreateUserRequest.fromBuffer(value),
            ($31.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.GetUserProfileRequest,
            $31.GetUserProfileResponse>(
        'GetUserProfile',
        getUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.GetUserProfileRequest.fromBuffer(value),
        ($31.GetUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.UpdateUserProfileRequest,
            $31.UpdateUserProfileResponse>(
        'UpdateUserProfile',
        updateUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.UpdateUserProfileRequest.fromBuffer(value),
        ($31.UpdateUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.UpdatePasswordRequest,
            $31.UpdatePasswordResponse>(
        'UpdatePassword',
        updatePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.UpdatePasswordRequest.fromBuffer(value),
        ($31.UpdatePasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.UpdatePreferencesRequest,
            $31.UpdatePreferencesResponse>(
        'UpdatePreferences',
        updatePreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.UpdatePreferencesRequest.fromBuffer(value),
        ($31.UpdatePreferencesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.UploadIDDocumentRequest,
            $31.UploadIDDocumentResponse>(
        'UploadIDDocument',
        uploadIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.UploadIDDocumentRequest.fromBuffer(value),
        ($31.UploadIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.GetIDDocumentsRequest,
            $31.GetIDDocumentsResponse>(
        'GetIDDocuments',
        getIDDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.GetIDDocumentsRequest.fromBuffer(value),
        ($31.GetIDDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.VerifyIDDocumentRequest,
            $31.VerifyIDDocumentResponse>(
        'VerifyIDDocument',
        verifyIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.VerifyIDDocumentRequest.fromBuffer(value),
        ($31.VerifyIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.UserRegisterFaceRequest,
            $31.UserRegisterFaceResponse>(
        'RegisterFace',
        registerFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.UserRegisterFaceRequest.fromBuffer(value),
        ($31.UserRegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.UserVerifyFaceRequest,
            $31.UserVerifyFaceResponse>(
        'VerifyFace',
        verifyFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.UserVerifyFaceRequest.fromBuffer(value),
        ($31.UserVerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.GetFacialDataRequest,
            $31.GetFacialDataResponse>(
        'GetFacialData',
        getFacialData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.GetFacialDataRequest.fromBuffer(value),
        ($31.GetFacialDataResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$31.SetPasscodeRequest, $31.SetPasscodeResponse>(
            'SetPasscode',
            setPasscode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $31.SetPasscodeRequest.fromBuffer(value),
            ($31.SetPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.VerifyPasscodeRequest,
            $31.VerifyPasscodeResponse>(
        'VerifyPasscode',
        verifyPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.VerifyPasscodeRequest.fromBuffer(value),
        ($31.VerifyPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.RemovePasscodeRequest,
            $31.RemovePasscodeResponse>(
        'RemovePasscode',
        removePasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.RemovePasscodeRequest.fromBuffer(value),
        ($31.RemovePasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.CheckPasscodeExistsRequest,
            $31.CheckPasscodeExistsResponse>(
        'CheckPasscodeExists',
        checkPasscodeExists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.CheckPasscodeExistsRequest.fromBuffer(value),
        ($31.CheckPasscodeExistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.UpdateDevicePermissionsRequest,
            $31.UpdateDevicePermissionsResponse>(
        'UpdateDevicePermissions',
        updateDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.UpdateDevicePermissionsRequest.fromBuffer(value),
        ($31.UpdateDevicePermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.GetDevicePermissionsRequest,
            $31.GetDevicePermissionsResponse>(
        'GetDevicePermissions',
        getDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.GetDevicePermissionsRequest.fromBuffer(value),
        ($31.GetDevicePermissionsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$31.CreateUserResponse> createUser_Pre($grpc.ServiceCall call,
      $async.Future<$31.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$31.GetUserProfileResponse> getUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.GetUserProfileRequest> request) async {
    return getUserProfile(call, await request);
  }

  $async.Future<$31.UpdateUserProfileResponse> updateUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.UpdateUserProfileRequest> request) async {
    return updateUserProfile(call, await request);
  }

  $async.Future<$31.UpdatePasswordResponse> updatePassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.UpdatePasswordRequest> request) async {
    return updatePassword(call, await request);
  }

  $async.Future<$31.UpdatePreferencesResponse> updatePreferences_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.UpdatePreferencesRequest> request) async {
    return updatePreferences(call, await request);
  }

  $async.Future<$31.UploadIDDocumentResponse> uploadIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.UploadIDDocumentRequest> request) async {
    return uploadIDDocument(call, await request);
  }

  $async.Future<$31.GetIDDocumentsResponse> getIDDocuments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.GetIDDocumentsRequest> request) async {
    return getIDDocuments(call, await request);
  }

  $async.Future<$31.VerifyIDDocumentResponse> verifyIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.VerifyIDDocumentRequest> request) async {
    return verifyIDDocument(call, await request);
  }

  $async.Future<$31.UserRegisterFaceResponse> registerFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.UserRegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$31.UserVerifyFaceResponse> verifyFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.UserVerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$31.GetFacialDataResponse> getFacialData_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.GetFacialDataRequest> request) async {
    return getFacialData(call, await request);
  }

  $async.Future<$31.SetPasscodeResponse> setPasscode_Pre($grpc.ServiceCall call,
      $async.Future<$31.SetPasscodeRequest> request) async {
    return setPasscode(call, await request);
  }

  $async.Future<$31.VerifyPasscodeResponse> verifyPasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.VerifyPasscodeRequest> request) async {
    return verifyPasscode(call, await request);
  }

  $async.Future<$31.RemovePasscodeResponse> removePasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.RemovePasscodeRequest> request) async {
    return removePasscode(call, await request);
  }

  $async.Future<$31.CheckPasscodeExistsResponse> checkPasscodeExists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.CheckPasscodeExistsRequest> request) async {
    return checkPasscodeExists(call, await request);
  }

  $async.Future<$31.UpdateDevicePermissionsResponse>
      updateDevicePermissions_Pre($grpc.ServiceCall call,
          $async.Future<$31.UpdateDevicePermissionsRequest> request) async {
    return updateDevicePermissions(call, await request);
  }

  $async.Future<$31.GetDevicePermissionsResponse> getDevicePermissions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.GetDevicePermissionsRequest> request) async {
    return getDevicePermissions(call, await request);
  }

  $async.Future<$31.CreateUserResponse> createUser(
      $grpc.ServiceCall call, $31.CreateUserRequest request);
  $async.Future<$31.GetUserProfileResponse> getUserProfile(
      $grpc.ServiceCall call, $31.GetUserProfileRequest request);
  $async.Future<$31.UpdateUserProfileResponse> updateUserProfile(
      $grpc.ServiceCall call, $31.UpdateUserProfileRequest request);
  $async.Future<$31.UpdatePasswordResponse> updatePassword(
      $grpc.ServiceCall call, $31.UpdatePasswordRequest request);
  $async.Future<$31.UpdatePreferencesResponse> updatePreferences(
      $grpc.ServiceCall call, $31.UpdatePreferencesRequest request);
  $async.Future<$31.UploadIDDocumentResponse> uploadIDDocument(
      $grpc.ServiceCall call, $31.UploadIDDocumentRequest request);
  $async.Future<$31.GetIDDocumentsResponse> getIDDocuments(
      $grpc.ServiceCall call, $31.GetIDDocumentsRequest request);
  $async.Future<$31.VerifyIDDocumentResponse> verifyIDDocument(
      $grpc.ServiceCall call, $31.VerifyIDDocumentRequest request);
  $async.Future<$31.UserRegisterFaceResponse> registerFace(
      $grpc.ServiceCall call, $31.UserRegisterFaceRequest request);
  $async.Future<$31.UserVerifyFaceResponse> verifyFace(
      $grpc.ServiceCall call, $31.UserVerifyFaceRequest request);
  $async.Future<$31.GetFacialDataResponse> getFacialData(
      $grpc.ServiceCall call, $31.GetFacialDataRequest request);
  $async.Future<$31.SetPasscodeResponse> setPasscode(
      $grpc.ServiceCall call, $31.SetPasscodeRequest request);
  $async.Future<$31.VerifyPasscodeResponse> verifyPasscode(
      $grpc.ServiceCall call, $31.VerifyPasscodeRequest request);
  $async.Future<$31.RemovePasscodeResponse> removePasscode(
      $grpc.ServiceCall call, $31.RemovePasscodeRequest request);
  $async.Future<$31.CheckPasscodeExistsResponse> checkPasscodeExists(
      $grpc.ServiceCall call, $31.CheckPasscodeExistsRequest request);
  $async.Future<$31.UpdateDevicePermissionsResponse> updateDevicePermissions(
      $grpc.ServiceCall call, $31.UpdateDevicePermissionsRequest request);
  $async.Future<$31.GetDevicePermissionsResponse> getDevicePermissions(
      $grpc.ServiceCall call, $31.GetDevicePermissionsRequest request);
}
