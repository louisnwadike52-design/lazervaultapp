//
//  Generated code. Do not modify.
//  source: contact_sync.proto
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

import 'contact_sync.pb.dart' as $0;

export 'contact_sync.pb.dart';

@$pb.GrpcServiceName('lazervault.contact.ContactSyncService')
class ContactSyncServiceClient extends $grpc.Client {
  static final _$syncContacts = $grpc.ClientMethod<$0.SyncContactsRequest, $0.SyncContactsResponse>(
      '/lazervault.contact.ContactSyncService/SyncContacts',
      ($0.SyncContactsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SyncContactsResponse.fromBuffer(value));
  static final _$getSyncedContacts = $grpc.ClientMethod<$0.GetSyncedContactsRequest, $0.GetSyncedContactsResponse>(
      '/lazervault.contact.ContactSyncService/GetSyncedContacts',
      ($0.GetSyncedContactsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSyncedContactsResponse.fromBuffer(value));
  static final _$deleteSyncedContacts = $grpc.ClientMethod<$0.DeleteSyncedContactsRequest, $0.DeleteSyncedContactsResponse>(
      '/lazervault.contact.ContactSyncService/DeleteSyncedContacts',
      ($0.DeleteSyncedContactsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteSyncedContactsResponse.fromBuffer(value));
  static final _$convertContactToRecipient = $grpc.ClientMethod<$0.ConvertContactToRecipientRequest, $0.ConvertContactToRecipientResponse>(
      '/lazervault.contact.ContactSyncService/ConvertContactToRecipient',
      ($0.ConvertContactToRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ConvertContactToRecipientResponse.fromBuffer(value));
  static final _$findLazerVaultUsers = $grpc.ClientMethod<$0.FindLazerVaultUsersRequest, $0.FindLazerVaultUsersResponse>(
      '/lazervault.contact.ContactSyncService/FindLazerVaultUsers',
      ($0.FindLazerVaultUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.FindLazerVaultUsersResponse.fromBuffer(value));
  static final _$updateSyncPreferences = $grpc.ClientMethod<$0.UpdateSyncPreferencesRequest, $0.UpdateSyncPreferencesResponse>(
      '/lazervault.contact.ContactSyncService/UpdateSyncPreferences',
      ($0.UpdateSyncPreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateSyncPreferencesResponse.fromBuffer(value));

  ContactSyncServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.SyncContactsResponse> syncContacts($0.SyncContactsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$syncContacts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSyncedContactsResponse> getSyncedContacts($0.GetSyncedContactsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSyncedContacts, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteSyncedContactsResponse> deleteSyncedContacts($0.DeleteSyncedContactsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteSyncedContacts, request, options: options);
  }

  $grpc.ResponseFuture<$0.ConvertContactToRecipientResponse> convertContactToRecipient($0.ConvertContactToRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertContactToRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$0.FindLazerVaultUsersResponse> findLazerVaultUsers($0.FindLazerVaultUsersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findLazerVaultUsers, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateSyncPreferencesResponse> updateSyncPreferences($0.UpdateSyncPreferencesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSyncPreferences, request, options: options);
  }
}

@$pb.GrpcServiceName('lazervault.contact.ContactSyncService')
abstract class ContactSyncServiceBase extends $grpc.Service {
  $core.String get $name => 'lazervault.contact.ContactSyncService';

  ContactSyncServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SyncContactsRequest, $0.SyncContactsResponse>(
        'SyncContacts',
        syncContacts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SyncContactsRequest.fromBuffer(value),
        ($0.SyncContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSyncedContactsRequest, $0.GetSyncedContactsResponse>(
        'GetSyncedContacts',
        getSyncedContacts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSyncedContactsRequest.fromBuffer(value),
        ($0.GetSyncedContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteSyncedContactsRequest, $0.DeleteSyncedContactsResponse>(
        'DeleteSyncedContacts',
        deleteSyncedContacts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteSyncedContactsRequest.fromBuffer(value),
        ($0.DeleteSyncedContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConvertContactToRecipientRequest, $0.ConvertContactToRecipientResponse>(
        'ConvertContactToRecipient',
        convertContactToRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ConvertContactToRecipientRequest.fromBuffer(value),
        ($0.ConvertContactToRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FindLazerVaultUsersRequest, $0.FindLazerVaultUsersResponse>(
        'FindLazerVaultUsers',
        findLazerVaultUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FindLazerVaultUsersRequest.fromBuffer(value),
        ($0.FindLazerVaultUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSyncPreferencesRequest, $0.UpdateSyncPreferencesResponse>(
        'UpdateSyncPreferences',
        updateSyncPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateSyncPreferencesRequest.fromBuffer(value),
        ($0.UpdateSyncPreferencesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SyncContactsResponse> syncContacts_Pre($grpc.ServiceCall call, $async.Future<$0.SyncContactsRequest> request) async {
    return syncContacts(call, await request);
  }

  $async.Future<$0.GetSyncedContactsResponse> getSyncedContacts_Pre($grpc.ServiceCall call, $async.Future<$0.GetSyncedContactsRequest> request) async {
    return getSyncedContacts(call, await request);
  }

  $async.Future<$0.DeleteSyncedContactsResponse> deleteSyncedContacts_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteSyncedContactsRequest> request) async {
    return deleteSyncedContacts(call, await request);
  }

  $async.Future<$0.ConvertContactToRecipientResponse> convertContactToRecipient_Pre($grpc.ServiceCall call, $async.Future<$0.ConvertContactToRecipientRequest> request) async {
    return convertContactToRecipient(call, await request);
  }

  $async.Future<$0.FindLazerVaultUsersResponse> findLazerVaultUsers_Pre($grpc.ServiceCall call, $async.Future<$0.FindLazerVaultUsersRequest> request) async {
    return findLazerVaultUsers(call, await request);
  }

  $async.Future<$0.UpdateSyncPreferencesResponse> updateSyncPreferences_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateSyncPreferencesRequest> request) async {
    return updateSyncPreferences(call, await request);
  }

  $async.Future<$0.SyncContactsResponse> syncContacts($grpc.ServiceCall call, $0.SyncContactsRequest request);
  $async.Future<$0.GetSyncedContactsResponse> getSyncedContacts($grpc.ServiceCall call, $0.GetSyncedContactsRequest request);
  $async.Future<$0.DeleteSyncedContactsResponse> deleteSyncedContacts($grpc.ServiceCall call, $0.DeleteSyncedContactsRequest request);
  $async.Future<$0.ConvertContactToRecipientResponse> convertContactToRecipient($grpc.ServiceCall call, $0.ConvertContactToRecipientRequest request);
  $async.Future<$0.FindLazerVaultUsersResponse> findLazerVaultUsers($grpc.ServiceCall call, $0.FindLazerVaultUsersRequest request);
  $async.Future<$0.UpdateSyncPreferencesResponse> updateSyncPreferences($grpc.ServiceCall call, $0.UpdateSyncPreferencesRequest request);
}
