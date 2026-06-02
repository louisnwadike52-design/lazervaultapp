///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $42;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$createUser =
      $grpc.ClientMethod<$42.CreateUserRequest, $42.CreateUserResponse>(
          '/pb.UserService/CreateUser',
          ($42.CreateUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.CreateUserResponse.fromBuffer(value));
  static final _$getUserProfile =
      $grpc.ClientMethod<$42.GetUserProfileRequest, $42.GetUserProfileResponse>(
          '/pb.UserService/GetUserProfile',
          ($42.GetUserProfileRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.GetUserProfileResponse.fromBuffer(value));
  static final _$updateUserProfile = $grpc.ClientMethod<
          $42.UpdateUserProfileRequest, $42.UpdateUserProfileResponse>(
      '/pb.UserService/UpdateUserProfile',
      ($42.UpdateUserProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.UpdateUserProfileResponse.fromBuffer(value));
  static final _$updatePassword =
      $grpc.ClientMethod<$42.UpdatePasswordRequest, $42.UpdatePasswordResponse>(
          '/pb.UserService/UpdatePassword',
          ($42.UpdatePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.UpdatePasswordResponse.fromBuffer(value));
  static final _$updatePreferences = $grpc.ClientMethod<
          $42.UpdatePreferencesRequest, $42.UpdatePreferencesResponse>(
      '/pb.UserService/UpdatePreferences',
      ($42.UpdatePreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.UpdatePreferencesResponse.fromBuffer(value));
  static final _$uploadIDDocument = $grpc.ClientMethod<
          $42.UploadIDDocumentRequest, $42.UploadIDDocumentResponse>(
      '/pb.UserService/UploadIDDocument',
      ($42.UploadIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.UploadIDDocumentResponse.fromBuffer(value));
  static final _$getIDDocuments =
      $grpc.ClientMethod<$42.GetIDDocumentsRequest, $42.GetIDDocumentsResponse>(
          '/pb.UserService/GetIDDocuments',
          ($42.GetIDDocumentsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.GetIDDocumentsResponse.fromBuffer(value));
  static final _$verifyIDDocument = $grpc.ClientMethod<
          $42.VerifyIDDocumentRequest, $42.VerifyIDDocumentResponse>(
      '/pb.UserService/VerifyIDDocument',
      ($42.VerifyIDDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.VerifyIDDocumentResponse.fromBuffer(value));
  static final _$registerFace = $grpc.ClientMethod<$42.UserRegisterFaceRequest,
          $42.UserRegisterFaceResponse>(
      '/pb.UserService/RegisterFace',
      ($42.UserRegisterFaceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.UserRegisterFaceResponse.fromBuffer(value));
  static final _$verifyFace =
      $grpc.ClientMethod<$42.UserVerifyFaceRequest, $42.UserVerifyFaceResponse>(
          '/pb.UserService/VerifyFace',
          ($42.UserVerifyFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.UserVerifyFaceResponse.fromBuffer(value));
  static final _$getFacialData =
      $grpc.ClientMethod<$42.GetFacialDataRequest, $42.GetFacialDataResponse>(
          '/pb.UserService/GetFacialData',
          ($42.GetFacialDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.GetFacialDataResponse.fromBuffer(value));
  static final _$setPasscode =
      $grpc.ClientMethod<$42.SetPasscodeRequest, $42.SetPasscodeResponse>(
          '/pb.UserService/SetPasscode',
          ($42.SetPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.SetPasscodeResponse.fromBuffer(value));
  static final _$verifyPasscode =
      $grpc.ClientMethod<$42.VerifyPasscodeRequest, $42.VerifyPasscodeResponse>(
          '/pb.UserService/VerifyPasscode',
          ($42.VerifyPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.VerifyPasscodeResponse.fromBuffer(value));
  static final _$removePasscode =
      $grpc.ClientMethod<$42.RemovePasscodeRequest, $42.RemovePasscodeResponse>(
          '/pb.UserService/RemovePasscode',
          ($42.RemovePasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.RemovePasscodeResponse.fromBuffer(value));
  static final _$checkPasscodeExists = $grpc.ClientMethod<
          $42.CheckPasscodeExistsRequest, $42.CheckPasscodeExistsResponse>(
      '/pb.UserService/CheckPasscodeExists',
      ($42.CheckPasscodeExistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.CheckPasscodeExistsResponse.fromBuffer(value));
  static final _$updateDevicePermissions = $grpc.ClientMethod<
          $42.UpdateDevicePermissionsRequest,
          $42.UpdateDevicePermissionsResponse>(
      '/pb.UserService/UpdateDevicePermissions',
      ($42.UpdateDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.UpdateDevicePermissionsResponse.fromBuffer(value));
  static final _$getDevicePermissions = $grpc.ClientMethod<
          $42.GetDevicePermissionsRequest, $42.GetDevicePermissionsResponse>(
      '/pb.UserService/GetDevicePermissions',
      ($42.GetDevicePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetDevicePermissionsResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$42.CreateUserResponse> createUser(
      $42.CreateUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetUserProfileResponse> getUserProfile(
      $42.GetUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$42.UpdateUserProfileResponse> updateUserProfile(
      $42.UpdateUserProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserProfile, request, options: options);
  }

  $grpc.ResponseFuture<$42.UpdatePasswordResponse> updatePassword(
      $42.UpdatePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePassword, request, options: options);
  }

  $grpc.ResponseFuture<$42.UpdatePreferencesResponse> updatePreferences(
      $42.UpdatePreferencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePreferences, request, options: options);
  }

  $grpc.ResponseFuture<$42.UploadIDDocumentResponse> uploadIDDocument(
      $42.UploadIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetIDDocumentsResponse> getIDDocuments(
      $42.GetIDDocumentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$42.VerifyIDDocumentResponse> verifyIDDocument(
      $42.VerifyIDDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyIDDocument, request, options: options);
  }

  $grpc.ResponseFuture<$42.UserRegisterFaceResponse> registerFace(
      $42.UserRegisterFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerFace, request, options: options);
  }

  $grpc.ResponseFuture<$42.UserVerifyFaceResponse> verifyFace(
      $42.UserVerifyFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyFace, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetFacialDataResponse> getFacialData(
      $42.GetFacialDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFacialData, request, options: options);
  }

  $grpc.ResponseFuture<$42.SetPasscodeResponse> setPasscode(
      $42.SetPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$42.VerifyPasscodeResponse> verifyPasscode(
      $42.VerifyPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$42.RemovePasscodeResponse> removePasscode(
      $42.RemovePasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removePasscode, request, options: options);
  }

  $grpc.ResponseFuture<$42.CheckPasscodeExistsResponse> checkPasscodeExists(
      $42.CheckPasscodeExistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkPasscodeExists, request, options: options);
  }

  $grpc.ResponseFuture<$42.UpdateDevicePermissionsResponse>
      updateDevicePermissions($42.UpdateDevicePermissionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDevicePermissions, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.GetDevicePermissionsResponse> getDevicePermissions(
      $42.GetDevicePermissionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDevicePermissions, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UserService';

  UserServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$42.CreateUserRequest, $42.CreateUserResponse>(
            'CreateUser',
            createUser_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $42.CreateUserRequest.fromBuffer(value),
            ($42.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetUserProfileRequest,
            $42.GetUserProfileResponse>(
        'GetUserProfile',
        getUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetUserProfileRequest.fromBuffer(value),
        ($42.GetUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.UpdateUserProfileRequest,
            $42.UpdateUserProfileResponse>(
        'UpdateUserProfile',
        updateUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.UpdateUserProfileRequest.fromBuffer(value),
        ($42.UpdateUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.UpdatePasswordRequest,
            $42.UpdatePasswordResponse>(
        'UpdatePassword',
        updatePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.UpdatePasswordRequest.fromBuffer(value),
        ($42.UpdatePasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.UpdatePreferencesRequest,
            $42.UpdatePreferencesResponse>(
        'UpdatePreferences',
        updatePreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.UpdatePreferencesRequest.fromBuffer(value),
        ($42.UpdatePreferencesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.UploadIDDocumentRequest,
            $42.UploadIDDocumentResponse>(
        'UploadIDDocument',
        uploadIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.UploadIDDocumentRequest.fromBuffer(value),
        ($42.UploadIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetIDDocumentsRequest,
            $42.GetIDDocumentsResponse>(
        'GetIDDocuments',
        getIDDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetIDDocumentsRequest.fromBuffer(value),
        ($42.GetIDDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.VerifyIDDocumentRequest,
            $42.VerifyIDDocumentResponse>(
        'VerifyIDDocument',
        verifyIDDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.VerifyIDDocumentRequest.fromBuffer(value),
        ($42.VerifyIDDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.UserRegisterFaceRequest,
            $42.UserRegisterFaceResponse>(
        'RegisterFace',
        registerFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.UserRegisterFaceRequest.fromBuffer(value),
        ($42.UserRegisterFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.UserVerifyFaceRequest,
            $42.UserVerifyFaceResponse>(
        'VerifyFace',
        verifyFace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.UserVerifyFaceRequest.fromBuffer(value),
        ($42.UserVerifyFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetFacialDataRequest,
            $42.GetFacialDataResponse>(
        'GetFacialData',
        getFacialData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetFacialDataRequest.fromBuffer(value),
        ($42.GetFacialDataResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$42.SetPasscodeRequest, $42.SetPasscodeResponse>(
            'SetPasscode',
            setPasscode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $42.SetPasscodeRequest.fromBuffer(value),
            ($42.SetPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.VerifyPasscodeRequest,
            $42.VerifyPasscodeResponse>(
        'VerifyPasscode',
        verifyPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.VerifyPasscodeRequest.fromBuffer(value),
        ($42.VerifyPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.RemovePasscodeRequest,
            $42.RemovePasscodeResponse>(
        'RemovePasscode',
        removePasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.RemovePasscodeRequest.fromBuffer(value),
        ($42.RemovePasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.CheckPasscodeExistsRequest,
            $42.CheckPasscodeExistsResponse>(
        'CheckPasscodeExists',
        checkPasscodeExists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.CheckPasscodeExistsRequest.fromBuffer(value),
        ($42.CheckPasscodeExistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.UpdateDevicePermissionsRequest,
            $42.UpdateDevicePermissionsResponse>(
        'UpdateDevicePermissions',
        updateDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.UpdateDevicePermissionsRequest.fromBuffer(value),
        ($42.UpdateDevicePermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetDevicePermissionsRequest,
            $42.GetDevicePermissionsResponse>(
        'GetDevicePermissions',
        getDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetDevicePermissionsRequest.fromBuffer(value),
        ($42.GetDevicePermissionsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$42.CreateUserResponse> createUser_Pre($grpc.ServiceCall call,
      $async.Future<$42.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$42.GetUserProfileResponse> getUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetUserProfileRequest> request) async {
    return getUserProfile(call, await request);
  }

  $async.Future<$42.UpdateUserProfileResponse> updateUserProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.UpdateUserProfileRequest> request) async {
    return updateUserProfile(call, await request);
  }

  $async.Future<$42.UpdatePasswordResponse> updatePassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.UpdatePasswordRequest> request) async {
    return updatePassword(call, await request);
  }

  $async.Future<$42.UpdatePreferencesResponse> updatePreferences_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.UpdatePreferencesRequest> request) async {
    return updatePreferences(call, await request);
  }

  $async.Future<$42.UploadIDDocumentResponse> uploadIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.UploadIDDocumentRequest> request) async {
    return uploadIDDocument(call, await request);
  }

  $async.Future<$42.GetIDDocumentsResponse> getIDDocuments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetIDDocumentsRequest> request) async {
    return getIDDocuments(call, await request);
  }

  $async.Future<$42.VerifyIDDocumentResponse> verifyIDDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.VerifyIDDocumentRequest> request) async {
    return verifyIDDocument(call, await request);
  }

  $async.Future<$42.UserRegisterFaceResponse> registerFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.UserRegisterFaceRequest> request) async {
    return registerFace(call, await request);
  }

  $async.Future<$42.UserVerifyFaceResponse> verifyFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.UserVerifyFaceRequest> request) async {
    return verifyFace(call, await request);
  }

  $async.Future<$42.GetFacialDataResponse> getFacialData_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetFacialDataRequest> request) async {
    return getFacialData(call, await request);
  }

  $async.Future<$42.SetPasscodeResponse> setPasscode_Pre($grpc.ServiceCall call,
      $async.Future<$42.SetPasscodeRequest> request) async {
    return setPasscode(call, await request);
  }

  $async.Future<$42.VerifyPasscodeResponse> verifyPasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.VerifyPasscodeRequest> request) async {
    return verifyPasscode(call, await request);
  }

  $async.Future<$42.RemovePasscodeResponse> removePasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.RemovePasscodeRequest> request) async {
    return removePasscode(call, await request);
  }

  $async.Future<$42.CheckPasscodeExistsResponse> checkPasscodeExists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.CheckPasscodeExistsRequest> request) async {
    return checkPasscodeExists(call, await request);
  }

  $async.Future<$42.UpdateDevicePermissionsResponse>
      updateDevicePermissions_Pre($grpc.ServiceCall call,
          $async.Future<$42.UpdateDevicePermissionsRequest> request) async {
    return updateDevicePermissions(call, await request);
  }

  $async.Future<$42.GetDevicePermissionsResponse> getDevicePermissions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetDevicePermissionsRequest> request) async {
    return getDevicePermissions(call, await request);
  }

  $async.Future<$42.CreateUserResponse> createUser(
      $grpc.ServiceCall call, $42.CreateUserRequest request);
  $async.Future<$42.GetUserProfileResponse> getUserProfile(
      $grpc.ServiceCall call, $42.GetUserProfileRequest request);
  $async.Future<$42.UpdateUserProfileResponse> updateUserProfile(
      $grpc.ServiceCall call, $42.UpdateUserProfileRequest request);
  $async.Future<$42.UpdatePasswordResponse> updatePassword(
      $grpc.ServiceCall call, $42.UpdatePasswordRequest request);
  $async.Future<$42.UpdatePreferencesResponse> updatePreferences(
      $grpc.ServiceCall call, $42.UpdatePreferencesRequest request);
  $async.Future<$42.UploadIDDocumentResponse> uploadIDDocument(
      $grpc.ServiceCall call, $42.UploadIDDocumentRequest request);
  $async.Future<$42.GetIDDocumentsResponse> getIDDocuments(
      $grpc.ServiceCall call, $42.GetIDDocumentsRequest request);
  $async.Future<$42.VerifyIDDocumentResponse> verifyIDDocument(
      $grpc.ServiceCall call, $42.VerifyIDDocumentRequest request);
  $async.Future<$42.UserRegisterFaceResponse> registerFace(
      $grpc.ServiceCall call, $42.UserRegisterFaceRequest request);
  $async.Future<$42.UserVerifyFaceResponse> verifyFace(
      $grpc.ServiceCall call, $42.UserVerifyFaceRequest request);
  $async.Future<$42.GetFacialDataResponse> getFacialData(
      $grpc.ServiceCall call, $42.GetFacialDataRequest request);
  $async.Future<$42.SetPasscodeResponse> setPasscode(
      $grpc.ServiceCall call, $42.SetPasscodeRequest request);
  $async.Future<$42.VerifyPasscodeResponse> verifyPasscode(
      $grpc.ServiceCall call, $42.VerifyPasscodeRequest request);
  $async.Future<$42.RemovePasscodeResponse> removePasscode(
      $grpc.ServiceCall call, $42.RemovePasscodeRequest request);
  $async.Future<$42.CheckPasscodeExistsResponse> checkPasscodeExists(
      $grpc.ServiceCall call, $42.CheckPasscodeExistsRequest request);
  $async.Future<$42.UpdateDevicePermissionsResponse> updateDevicePermissions(
      $grpc.ServiceCall call, $42.UpdateDevicePermissionsRequest request);
  $async.Future<$42.GetDevicePermissionsResponse> getDevicePermissions(
      $grpc.ServiceCall call, $42.GetDevicePermissionsRequest request);
}
