///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $23;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$createUser =
      $grpc.ClientMethod<$23.CreateUserRequest, $23.CreateUserResponse>(
          '/pb.UserService/CreateUser',
          ($23.CreateUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.CreateUserResponse.fromBuffer(value));
  static final _$getUserProfile =
      $grpc.ClientMethod<$23.GetUserProfileRequest, $23.GetUserProfileResponse>(
          '/pb.UserService/GetUserProfile',
          ($23.GetUserProfileRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.GetUserProfileResponse.fromBuffer(value));
  static final _$updateUserProfile = $grpc.ClientMethod<
          $23.UpdateUserProfileRequest, $23.UpdateUserProfileResponse>(
      '/pb.UserService/UpdateUserProfile',
      ($23.UpdateUserProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.UpdateUserProfileResponse.fromBuffer(value));
  static final _$updatePassword =
      $grpc.ClientMethod<$23.UpdatePasswordRequest, $23.UpdatePasswordResponse>(
          '/pb.UserService/UpdatePassword',
          ($23.UpdatePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.UpdatePasswordResponse.fromBuffer(value));
  static final _$updatePreferences = $grpc.ClientMethod<
          $23.UpdatePreferencesRequest, $23.UpdatePreferencesResponse>(
      '/pb.UserService/UpdatePreferences',
      ($23.UpdatePreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.UpdatePreferencesResponse.fromBuffer(value));
  static final _$uploadIDDocument = $grpc.ClientMethod<
          $23.UploadIDDocumentRequest, $23.UploadIDDocumentResponse>(
      '/pb.UserService/UploadIDDocument',
      ($23.UploadIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.UploadIDDocumentResponse.fromBuffer(value));
  static final _$getIDDocuments =
      $grpc.ClientMethod<$23.GetIDDocumentsRequest, $23.GetIDDocumentsResponse>(
          '/pb.UserService/GetIDDocuments',
          ($23.GetIDDocumentsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.GetIDDocumentsResponse.fromBuffer(value));
  static final _$verifyIDDocument = $grpc.ClientMethod<
          $23.VerifyIDDocumentRequest, $23.VerifyIDDocumentResponse>(
      '/pb.UserService/VerifyIDDocument',
      ($23.VerifyIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.VerifyIDDocumentResponse.fromBuffer(value));
  static final _$registerFace = $grpc.ClientMethod<$23.UserRegisterFaceRequest,
          $23.UserRegisterFaceResponse>(
      '/pb.UserService/RegisterFace',
      ($23.UserRegisterFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.UserRegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace =
      $grpc.ClientMethod<$23.UserVerifyFaceRequest, $23.UserVerifyFaceResponse>(
          '/pb.UserService/VerifyFace',
          ($23.UserVerifyFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.UserVerifyFaceResponse.fromBuffer(value));
  static final _$getFacialData =
      $grpc.ClientMethod<$23.GetFacialDataRequest, $23.GetFacialDataResponse>(
          '/pb.UserService/GetFacialData',
          ($23.GetFacialDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.GetFacialDataResponse.fromBuffer(value));
  static final _$setPasscode =
      $grpc.ClientMethod<$23.SetPasscodeRequest, $23.SetPasscodeResponse>(
          '/pb.UserService/SetPasscode',
          ($23.SetPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.SetPasscodeResponse.fromBuffer(value));
  static final _$verifyPasscode =
      $grpc.ClientMethod<$23.VerifyPasscodeRequest, $23.VerifyPasscodeResponse>(
          '/pb.UserService/VerifyPasscode',
          ($23.VerifyPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.VerifyPasscodeResponse.fromBuffer(value));
  static final _$removePasscode =
      $grpc.ClientMethod<$23.RemovePasscodeRequest, $23.RemovePasscodeResponse>(
          '/pb.UserService/RemovePasscode',
          ($23.RemovePasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.RemovePasscodeResponse.fromBuffer(value));
  static final _$checkPasscodeExists = $grpc.ClientMethod<
          $23.CheckPasscodeExistsRequest, $23.CheckPasscodeExistsResponse>(
      '/pb.UserService/CheckPasscodeExists',
      ($23.CheckPasscodeExistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.CheckPasscodeExistsResponse.fromBuffer(value));
  static final _$updateDevicePermissions = $grpc.ClientMethod<
          $23.UpdateDevicePermissionsRequest,
          $23.UpdateDevicePermissionsResponse>(
      '/pb.UserService/UpdateDevicePermissions',
      ($23.UpdateDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.UpdateDevicePermissionsResponse.fromBuffer(value));
  static final _$getDevicePermissions = $grpc.ClientMethod<
          $23.GetDevicePermissionsRequest, $23.GetDevicePermissionsResponse>(
      '/pb.UserService/GetDevicePermissions',
      ($23.GetDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetDevicePermissionsResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$23.CreateUserResponse> createUser(
      $23.CreateUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetUserProfileResponse> getUserProfile(
      $23.GetUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$23.UpdateUserProfileResponse> updateUserProfile(
      $23.UpdateUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$23.UpdatePasswordResponse> updatePassword(
      $23.UpdatePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePassword, request, options: options);
  }

  $grpc.ResponseFuture<$23.UpdatePreferencesResponse> updatePreferences(
      $23.UpdatePreferencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePreferences, request, options: options);
  }

  $grpc.ResponseFuture<$23.UploadIDDocumentResponse> uploadIDDocument(
      $23.UploadIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetIDDocumentsResponse> getIDDocuments(
      $23.GetIDDocumentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$23.VerifyIDDocumentResponse> verifyIDDocument(
      $23.VerifyIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$23.UserRegisterFaceResponse> registerFace(
      $23.UserRegisterFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$23.UserVerifyFaceResponse> verifyFace(
      $23.UserVerifyFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetFacialDataResponse> getFacialData(
      $23.GetFacialDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFacialData, request, options: options);
  }

  $grpc.ResponseFuture<$23.SetPasscodeResponse> setPasscode(
      $23.SetPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$23.VerifyPasscodeResponse> verifyPasscode(
      $23.VerifyPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$23.RemovePasscodeResponse> removePasscode(
      $23.RemovePasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removePasscode, request, options: options);
  }

  $grpc.ResponseFuture<$23.CheckPasscodeExistsResponse> checkPasscodeExists(
      $23.CheckPasscodeExistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkPasscodeExists, request, options: options);
  }

  $grpc.ResponseFuture<$23.UpdateDevicePermissionsResponse>
      updateDevicePermissions($23.UpdateDevicePermissionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDevicePermissions, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetDevicePermissionsResponse> getDevicePermissions(
      $23.GetDevicePermissionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDevicePermissions, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UserService';

  UserServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$23.CreateUserRequest, $23.CreateUserResponse>(
            'CreateUser',
            createUser_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $23.CreateUserRequest.fromBuffer(value),
            ($23.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetUserProfileRequest,
            $23.GetUserProfileResponse>(
        'GetUserProfile',
        getUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetUserProfileRequest.fromBuffer(value),
        ($23.GetUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.UpdateUserProfileRequest,
            $23.UpdateUserProfileResponse>(
        'UpdateUserProfile',
        updateUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.UpdateUserProfileRequest.fromBuffer(value),
        ($23.UpdateUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.UpdatePasswordRequest,
            $23.UpdatePasswordResponse>(
        'UpdatePassword',
        updatePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.UpdatePasswordRequest.fromBuffer(value),
        ($23.UpdatePasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.UpdatePreferencesRequest,
            $23.UpdatePreferencesResponse>(
        'UpdatePreferences',
        updatePreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.UpdatePreferencesRequest.fromBuffer(value),
        ($23.UpdatePreferencesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.UploadIDDocumentRequest,
            $23.UploadIDDocumentResponse>(
        'UploadIDDocument',
        uploadIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.UploadIDDocumentRequest.fromBuffer(value),
        ($23.UploadIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetIDDocumentsRequest,
            $23.GetIDDocumentsResponse>(
        'GetIDDocuments',
        getIDDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetIDDocumentsRequest.fromBuffer(value),
        ($23.GetIDDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.VerifyIDDocumentRequest,
            $23.VerifyIDDocumentResponse>(
        'VerifyIDDocument',
        verifyIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.VerifyIDDocumentRequest.fromBuffer(value),
        ($23.VerifyIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.UserRegisterFaceRequest,
            $23.UserRegisterFaceResponse>(
        'RegisterFace',
        registerFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.UserRegisterFaceRequest.fromBuffer(value),
        ($23.UserRegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.UserVerifyFaceRequest,
            $23.UserVerifyFaceResponse>(
        'VerifyFace',
        verifyFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.UserVerifyFaceRequest.fromBuffer(value),
        ($23.UserVerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetFacialDataRequest,
            $23.GetFacialDataResponse>(
        'GetFacialData',
        getFacialData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetFacialDataRequest.fromBuffer(value),
        ($23.GetFacialDataResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$23.SetPasscodeRequest, $23.SetPasscodeResponse>(
            'SetPasscode',
            setPasscode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $23.SetPasscodeRequest.fromBuffer(value),
            ($23.SetPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.VerifyPasscodeRequest,
            $23.VerifyPasscodeResponse>(
        'VerifyPasscode',
        verifyPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.VerifyPasscodeRequest.fromBuffer(value),
        ($23.VerifyPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.RemovePasscodeRequest,
            $23.RemovePasscodeResponse>(
        'RemovePasscode',
        removePasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.RemovePasscodeRequest.fromBuffer(value),
        ($23.RemovePasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.CheckPasscodeExistsRequest,
            $23.CheckPasscodeExistsResponse>(
        'CheckPasscodeExists',
        checkPasscodeExists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.CheckPasscodeExistsRequest.fromBuffer(value),
        ($23.CheckPasscodeExistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.UpdateDevicePermissionsRequest,
            $23.UpdateDevicePermissionsResponse>(
        'UpdateDevicePermissions',
        updateDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.UpdateDevicePermissionsRequest.fromBuffer(value),
        ($23.UpdateDevicePermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetDevicePermissionsRequest,
            $23.GetDevicePermissionsResponse>(
        'GetDevicePermissions',
        getDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetDevicePermissionsRequest.fromBuffer(value),
        ($23.GetDevicePermissionsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$23.CreateUserResponse> createUser_Pre($grpc.ServiceCall call,
      $async.Future<$23.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$23.GetUserProfileResponse> getUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetUserProfileRequest> request) async {
    return getUserProfile(call, await request);
  }

  $async.Future<$23.UpdateUserProfileResponse> updateUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.UpdateUserProfileRequest> request) async {
    return updateUserProfile(call, await request);
  }

  $async.Future<$23.UpdatePasswordResponse> updatePassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.UpdatePasswordRequest> request) async {
    return updatePassword(call, await request);
  }

  $async.Future<$23.UpdatePreferencesResponse> updatePreferences_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.UpdatePreferencesRequest> request) async {
    return updatePreferences(call, await request);
  }

  $async.Future<$23.UploadIDDocumentResponse> uploadIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.UploadIDDocumentRequest> request) async {
    return uploadIDDocument(call, await request);
  }

  $async.Future<$23.GetIDDocumentsResponse> getIDDocuments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetIDDocumentsRequest> request) async {
    return getIDDocuments(call, await request);
  }

  $async.Future<$23.VerifyIDDocumentResponse> verifyIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.VerifyIDDocumentRequest> request) async {
    return verifyIDDocument(call, await request);
  }

  $async.Future<$23.UserRegisterFaceResponse> registerFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.UserRegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$23.UserVerifyFaceResponse> verifyFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.UserVerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$23.GetFacialDataResponse> getFacialData_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetFacialDataRequest> request) async {
    return getFacialData(call, await request);
  }

  $async.Future<$23.SetPasscodeResponse> setPasscode_Pre($grpc.ServiceCall call,
      $async.Future<$23.SetPasscodeRequest> request) async {
    return setPasscode(call, await request);
  }

  $async.Future<$23.VerifyPasscodeResponse> verifyPasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.VerifyPasscodeRequest> request) async {
    return verifyPasscode(call, await request);
  }

  $async.Future<$23.RemovePasscodeResponse> removePasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.RemovePasscodeRequest> request) async {
    return removePasscode(call, await request);
  }

  $async.Future<$23.CheckPasscodeExistsResponse> checkPasscodeExists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.CheckPasscodeExistsRequest> request) async {
    return checkPasscodeExists(call, await request);
  }

  $async.Future<$23.UpdateDevicePermissionsResponse>
      updateDevicePermissions_Pre($grpc.ServiceCall call,
          $async.Future<$23.UpdateDevicePermissionsRequest> request) async {
    return updateDevicePermissions(call, await request);
  }

  $async.Future<$23.GetDevicePermissionsResponse> getDevicePermissions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetDevicePermissionsRequest> request) async {
    return getDevicePermissions(call, await request);
  }

  $async.Future<$23.CreateUserResponse> createUser(
      $grpc.ServiceCall call, $23.CreateUserRequest request);
  $async.Future<$23.GetUserProfileResponse> getUserProfile(
      $grpc.ServiceCall call, $23.GetUserProfileRequest request);
  $async.Future<$23.UpdateUserProfileResponse> updateUserProfile(
      $grpc.ServiceCall call, $23.UpdateUserProfileRequest request);
  $async.Future<$23.UpdatePasswordResponse> updatePassword(
      $grpc.ServiceCall call, $23.UpdatePasswordRequest request);
  $async.Future<$23.UpdatePreferencesResponse> updatePreferences(
      $grpc.ServiceCall call, $23.UpdatePreferencesRequest request);
  $async.Future<$23.UploadIDDocumentResponse> uploadIDDocument(
      $grpc.ServiceCall call, $23.UploadIDDocumentRequest request);
  $async.Future<$23.GetIDDocumentsResponse> getIDDocuments(
      $grpc.ServiceCall call, $23.GetIDDocumentsRequest request);
  $async.Future<$23.VerifyIDDocumentResponse> verifyIDDocument(
      $grpc.ServiceCall call, $23.VerifyIDDocumentRequest request);
  $async.Future<$23.UserRegisterFaceResponse> registerFace(
      $grpc.ServiceCall call, $23.UserRegisterFaceRequest request);
  $async.Future<$23.UserVerifyFaceResponse> verifyFace(
      $grpc.ServiceCall call, $23.UserVerifyFaceRequest request);
  $async.Future<$23.GetFacialDataResponse> getFacialData(
      $grpc.ServiceCall call, $23.GetFacialDataRequest request);
  $async.Future<$23.SetPasscodeResponse> setPasscode(
      $grpc.ServiceCall call, $23.SetPasscodeRequest request);
  $async.Future<$23.VerifyPasscodeResponse> verifyPasscode(
      $grpc.ServiceCall call, $23.VerifyPasscodeRequest request);
  $async.Future<$23.RemovePasscodeResponse> removePasscode(
      $grpc.ServiceCall call, $23.RemovePasscodeRequest request);
  $async.Future<$23.CheckPasscodeExistsResponse> checkPasscodeExists(
      $grpc.ServiceCall call, $23.CheckPasscodeExistsRequest request);
  $async.Future<$23.UpdateDevicePermissionsResponse> updateDevicePermissions(
      $grpc.ServiceCall call, $23.UpdateDevicePermissionsRequest request);
  $async.Future<$23.GetDevicePermissionsResponse> getDevicePermissions(
      $grpc.ServiceCall call, $23.GetDevicePermissionsRequest request);
}
