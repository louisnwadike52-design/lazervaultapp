///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $30;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$createUser =
      $grpc.ClientMethod<$30.CreateUserRequest, $30.CreateUserResponse>(
          '/pb.UserService/CreateUser',
          ($30.CreateUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.CreateUserResponse.fromBuffer(value));
  static final _$getUserProfile =
      $grpc.ClientMethod<$30.GetUserProfileRequest, $30.GetUserProfileResponse>(
          '/pb.UserService/GetUserProfile',
          ($30.GetUserProfileRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.GetUserProfileResponse.fromBuffer(value));
  static final _$updateUserProfile = $grpc.ClientMethod<
          $30.UpdateUserProfileRequest, $30.UpdateUserProfileResponse>(
      '/pb.UserService/UpdateUserProfile',
      ($30.UpdateUserProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.UpdateUserProfileResponse.fromBuffer(value));
  static final _$updatePassword =
      $grpc.ClientMethod<$30.UpdatePasswordRequest, $30.UpdatePasswordResponse>(
          '/pb.UserService/UpdatePassword',
          ($30.UpdatePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.UpdatePasswordResponse.fromBuffer(value));
  static final _$updatePreferences = $grpc.ClientMethod<
          $30.UpdatePreferencesRequest, $30.UpdatePreferencesResponse>(
      '/pb.UserService/UpdatePreferences',
      ($30.UpdatePreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.UpdatePreferencesResponse.fromBuffer(value));
  static final _$uploadIDDocument = $grpc.ClientMethod<
          $30.UploadIDDocumentRequest, $30.UploadIDDocumentResponse>(
      '/pb.UserService/UploadIDDocument',
      ($30.UploadIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.UploadIDDocumentResponse.fromBuffer(value));
  static final _$getIDDocuments =
      $grpc.ClientMethod<$30.GetIDDocumentsRequest, $30.GetIDDocumentsResponse>(
          '/pb.UserService/GetIDDocuments',
          ($30.GetIDDocumentsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.GetIDDocumentsResponse.fromBuffer(value));
  static final _$verifyIDDocument = $grpc.ClientMethod<
          $30.VerifyIDDocumentRequest, $30.VerifyIDDocumentResponse>(
      '/pb.UserService/VerifyIDDocument',
      ($30.VerifyIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.VerifyIDDocumentResponse.fromBuffer(value));
  static final _$registerFace = $grpc.ClientMethod<$30.UserRegisterFaceRequest,
          $30.UserRegisterFaceResponse>(
      '/pb.UserService/RegisterFace',
      ($30.UserRegisterFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.UserRegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace =
      $grpc.ClientMethod<$30.UserVerifyFaceRequest, $30.UserVerifyFaceResponse>(
          '/pb.UserService/VerifyFace',
          ($30.UserVerifyFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.UserVerifyFaceResponse.fromBuffer(value));
  static final _$getFacialData =
      $grpc.ClientMethod<$30.GetFacialDataRequest, $30.GetFacialDataResponse>(
          '/pb.UserService/GetFacialData',
          ($30.GetFacialDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.GetFacialDataResponse.fromBuffer(value));
  static final _$setPasscode =
      $grpc.ClientMethod<$30.SetPasscodeRequest, $30.SetPasscodeResponse>(
          '/pb.UserService/SetPasscode',
          ($30.SetPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.SetPasscodeResponse.fromBuffer(value));
  static final _$verifyPasscode =
      $grpc.ClientMethod<$30.VerifyPasscodeRequest, $30.VerifyPasscodeResponse>(
          '/pb.UserService/VerifyPasscode',
          ($30.VerifyPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.VerifyPasscodeResponse.fromBuffer(value));
  static final _$removePasscode =
      $grpc.ClientMethod<$30.RemovePasscodeRequest, $30.RemovePasscodeResponse>(
          '/pb.UserService/RemovePasscode',
          ($30.RemovePasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $30.RemovePasscodeResponse.fromBuffer(value));
  static final _$checkPasscodeExists = $grpc.ClientMethod<
          $30.CheckPasscodeExistsRequest, $30.CheckPasscodeExistsResponse>(
      '/pb.UserService/CheckPasscodeExists',
      ($30.CheckPasscodeExistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.CheckPasscodeExistsResponse.fromBuffer(value));
  static final _$updateDevicePermissions = $grpc.ClientMethod<
          $30.UpdateDevicePermissionsRequest,
          $30.UpdateDevicePermissionsResponse>(
      '/pb.UserService/UpdateDevicePermissions',
      ($30.UpdateDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.UpdateDevicePermissionsResponse.fromBuffer(value));
  static final _$getDevicePermissions = $grpc.ClientMethod<
          $30.GetDevicePermissionsRequest, $30.GetDevicePermissionsResponse>(
      '/pb.UserService/GetDevicePermissions',
      ($30.GetDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.GetDevicePermissionsResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$30.CreateUserResponse> createUser(
      $30.CreateUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetUserProfileResponse> getUserProfile(
      $30.GetUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$30.UpdateUserProfileResponse> updateUserProfile(
      $30.UpdateUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$30.UpdatePasswordResponse> updatePassword(
      $30.UpdatePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePassword, request, options: options);
  }

  $grpc.ResponseFuture<$30.UpdatePreferencesResponse> updatePreferences(
      $30.UpdatePreferencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePreferences, request, options: options);
  }

  $grpc.ResponseFuture<$30.UploadIDDocumentResponse> uploadIDDocument(
      $30.UploadIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetIDDocumentsResponse> getIDDocuments(
      $30.GetIDDocumentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$30.VerifyIDDocumentResponse> verifyIDDocument(
      $30.VerifyIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$30.UserRegisterFaceResponse> registerFace(
      $30.UserRegisterFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$30.UserVerifyFaceResponse> verifyFace(
      $30.UserVerifyFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetFacialDataResponse> getFacialData(
      $30.GetFacialDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFacialData, request, options: options);
  }

  $grpc.ResponseFuture<$30.SetPasscodeResponse> setPasscode(
      $30.SetPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$30.VerifyPasscodeResponse> verifyPasscode(
      $30.VerifyPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$30.RemovePasscodeResponse> removePasscode(
      $30.RemovePasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removePasscode, request, options: options);
  }

  $grpc.ResponseFuture<$30.CheckPasscodeExistsResponse> checkPasscodeExists(
      $30.CheckPasscodeExistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkPasscodeExists, request, options: options);
  }

  $grpc.ResponseFuture<$30.UpdateDevicePermissionsResponse>
      updateDevicePermissions($30.UpdateDevicePermissionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDevicePermissions, request,
        options: options);
  }

  $grpc.ResponseFuture<$30.GetDevicePermissionsResponse> getDevicePermissions(
      $30.GetDevicePermissionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDevicePermissions, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UserService';

  UserServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$30.CreateUserRequest, $30.CreateUserResponse>(
            'CreateUser',
            createUser_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $30.CreateUserRequest.fromBuffer(value),
            ($30.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetUserProfileRequest,
            $30.GetUserProfileResponse>(
        'GetUserProfile',
        getUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.GetUserProfileRequest.fromBuffer(value),
        ($30.GetUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.UpdateUserProfileRequest,
            $30.UpdateUserProfileResponse>(
        'UpdateUserProfile',
        updateUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.UpdateUserProfileRequest.fromBuffer(value),
        ($30.UpdateUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.UpdatePasswordRequest,
            $30.UpdatePasswordResponse>(
        'UpdatePassword',
        updatePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.UpdatePasswordRequest.fromBuffer(value),
        ($30.UpdatePasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.UpdatePreferencesRequest,
            $30.UpdatePreferencesResponse>(
        'UpdatePreferences',
        updatePreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.UpdatePreferencesRequest.fromBuffer(value),
        ($30.UpdatePreferencesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.UploadIDDocumentRequest,
            $30.UploadIDDocumentResponse>(
        'UploadIDDocument',
        uploadIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.UploadIDDocumentRequest.fromBuffer(value),
        ($30.UploadIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetIDDocumentsRequest,
            $30.GetIDDocumentsResponse>(
        'GetIDDocuments',
        getIDDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.GetIDDocumentsRequest.fromBuffer(value),
        ($30.GetIDDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.VerifyIDDocumentRequest,
            $30.VerifyIDDocumentResponse>(
        'VerifyIDDocument',
        verifyIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.VerifyIDDocumentRequest.fromBuffer(value),
        ($30.VerifyIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.UserRegisterFaceRequest,
            $30.UserRegisterFaceResponse>(
        'RegisterFace',
        registerFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.UserRegisterFaceRequest.fromBuffer(value),
        ($30.UserRegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.UserVerifyFaceRequest,
            $30.UserVerifyFaceResponse>(
        'VerifyFace',
        verifyFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.UserVerifyFaceRequest.fromBuffer(value),
        ($30.UserVerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetFacialDataRequest,
            $30.GetFacialDataResponse>(
        'GetFacialData',
        getFacialData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.GetFacialDataRequest.fromBuffer(value),
        ($30.GetFacialDataResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$30.SetPasscodeRequest, $30.SetPasscodeResponse>(
            'SetPasscode',
            setPasscode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $30.SetPasscodeRequest.fromBuffer(value),
            ($30.SetPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.VerifyPasscodeRequest,
            $30.VerifyPasscodeResponse>(
        'VerifyPasscode',
        verifyPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.VerifyPasscodeRequest.fromBuffer(value),
        ($30.VerifyPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.RemovePasscodeRequest,
            $30.RemovePasscodeResponse>(
        'RemovePasscode',
        removePasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.RemovePasscodeRequest.fromBuffer(value),
        ($30.RemovePasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.CheckPasscodeExistsRequest,
            $30.CheckPasscodeExistsResponse>(
        'CheckPasscodeExists',
        checkPasscodeExists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.CheckPasscodeExistsRequest.fromBuffer(value),
        ($30.CheckPasscodeExistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.UpdateDevicePermissionsRequest,
            $30.UpdateDevicePermissionsResponse>(
        'UpdateDevicePermissions',
        updateDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.UpdateDevicePermissionsRequest.fromBuffer(value),
        ($30.UpdateDevicePermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetDevicePermissionsRequest,
            $30.GetDevicePermissionsResponse>(
        'GetDevicePermissions',
        getDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.GetDevicePermissionsRequest.fromBuffer(value),
        ($30.GetDevicePermissionsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$30.CreateUserResponse> createUser_Pre($grpc.ServiceCall call,
      $async.Future<$30.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$30.GetUserProfileResponse> getUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.GetUserProfileRequest> request) async {
    return getUserProfile(call, await request);
  }

  $async.Future<$30.UpdateUserProfileResponse> updateUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.UpdateUserProfileRequest> request) async {
    return updateUserProfile(call, await request);
  }

  $async.Future<$30.UpdatePasswordResponse> updatePassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.UpdatePasswordRequest> request) async {
    return updatePassword(call, await request);
  }

  $async.Future<$30.UpdatePreferencesResponse> updatePreferences_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.UpdatePreferencesRequest> request) async {
    return updatePreferences(call, await request);
  }

  $async.Future<$30.UploadIDDocumentResponse> uploadIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.UploadIDDocumentRequest> request) async {
    return uploadIDDocument(call, await request);
  }

  $async.Future<$30.GetIDDocumentsResponse> getIDDocuments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.GetIDDocumentsRequest> request) async {
    return getIDDocuments(call, await request);
  }

  $async.Future<$30.VerifyIDDocumentResponse> verifyIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.VerifyIDDocumentRequest> request) async {
    return verifyIDDocument(call, await request);
  }

  $async.Future<$30.UserRegisterFaceResponse> registerFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.UserRegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$30.UserVerifyFaceResponse> verifyFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.UserVerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$30.GetFacialDataResponse> getFacialData_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.GetFacialDataRequest> request) async {
    return getFacialData(call, await request);
  }

  $async.Future<$30.SetPasscodeResponse> setPasscode_Pre($grpc.ServiceCall call,
      $async.Future<$30.SetPasscodeRequest> request) async {
    return setPasscode(call, await request);
  }

  $async.Future<$30.VerifyPasscodeResponse> verifyPasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.VerifyPasscodeRequest> request) async {
    return verifyPasscode(call, await request);
  }

  $async.Future<$30.RemovePasscodeResponse> removePasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.RemovePasscodeRequest> request) async {
    return removePasscode(call, await request);
  }

  $async.Future<$30.CheckPasscodeExistsResponse> checkPasscodeExists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.CheckPasscodeExistsRequest> request) async {
    return checkPasscodeExists(call, await request);
  }

  $async.Future<$30.UpdateDevicePermissionsResponse>
      updateDevicePermissions_Pre($grpc.ServiceCall call,
          $async.Future<$30.UpdateDevicePermissionsRequest> request) async {
    return updateDevicePermissions(call, await request);
  }

  $async.Future<$30.GetDevicePermissionsResponse> getDevicePermissions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.GetDevicePermissionsRequest> request) async {
    return getDevicePermissions(call, await request);
  }

  $async.Future<$30.CreateUserResponse> createUser(
      $grpc.ServiceCall call, $30.CreateUserRequest request);
  $async.Future<$30.GetUserProfileResponse> getUserProfile(
      $grpc.ServiceCall call, $30.GetUserProfileRequest request);
  $async.Future<$30.UpdateUserProfileResponse> updateUserProfile(
      $grpc.ServiceCall call, $30.UpdateUserProfileRequest request);
  $async.Future<$30.UpdatePasswordResponse> updatePassword(
      $grpc.ServiceCall call, $30.UpdatePasswordRequest request);
  $async.Future<$30.UpdatePreferencesResponse> updatePreferences(
      $grpc.ServiceCall call, $30.UpdatePreferencesRequest request);
  $async.Future<$30.UploadIDDocumentResponse> uploadIDDocument(
      $grpc.ServiceCall call, $30.UploadIDDocumentRequest request);
  $async.Future<$30.GetIDDocumentsResponse> getIDDocuments(
      $grpc.ServiceCall call, $30.GetIDDocumentsRequest request);
  $async.Future<$30.VerifyIDDocumentResponse> verifyIDDocument(
      $grpc.ServiceCall call, $30.VerifyIDDocumentRequest request);
  $async.Future<$30.UserRegisterFaceResponse> registerFace(
      $grpc.ServiceCall call, $30.UserRegisterFaceRequest request);
  $async.Future<$30.UserVerifyFaceResponse> verifyFace(
      $grpc.ServiceCall call, $30.UserVerifyFaceRequest request);
  $async.Future<$30.GetFacialDataResponse> getFacialData(
      $grpc.ServiceCall call, $30.GetFacialDataRequest request);
  $async.Future<$30.SetPasscodeResponse> setPasscode(
      $grpc.ServiceCall call, $30.SetPasscodeRequest request);
  $async.Future<$30.VerifyPasscodeResponse> verifyPasscode(
      $grpc.ServiceCall call, $30.VerifyPasscodeRequest request);
  $async.Future<$30.RemovePasscodeResponse> removePasscode(
      $grpc.ServiceCall call, $30.RemovePasscodeRequest request);
  $async.Future<$30.CheckPasscodeExistsResponse> checkPasscodeExists(
      $grpc.ServiceCall call, $30.CheckPasscodeExistsRequest request);
  $async.Future<$30.UpdateDevicePermissionsResponse> updateDevicePermissions(
      $grpc.ServiceCall call, $30.UpdateDevicePermissionsRequest request);
  $async.Future<$30.GetDevicePermissionsResponse> getDevicePermissions(
      $grpc.ServiceCall call, $30.GetDevicePermissionsRequest request);
}
