///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $25;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$createUser =
      $grpc.ClientMethod<$25.CreateUserRequest, $25.CreateUserResponse>(
          '/pb.UserService/CreateUser',
          ($25.CreateUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $25.CreateUserResponse.fromBuffer(value));
  static final _$getUserProfile =
      $grpc.ClientMethod<$25.GetUserProfileRequest, $25.GetUserProfileResponse>(
          '/pb.UserService/GetUserProfile',
          ($25.GetUserProfileRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $25.GetUserProfileResponse.fromBuffer(value));
  static final _$updateUserProfile = $grpc.ClientMethod<
          $25.UpdateUserProfileRequest, $25.UpdateUserProfileResponse>(
      '/pb.UserService/UpdateUserProfile',
      ($25.UpdateUserProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.UpdateUserProfileResponse.fromBuffer(value));
  static final _$updatePassword =
      $grpc.ClientMethod<$25.UpdatePasswordRequest, $25.UpdatePasswordResponse>(
          '/pb.UserService/UpdatePassword',
          ($25.UpdatePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $25.UpdatePasswordResponse.fromBuffer(value));
  static final _$updatePreferences = $grpc.ClientMethod<
          $25.UpdatePreferencesRequest, $25.UpdatePreferencesResponse>(
      '/pb.UserService/UpdatePreferences',
      ($25.UpdatePreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.UpdatePreferencesResponse.fromBuffer(value));
  static final _$uploadIDDocument = $grpc.ClientMethod<
          $25.UploadIDDocumentRequest, $25.UploadIDDocumentResponse>(
      '/pb.UserService/UploadIDDocument',
      ($25.UploadIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.UploadIDDocumentResponse.fromBuffer(value));
  static final _$getIDDocuments =
      $grpc.ClientMethod<$25.GetIDDocumentsRequest, $25.GetIDDocumentsResponse>(
          '/pb.UserService/GetIDDocuments',
          ($25.GetIDDocumentsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $25.GetIDDocumentsResponse.fromBuffer(value));
  static final _$verifyIDDocument = $grpc.ClientMethod<
          $25.VerifyIDDocumentRequest, $25.VerifyIDDocumentResponse>(
      '/pb.UserService/VerifyIDDocument',
      ($25.VerifyIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.VerifyIDDocumentResponse.fromBuffer(value));
  static final _$registerFace = $grpc.ClientMethod<$25.UserRegisterFaceRequest,
          $25.UserRegisterFaceResponse>(
      '/pb.UserService/RegisterFace',
      ($25.UserRegisterFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.UserRegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace =
      $grpc.ClientMethod<$25.UserVerifyFaceRequest, $25.UserVerifyFaceResponse>(
          '/pb.UserService/VerifyFace',
          ($25.UserVerifyFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $25.UserVerifyFaceResponse.fromBuffer(value));
  static final _$getFacialData =
      $grpc.ClientMethod<$25.GetFacialDataRequest, $25.GetFacialDataResponse>(
          '/pb.UserService/GetFacialData',
          ($25.GetFacialDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $25.GetFacialDataResponse.fromBuffer(value));
  static final _$setPasscode =
      $grpc.ClientMethod<$25.SetPasscodeRequest, $25.SetPasscodeResponse>(
          '/pb.UserService/SetPasscode',
          ($25.SetPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $25.SetPasscodeResponse.fromBuffer(value));
  static final _$verifyPasscode =
      $grpc.ClientMethod<$25.VerifyPasscodeRequest, $25.VerifyPasscodeResponse>(
          '/pb.UserService/VerifyPasscode',
          ($25.VerifyPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $25.VerifyPasscodeResponse.fromBuffer(value));
  static final _$removePasscode =
      $grpc.ClientMethod<$25.RemovePasscodeRequest, $25.RemovePasscodeResponse>(
          '/pb.UserService/RemovePasscode',
          ($25.RemovePasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $25.RemovePasscodeResponse.fromBuffer(value));
  static final _$checkPasscodeExists = $grpc.ClientMethod<
          $25.CheckPasscodeExistsRequest, $25.CheckPasscodeExistsResponse>(
      '/pb.UserService/CheckPasscodeExists',
      ($25.CheckPasscodeExistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.CheckPasscodeExistsResponse.fromBuffer(value));
  static final _$updateDevicePermissions = $grpc.ClientMethod<
          $25.UpdateDevicePermissionsRequest,
          $25.UpdateDevicePermissionsResponse>(
      '/pb.UserService/UpdateDevicePermissions',
      ($25.UpdateDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.UpdateDevicePermissionsResponse.fromBuffer(value));
  static final _$getDevicePermissions = $grpc.ClientMethod<
          $25.GetDevicePermissionsRequest, $25.GetDevicePermissionsResponse>(
      '/pb.UserService/GetDevicePermissions',
      ($25.GetDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetDevicePermissionsResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$25.CreateUserResponse> createUser(
      $25.CreateUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$25.GetUserProfileResponse> getUserProfile(
      $25.GetUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$25.UpdateUserProfileResponse> updateUserProfile(
      $25.UpdateUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$25.UpdatePasswordResponse> updatePassword(
      $25.UpdatePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePassword, request, options: options);
  }

  $grpc.ResponseFuture<$25.UpdatePreferencesResponse> updatePreferences(
      $25.UpdatePreferencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePreferences, request, options: options);
  }

  $grpc.ResponseFuture<$25.UploadIDDocumentResponse> uploadIDDocument(
      $25.UploadIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$25.GetIDDocumentsResponse> getIDDocuments(
      $25.GetIDDocumentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$25.VerifyIDDocumentResponse> verifyIDDocument(
      $25.VerifyIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$25.UserRegisterFaceResponse> registerFace(
      $25.UserRegisterFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$25.UserVerifyFaceResponse> verifyFace(
      $25.UserVerifyFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$25.GetFacialDataResponse> getFacialData(
      $25.GetFacialDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFacialData, request, options: options);
  }

  $grpc.ResponseFuture<$25.SetPasscodeResponse> setPasscode(
      $25.SetPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$25.VerifyPasscodeResponse> verifyPasscode(
      $25.VerifyPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$25.RemovePasscodeResponse> removePasscode(
      $25.RemovePasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removePasscode, request, options: options);
  }

  $grpc.ResponseFuture<$25.CheckPasscodeExistsResponse> checkPasscodeExists(
      $25.CheckPasscodeExistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkPasscodeExists, request, options: options);
  }

  $grpc.ResponseFuture<$25.UpdateDevicePermissionsResponse>
      updateDevicePermissions($25.UpdateDevicePermissionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDevicePermissions, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.GetDevicePermissionsResponse> getDevicePermissions(
      $25.GetDevicePermissionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDevicePermissions, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UserService';

  UserServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$25.CreateUserRequest, $25.CreateUserResponse>(
            'CreateUser',
            createUser_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $25.CreateUserRequest.fromBuffer(value),
            ($25.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetUserProfileRequest,
            $25.GetUserProfileResponse>(
        'GetUserProfile',
        getUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetUserProfileRequest.fromBuffer(value),
        ($25.GetUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.UpdateUserProfileRequest,
            $25.UpdateUserProfileResponse>(
        'UpdateUserProfile',
        updateUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.UpdateUserProfileRequest.fromBuffer(value),
        ($25.UpdateUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.UpdatePasswordRequest,
            $25.UpdatePasswordResponse>(
        'UpdatePassword',
        updatePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.UpdatePasswordRequest.fromBuffer(value),
        ($25.UpdatePasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.UpdatePreferencesRequest,
            $25.UpdatePreferencesResponse>(
        'UpdatePreferences',
        updatePreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.UpdatePreferencesRequest.fromBuffer(value),
        ($25.UpdatePreferencesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.UploadIDDocumentRequest,
            $25.UploadIDDocumentResponse>(
        'UploadIDDocument',
        uploadIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.UploadIDDocumentRequest.fromBuffer(value),
        ($25.UploadIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetIDDocumentsRequest,
            $25.GetIDDocumentsResponse>(
        'GetIDDocuments',
        getIDDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetIDDocumentsRequest.fromBuffer(value),
        ($25.GetIDDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.VerifyIDDocumentRequest,
            $25.VerifyIDDocumentResponse>(
        'VerifyIDDocument',
        verifyIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.VerifyIDDocumentRequest.fromBuffer(value),
        ($25.VerifyIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.UserRegisterFaceRequest,
            $25.UserRegisterFaceResponse>(
        'RegisterFace',
        registerFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.UserRegisterFaceRequest.fromBuffer(value),
        ($25.UserRegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.UserVerifyFaceRequest,
            $25.UserVerifyFaceResponse>(
        'VerifyFace',
        verifyFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.UserVerifyFaceRequest.fromBuffer(value),
        ($25.UserVerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetFacialDataRequest,
            $25.GetFacialDataResponse>(
        'GetFacialData',
        getFacialData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetFacialDataRequest.fromBuffer(value),
        ($25.GetFacialDataResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$25.SetPasscodeRequest, $25.SetPasscodeResponse>(
            'SetPasscode',
            setPasscode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $25.SetPasscodeRequest.fromBuffer(value),
            ($25.SetPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.VerifyPasscodeRequest,
            $25.VerifyPasscodeResponse>(
        'VerifyPasscode',
        verifyPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.VerifyPasscodeRequest.fromBuffer(value),
        ($25.VerifyPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.RemovePasscodeRequest,
            $25.RemovePasscodeResponse>(
        'RemovePasscode',
        removePasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.RemovePasscodeRequest.fromBuffer(value),
        ($25.RemovePasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.CheckPasscodeExistsRequest,
            $25.CheckPasscodeExistsResponse>(
        'CheckPasscodeExists',
        checkPasscodeExists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.CheckPasscodeExistsRequest.fromBuffer(value),
        ($25.CheckPasscodeExistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.UpdateDevicePermissionsRequest,
            $25.UpdateDevicePermissionsResponse>(
        'UpdateDevicePermissions',
        updateDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.UpdateDevicePermissionsRequest.fromBuffer(value),
        ($25.UpdateDevicePermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetDevicePermissionsRequest,
            $25.GetDevicePermissionsResponse>(
        'GetDevicePermissions',
        getDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetDevicePermissionsRequest.fromBuffer(value),
        ($25.GetDevicePermissionsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$25.CreateUserResponse> createUser_Pre($grpc.ServiceCall call,
      $async.Future<$25.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$25.GetUserProfileResponse> getUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.GetUserProfileRequest> request) async {
    return getUserProfile(call, await request);
  }

  $async.Future<$25.UpdateUserProfileResponse> updateUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.UpdateUserProfileRequest> request) async {
    return updateUserProfile(call, await request);
  }

  $async.Future<$25.UpdatePasswordResponse> updatePassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.UpdatePasswordRequest> request) async {
    return updatePassword(call, await request);
  }

  $async.Future<$25.UpdatePreferencesResponse> updatePreferences_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.UpdatePreferencesRequest> request) async {
    return updatePreferences(call, await request);
  }

  $async.Future<$25.UploadIDDocumentResponse> uploadIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.UploadIDDocumentRequest> request) async {
    return uploadIDDocument(call, await request);
  }

  $async.Future<$25.GetIDDocumentsResponse> getIDDocuments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.GetIDDocumentsRequest> request) async {
    return getIDDocuments(call, await request);
  }

  $async.Future<$25.VerifyIDDocumentResponse> verifyIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.VerifyIDDocumentRequest> request) async {
    return verifyIDDocument(call, await request);
  }

  $async.Future<$25.UserRegisterFaceResponse> registerFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.UserRegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$25.UserVerifyFaceResponse> verifyFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.UserVerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$25.GetFacialDataResponse> getFacialData_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.GetFacialDataRequest> request) async {
    return getFacialData(call, await request);
  }

  $async.Future<$25.SetPasscodeResponse> setPasscode_Pre($grpc.ServiceCall call,
      $async.Future<$25.SetPasscodeRequest> request) async {
    return setPasscode(call, await request);
  }

  $async.Future<$25.VerifyPasscodeResponse> verifyPasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.VerifyPasscodeRequest> request) async {
    return verifyPasscode(call, await request);
  }

  $async.Future<$25.RemovePasscodeResponse> removePasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.RemovePasscodeRequest> request) async {
    return removePasscode(call, await request);
  }

  $async.Future<$25.CheckPasscodeExistsResponse> checkPasscodeExists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.CheckPasscodeExistsRequest> request) async {
    return checkPasscodeExists(call, await request);
  }

  $async.Future<$25.UpdateDevicePermissionsResponse>
      updateDevicePermissions_Pre($grpc.ServiceCall call,
          $async.Future<$25.UpdateDevicePermissionsRequest> request) async {
    return updateDevicePermissions(call, await request);
  }

  $async.Future<$25.GetDevicePermissionsResponse> getDevicePermissions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.GetDevicePermissionsRequest> request) async {
    return getDevicePermissions(call, await request);
  }

  $async.Future<$25.CreateUserResponse> createUser(
      $grpc.ServiceCall call, $25.CreateUserRequest request);
  $async.Future<$25.GetUserProfileResponse> getUserProfile(
      $grpc.ServiceCall call, $25.GetUserProfileRequest request);
  $async.Future<$25.UpdateUserProfileResponse> updateUserProfile(
      $grpc.ServiceCall call, $25.UpdateUserProfileRequest request);
  $async.Future<$25.UpdatePasswordResponse> updatePassword(
      $grpc.ServiceCall call, $25.UpdatePasswordRequest request);
  $async.Future<$25.UpdatePreferencesResponse> updatePreferences(
      $grpc.ServiceCall call, $25.UpdatePreferencesRequest request);
  $async.Future<$25.UploadIDDocumentResponse> uploadIDDocument(
      $grpc.ServiceCall call, $25.UploadIDDocumentRequest request);
  $async.Future<$25.GetIDDocumentsResponse> getIDDocuments(
      $grpc.ServiceCall call, $25.GetIDDocumentsRequest request);
  $async.Future<$25.VerifyIDDocumentResponse> verifyIDDocument(
      $grpc.ServiceCall call, $25.VerifyIDDocumentRequest request);
  $async.Future<$25.UserRegisterFaceResponse> registerFace(
      $grpc.ServiceCall call, $25.UserRegisterFaceRequest request);
  $async.Future<$25.UserVerifyFaceResponse> verifyFace(
      $grpc.ServiceCall call, $25.UserVerifyFaceRequest request);
  $async.Future<$25.GetFacialDataResponse> getFacialData(
      $grpc.ServiceCall call, $25.GetFacialDataRequest request);
  $async.Future<$25.SetPasscodeResponse> setPasscode(
      $grpc.ServiceCall call, $25.SetPasscodeRequest request);
  $async.Future<$25.VerifyPasscodeResponse> verifyPasscode(
      $grpc.ServiceCall call, $25.VerifyPasscodeRequest request);
  $async.Future<$25.RemovePasscodeResponse> removePasscode(
      $grpc.ServiceCall call, $25.RemovePasscodeRequest request);
  $async.Future<$25.CheckPasscodeExistsResponse> checkPasscodeExists(
      $grpc.ServiceCall call, $25.CheckPasscodeExistsRequest request);
  $async.Future<$25.UpdateDevicePermissionsResponse> updateDevicePermissions(
      $grpc.ServiceCall call, $25.UpdateDevicePermissionsRequest request);
  $async.Future<$25.GetDevicePermissionsResponse> getDevicePermissions(
      $grpc.ServiceCall call, $25.GetDevicePermissionsRequest request);
}
