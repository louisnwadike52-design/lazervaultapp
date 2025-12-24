///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $22;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$createUser =
      $grpc.ClientMethod<$22.CreateUserRequest, $22.CreateUserResponse>(
          '/pb.UserService/CreateUser',
          ($22.CreateUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.CreateUserResponse.fromBuffer(value));
  static final _$getUserProfile =
      $grpc.ClientMethod<$22.GetUserProfileRequest, $22.GetUserProfileResponse>(
          '/pb.UserService/GetUserProfile',
          ($22.GetUserProfileRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.GetUserProfileResponse.fromBuffer(value));
  static final _$updateUserProfile = $grpc.ClientMethod<
          $22.UpdateUserProfileRequest, $22.UpdateUserProfileResponse>(
      '/pb.UserService/UpdateUserProfile',
      ($22.UpdateUserProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UpdateUserProfileResponse.fromBuffer(value));
  static final _$updatePassword =
      $grpc.ClientMethod<$22.UpdatePasswordRequest, $22.UpdatePasswordResponse>(
          '/pb.UserService/UpdatePassword',
          ($22.UpdatePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.UpdatePasswordResponse.fromBuffer(value));
  static final _$updatePreferences = $grpc.ClientMethod<
          $22.UpdatePreferencesRequest, $22.UpdatePreferencesResponse>(
      '/pb.UserService/UpdatePreferences',
      ($22.UpdatePreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UpdatePreferencesResponse.fromBuffer(value));
  static final _$uploadIDDocument = $grpc.ClientMethod<
          $22.UploadIDDocumentRequest, $22.UploadIDDocumentResponse>(
      '/pb.UserService/UploadIDDocument',
      ($22.UploadIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UploadIDDocumentResponse.fromBuffer(value));
  static final _$getIDDocuments =
      $grpc.ClientMethod<$22.GetIDDocumentsRequest, $22.GetIDDocumentsResponse>(
          '/pb.UserService/GetIDDocuments',
          ($22.GetIDDocumentsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.GetIDDocumentsResponse.fromBuffer(value));
  static final _$verifyIDDocument = $grpc.ClientMethod<
          $22.VerifyIDDocumentRequest, $22.VerifyIDDocumentResponse>(
      '/pb.UserService/VerifyIDDocument',
      ($22.VerifyIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.VerifyIDDocumentResponse.fromBuffer(value));
  static final _$registerFace = $grpc.ClientMethod<$22.UserRegisterFaceRequest,
          $22.UserRegisterFaceResponse>(
      '/pb.UserService/RegisterFace',
      ($22.UserRegisterFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UserRegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace =
      $grpc.ClientMethod<$22.UserVerifyFaceRequest, $22.UserVerifyFaceResponse>(
          '/pb.UserService/VerifyFace',
          ($22.UserVerifyFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.UserVerifyFaceResponse.fromBuffer(value));
  static final _$getFacialData =
      $grpc.ClientMethod<$22.GetFacialDataRequest, $22.GetFacialDataResponse>(
          '/pb.UserService/GetFacialData',
          ($22.GetFacialDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.GetFacialDataResponse.fromBuffer(value));
  static final _$setPasscode =
      $grpc.ClientMethod<$22.SetPasscodeRequest, $22.SetPasscodeResponse>(
          '/pb.UserService/SetPasscode',
          ($22.SetPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.SetPasscodeResponse.fromBuffer(value));
  static final _$verifyPasscode =
      $grpc.ClientMethod<$22.VerifyPasscodeRequest, $22.VerifyPasscodeResponse>(
          '/pb.UserService/VerifyPasscode',
          ($22.VerifyPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.VerifyPasscodeResponse.fromBuffer(value));
  static final _$removePasscode =
      $grpc.ClientMethod<$22.RemovePasscodeRequest, $22.RemovePasscodeResponse>(
          '/pb.UserService/RemovePasscode',
          ($22.RemovePasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.RemovePasscodeResponse.fromBuffer(value));
  static final _$checkPasscodeExists = $grpc.ClientMethod<
          $22.CheckPasscodeExistsRequest, $22.CheckPasscodeExistsResponse>(
      '/pb.UserService/CheckPasscodeExists',
      ($22.CheckPasscodeExistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.CheckPasscodeExistsResponse.fromBuffer(value));
  static final _$updateDevicePermissions = $grpc.ClientMethod<
          $22.UpdateDevicePermissionsRequest,
          $22.UpdateDevicePermissionsResponse>(
      '/pb.UserService/UpdateDevicePermissions',
      ($22.UpdateDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UpdateDevicePermissionsResponse.fromBuffer(value));
  static final _$getDevicePermissions = $grpc.ClientMethod<
          $22.GetDevicePermissionsRequest, $22.GetDevicePermissionsResponse>(
      '/pb.UserService/GetDevicePermissions',
      ($22.GetDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetDevicePermissionsResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$22.CreateUserResponse> createUser(
      $22.CreateUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetUserProfileResponse> getUserProfile(
      $22.GetUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$22.UpdateUserProfileResponse> updateUserProfile(
      $22.UpdateUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$22.UpdatePasswordResponse> updatePassword(
      $22.UpdatePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePassword, request, options: options);
  }

  $grpc.ResponseFuture<$22.UpdatePreferencesResponse> updatePreferences(
      $22.UpdatePreferencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePreferences, request, options: options);
  }

  $grpc.ResponseFuture<$22.UploadIDDocumentResponse> uploadIDDocument(
      $22.UploadIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetIDDocumentsResponse> getIDDocuments(
      $22.GetIDDocumentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$22.VerifyIDDocumentResponse> verifyIDDocument(
      $22.VerifyIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$22.UserRegisterFaceResponse> registerFace(
      $22.UserRegisterFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$22.UserVerifyFaceResponse> verifyFace(
      $22.UserVerifyFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetFacialDataResponse> getFacialData(
      $22.GetFacialDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFacialData, request, options: options);
  }

  $grpc.ResponseFuture<$22.SetPasscodeResponse> setPasscode(
      $22.SetPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$22.VerifyPasscodeResponse> verifyPasscode(
      $22.VerifyPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$22.RemovePasscodeResponse> removePasscode(
      $22.RemovePasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removePasscode, request, options: options);
  }

  $grpc.ResponseFuture<$22.CheckPasscodeExistsResponse> checkPasscodeExists(
      $22.CheckPasscodeExistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkPasscodeExists, request, options: options);
  }

  $grpc.ResponseFuture<$22.UpdateDevicePermissionsResponse>
      updateDevicePermissions($22.UpdateDevicePermissionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDevicePermissions, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetDevicePermissionsResponse> getDevicePermissions(
      $22.GetDevicePermissionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDevicePermissions, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UserService';

  UserServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$22.CreateUserRequest, $22.CreateUserResponse>(
            'CreateUser',
            createUser_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.CreateUserRequest.fromBuffer(value),
            ($22.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetUserProfileRequest,
            $22.GetUserProfileResponse>(
        'GetUserProfile',
        getUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetUserProfileRequest.fromBuffer(value),
        ($22.GetUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdateUserProfileRequest,
            $22.UpdateUserProfileResponse>(
        'UpdateUserProfile',
        updateUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UpdateUserProfileRequest.fromBuffer(value),
        ($22.UpdateUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdatePasswordRequest,
            $22.UpdatePasswordResponse>(
        'UpdatePassword',
        updatePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UpdatePasswordRequest.fromBuffer(value),
        ($22.UpdatePasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdatePreferencesRequest,
            $22.UpdatePreferencesResponse>(
        'UpdatePreferences',
        updatePreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UpdatePreferencesRequest.fromBuffer(value),
        ($22.UpdatePreferencesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UploadIDDocumentRequest,
            $22.UploadIDDocumentResponse>(
        'UploadIDDocument',
        uploadIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UploadIDDocumentRequest.fromBuffer(value),
        ($22.UploadIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetIDDocumentsRequest,
            $22.GetIDDocumentsResponse>(
        'GetIDDocuments',
        getIDDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetIDDocumentsRequest.fromBuffer(value),
        ($22.GetIDDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.VerifyIDDocumentRequest,
            $22.VerifyIDDocumentResponse>(
        'VerifyIDDocument',
        verifyIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.VerifyIDDocumentRequest.fromBuffer(value),
        ($22.VerifyIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UserRegisterFaceRequest,
            $22.UserRegisterFaceResponse>(
        'RegisterFace',
        registerFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UserRegisterFaceRequest.fromBuffer(value),
        ($22.UserRegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UserVerifyFaceRequest,
            $22.UserVerifyFaceResponse>(
        'VerifyFace',
        verifyFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UserVerifyFaceRequest.fromBuffer(value),
        ($22.UserVerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetFacialDataRequest,
            $22.GetFacialDataResponse>(
        'GetFacialData',
        getFacialData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetFacialDataRequest.fromBuffer(value),
        ($22.GetFacialDataResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.SetPasscodeRequest, $22.SetPasscodeResponse>(
            'SetPasscode',
            setPasscode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.SetPasscodeRequest.fromBuffer(value),
            ($22.SetPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.VerifyPasscodeRequest,
            $22.VerifyPasscodeResponse>(
        'VerifyPasscode',
        verifyPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.VerifyPasscodeRequest.fromBuffer(value),
        ($22.VerifyPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.RemovePasscodeRequest,
            $22.RemovePasscodeResponse>(
        'RemovePasscode',
        removePasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.RemovePasscodeRequest.fromBuffer(value),
        ($22.RemovePasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.CheckPasscodeExistsRequest,
            $22.CheckPasscodeExistsResponse>(
        'CheckPasscodeExists',
        checkPasscodeExists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.CheckPasscodeExistsRequest.fromBuffer(value),
        ($22.CheckPasscodeExistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdateDevicePermissionsRequest,
            $22.UpdateDevicePermissionsResponse>(
        'UpdateDevicePermissions',
        updateDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UpdateDevicePermissionsRequest.fromBuffer(value),
        ($22.UpdateDevicePermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetDevicePermissionsRequest,
            $22.GetDevicePermissionsResponse>(
        'GetDevicePermissions',
        getDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetDevicePermissionsRequest.fromBuffer(value),
        ($22.GetDevicePermissionsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$22.CreateUserResponse> createUser_Pre($grpc.ServiceCall call,
      $async.Future<$22.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$22.GetUserProfileResponse> getUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetUserProfileRequest> request) async {
    return getUserProfile(call, await request);
  }

  $async.Future<$22.UpdateUserProfileResponse> updateUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UpdateUserProfileRequest> request) async {
    return updateUserProfile(call, await request);
  }

  $async.Future<$22.UpdatePasswordResponse> updatePassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UpdatePasswordRequest> request) async {
    return updatePassword(call, await request);
  }

  $async.Future<$22.UpdatePreferencesResponse> updatePreferences_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UpdatePreferencesRequest> request) async {
    return updatePreferences(call, await request);
  }

  $async.Future<$22.UploadIDDocumentResponse> uploadIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UploadIDDocumentRequest> request) async {
    return uploadIDDocument(call, await request);
  }

  $async.Future<$22.GetIDDocumentsResponse> getIDDocuments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetIDDocumentsRequest> request) async {
    return getIDDocuments(call, await request);
  }

  $async.Future<$22.VerifyIDDocumentResponse> verifyIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.VerifyIDDocumentRequest> request) async {
    return verifyIDDocument(call, await request);
  }

  $async.Future<$22.UserRegisterFaceResponse> registerFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UserRegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$22.UserVerifyFaceResponse> verifyFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UserVerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$22.GetFacialDataResponse> getFacialData_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetFacialDataRequest> request) async {
    return getFacialData(call, await request);
  }

  $async.Future<$22.SetPasscodeResponse> setPasscode_Pre($grpc.ServiceCall call,
      $async.Future<$22.SetPasscodeRequest> request) async {
    return setPasscode(call, await request);
  }

  $async.Future<$22.VerifyPasscodeResponse> verifyPasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.VerifyPasscodeRequest> request) async {
    return verifyPasscode(call, await request);
  }

  $async.Future<$22.RemovePasscodeResponse> removePasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.RemovePasscodeRequest> request) async {
    return removePasscode(call, await request);
  }

  $async.Future<$22.CheckPasscodeExistsResponse> checkPasscodeExists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.CheckPasscodeExistsRequest> request) async {
    return checkPasscodeExists(call, await request);
  }

  $async.Future<$22.UpdateDevicePermissionsResponse>
      updateDevicePermissions_Pre($grpc.ServiceCall call,
          $async.Future<$22.UpdateDevicePermissionsRequest> request) async {
    return updateDevicePermissions(call, await request);
  }

  $async.Future<$22.GetDevicePermissionsResponse> getDevicePermissions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetDevicePermissionsRequest> request) async {
    return getDevicePermissions(call, await request);
  }

  $async.Future<$22.CreateUserResponse> createUser(
      $grpc.ServiceCall call, $22.CreateUserRequest request);
  $async.Future<$22.GetUserProfileResponse> getUserProfile(
      $grpc.ServiceCall call, $22.GetUserProfileRequest request);
  $async.Future<$22.UpdateUserProfileResponse> updateUserProfile(
      $grpc.ServiceCall call, $22.UpdateUserProfileRequest request);
  $async.Future<$22.UpdatePasswordResponse> updatePassword(
      $grpc.ServiceCall call, $22.UpdatePasswordRequest request);
  $async.Future<$22.UpdatePreferencesResponse> updatePreferences(
      $grpc.ServiceCall call, $22.UpdatePreferencesRequest request);
  $async.Future<$22.UploadIDDocumentResponse> uploadIDDocument(
      $grpc.ServiceCall call, $22.UploadIDDocumentRequest request);
  $async.Future<$22.GetIDDocumentsResponse> getIDDocuments(
      $grpc.ServiceCall call, $22.GetIDDocumentsRequest request);
  $async.Future<$22.VerifyIDDocumentResponse> verifyIDDocument(
      $grpc.ServiceCall call, $22.VerifyIDDocumentRequest request);
  $async.Future<$22.UserRegisterFaceResponse> registerFace(
      $grpc.ServiceCall call, $22.UserRegisterFaceRequest request);
  $async.Future<$22.UserVerifyFaceResponse> verifyFace(
      $grpc.ServiceCall call, $22.UserVerifyFaceRequest request);
  $async.Future<$22.GetFacialDataResponse> getFacialData(
      $grpc.ServiceCall call, $22.GetFacialDataRequest request);
  $async.Future<$22.SetPasscodeResponse> setPasscode(
      $grpc.ServiceCall call, $22.SetPasscodeRequest request);
  $async.Future<$22.VerifyPasscodeResponse> verifyPasscode(
      $grpc.ServiceCall call, $22.VerifyPasscodeRequest request);
  $async.Future<$22.RemovePasscodeResponse> removePasscode(
      $grpc.ServiceCall call, $22.RemovePasscodeRequest request);
  $async.Future<$22.CheckPasscodeExistsResponse> checkPasscodeExists(
      $grpc.ServiceCall call, $22.CheckPasscodeExistsRequest request);
  $async.Future<$22.UpdateDevicePermissionsResponse> updateDevicePermissions(
      $grpc.ServiceCall call, $22.UpdateDevicePermissionsRequest request);
  $async.Future<$22.GetDevicePermissionsResponse> getDevicePermissions(
      $grpc.ServiceCall call, $22.GetDevicePermissionsRequest request);
}
