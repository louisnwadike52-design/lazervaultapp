///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'user.pb.dart' as $2;
import 'user.pbjson.dart';

export 'user.pb.dart';

abstract class UserServiceBase extends $pb.GeneratedService {
  $async.Future<$2.CreateUserResponse> createUser($pb.ServerContext ctx, $2.CreateUserRequest request);
  $async.Future<$2.GetUserProfileResponse> getUserProfile($pb.ServerContext ctx, $2.GetUserProfileRequest request);
  $async.Future<$2.UpdateUserProfileResponse> updateUserProfile($pb.ServerContext ctx, $2.UpdateUserProfileRequest request);
  $async.Future<$2.UpdatePasswordResponse> updatePassword($pb.ServerContext ctx, $2.UpdatePasswordRequest request);
  $async.Future<$2.UpdatePreferencesResponse> updatePreferences($pb.ServerContext ctx, $2.UpdatePreferencesRequest request);
  $async.Future<$2.UploadIDDocumentResponse> uploadIDDocument($pb.ServerContext ctx, $2.UploadIDDocumentRequest request);
  $async.Future<$2.GetIDDocumentsResponse> getIDDocuments($pb.ServerContext ctx, $2.GetIDDocumentsRequest request);
  $async.Future<$2.VerifyIDDocumentResponse> verifyIDDocument($pb.ServerContext ctx, $2.VerifyIDDocumentRequest request);
  $async.Future<$2.UserRegisterFaceResponse> registerFace($pb.ServerContext ctx, $2.UserRegisterFaceRequest request);
  $async.Future<$2.UserVerifyFaceResponse> verifyFace($pb.ServerContext ctx, $2.UserVerifyFaceRequest request);
  $async.Future<$2.GetFacialDataResponse> getFacialData($pb.ServerContext ctx, $2.GetFacialDataRequest request);
  $async.Future<$2.SetPasscodeResponse> setPasscode($pb.ServerContext ctx, $2.SetPasscodeRequest request);
  $async.Future<$2.VerifyPasscodeResponse> verifyPasscode($pb.ServerContext ctx, $2.VerifyPasscodeRequest request);
  $async.Future<$2.RemovePasscodeResponse> removePasscode($pb.ServerContext ctx, $2.RemovePasscodeRequest request);
  $async.Future<$2.CheckPasscodeExistsResponse> checkPasscodeExists($pb.ServerContext ctx, $2.CheckPasscodeExistsRequest request);
  $async.Future<$2.UpdateDevicePermissionsResponse> updateDevicePermissions($pb.ServerContext ctx, $2.UpdateDevicePermissionsRequest request);
  $async.Future<$2.GetDevicePermissionsResponse> getDevicePermissions($pb.ServerContext ctx, $2.GetDevicePermissionsRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'CreateUser': return $2.CreateUserRequest();
      case 'GetUserProfile': return $2.GetUserProfileRequest();
      case 'UpdateUserProfile': return $2.UpdateUserProfileRequest();
      case 'UpdatePassword': return $2.UpdatePasswordRequest();
      case 'UpdatePreferences': return $2.UpdatePreferencesRequest();
      case 'UploadIDDocument': return $2.UploadIDDocumentRequest();
      case 'GetIDDocuments': return $2.GetIDDocumentsRequest();
      case 'VerifyIDDocument': return $2.VerifyIDDocumentRequest();
      case 'RegisterFace': return $2.UserRegisterFaceRequest();
      case 'VerifyFace': return $2.UserVerifyFaceRequest();
      case 'GetFacialData': return $2.GetFacialDataRequest();
      case 'SetPasscode': return $2.SetPasscodeRequest();
      case 'VerifyPasscode': return $2.VerifyPasscodeRequest();
      case 'RemovePasscode': return $2.RemovePasscodeRequest();
      case 'CheckPasscodeExists': return $2.CheckPasscodeExistsRequest();
      case 'UpdateDevicePermissions': return $2.UpdateDevicePermissionsRequest();
      case 'GetDevicePermissions': return $2.GetDevicePermissionsRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'CreateUser': return this.createUser(ctx, request as $2.CreateUserRequest);
      case 'GetUserProfile': return this.getUserProfile(ctx, request as $2.GetUserProfileRequest);
      case 'UpdateUserProfile': return this.updateUserProfile(ctx, request as $2.UpdateUserProfileRequest);
      case 'UpdatePassword': return this.updatePassword(ctx, request as $2.UpdatePasswordRequest);
      case 'UpdatePreferences': return this.updatePreferences(ctx, request as $2.UpdatePreferencesRequest);
      case 'UploadIDDocument': return this.uploadIDDocument(ctx, request as $2.UploadIDDocumentRequest);
      case 'GetIDDocuments': return this.getIDDocuments(ctx, request as $2.GetIDDocumentsRequest);
      case 'VerifyIDDocument': return this.verifyIDDocument(ctx, request as $2.VerifyIDDocumentRequest);
      case 'RegisterFace': return this.registerFace(ctx, request as $2.UserRegisterFaceRequest);
      case 'VerifyFace': return this.verifyFace(ctx, request as $2.UserVerifyFaceRequest);
      case 'GetFacialData': return this.getFacialData(ctx, request as $2.GetFacialDataRequest);
      case 'SetPasscode': return this.setPasscode(ctx, request as $2.SetPasscodeRequest);
      case 'VerifyPasscode': return this.verifyPasscode(ctx, request as $2.VerifyPasscodeRequest);
      case 'RemovePasscode': return this.removePasscode(ctx, request as $2.RemovePasscodeRequest);
      case 'CheckPasscodeExists': return this.checkPasscodeExists(ctx, request as $2.CheckPasscodeExistsRequest);
      case 'UpdateDevicePermissions': return this.updateDevicePermissions(ctx, request as $2.UpdateDevicePermissionsRequest);
      case 'GetDevicePermissions': return this.getDevicePermissions(ctx, request as $2.GetDevicePermissionsRequest);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => UserServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => UserServiceBase$messageJson;
}

