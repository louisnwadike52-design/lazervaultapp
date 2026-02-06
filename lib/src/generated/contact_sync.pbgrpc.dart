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

import 'contact_sync.pb.dart' as $10;

export 'contact_sync.pb.dart';

@$pb.GrpcServiceName('lazervault.contact.ContactSyncService')
class ContactSyncServiceClient extends $grpc.Client {
  static final _$syncContacts = $grpc.ClientMethod<$10.SyncContactsRequest, $10.SyncContactsResponse>(
      '/lazervault.contact.ContactSyncService/SyncContacts',
      ($10.SyncContactsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $10.SyncContactsResponse.fromBuffer(value));
  static final _$getSyncedContacts = $grpc.ClientMethod<$10.GetSyncedContactsRequest, $10.GetSyncedContactsResponse>(
      '/lazervault.contact.ContactSyncService/GetSyncedContacts',
      ($10.GetSyncedContactsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $10.GetSyncedContactsResponse.fromBuffer(value));
  static final _$deleteSyncedContacts = $grpc.ClientMethod<$10.DeleteSyncedContactsRequest, $10.DeleteSyncedContactsResponse>(
      '/lazervault.contact.ContactSyncService/DeleteSyncedContacts',
      ($10.DeleteSyncedContactsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $10.DeleteSyncedContactsResponse.fromBuffer(value));
  static final _$convertContactToRecipient = $grpc.ClientMethod<$10.ConvertContactToRecipientRequest, $10.ConvertContactToRecipientResponse>(
      '/lazervault.contact.ContactSyncService/ConvertContactToRecipient',
      ($10.ConvertContactToRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $10.ConvertContactToRecipientResponse.fromBuffer(value));
  static final _$findLazerVaultUsers = $grpc.ClientMethod<$10.FindLazerVaultUsersRequest, $10.FindLazerVaultUsersResponse>(
      '/lazervault.contact.ContactSyncService/FindLazerVaultUsers',
      ($10.FindLazerVaultUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $10.FindLazerVaultUsersResponse.fromBuffer(value));
  static final _$updateSyncPreferences = $grpc.ClientMethod<$10.UpdateSyncPreferencesRequest, $10.UpdateSyncPreferencesResponse>(
      '/lazervault.contact.ContactSyncService/UpdateSyncPreferences',
      ($10.UpdateSyncPreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $10.UpdateSyncPreferencesResponse.fromBuffer(value));

  ContactSyncServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$10.SyncContactsResponse> syncContacts($10.SyncContactsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$syncContacts, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetSyncedContactsResponse> getSyncedContacts($10.GetSyncedContactsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSyncedContacts, request, options: options);
  }

  $grpc.ResponseFuture<$10.DeleteSyncedContactsResponse> deleteSyncedContacts($10.DeleteSyncedContactsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteSyncedContacts, request, options: options);
  }

  $grpc.ResponseFuture<$10.ConvertContactToRecipientResponse> convertContactToRecipient($10.ConvertContactToRecipientRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertContactToRecipient, request, options: options);
  }

  $grpc.ResponseFuture<$10.FindLazerVaultUsersResponse> findLazerVaultUsers($10.FindLazerVaultUsersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findLazerVaultUsers, request, options: options);
  }

  $grpc.ResponseFuture<$10.UpdateSyncPreferencesResponse> updateSyncPreferences($10.UpdateSyncPreferencesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSyncPreferences, request, options: options);
  }
}

@$pb.GrpcServiceName('lazervault.contact.ContactSyncService')
abstract class ContactSyncServiceBase extends $grpc.Service {
  $core.String get $name => 'lazervault.contact.ContactSyncService';

  ContactSyncServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.SyncContactsRequest, $10.SyncContactsResponse>(
        'SyncContacts',
        syncContacts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $10.SyncContactsRequest.fromBuffer(value),
        ($10.SyncContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetSyncedContactsRequest, $10.GetSyncedContactsResponse>(
        'GetSyncedContacts',
        getSyncedContacts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $10.GetSyncedContactsRequest.fromBuffer(value),
        ($10.GetSyncedContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.DeleteSyncedContactsRequest, $10.DeleteSyncedContactsResponse>(
        'DeleteSyncedContacts',
        deleteSyncedContacts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $10.DeleteSyncedContactsRequest.fromBuffer(value),
        ($10.DeleteSyncedContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.ConvertContactToRecipientRequest, $10.ConvertContactToRecipientResponse>(
        'ConvertContactToRecipient',
        convertContactToRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $10.ConvertContactToRecipientRequest.fromBuffer(value),
        ($10.ConvertContactToRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.FindLazerVaultUsersRequest, $10.FindLazerVaultUsersResponse>(
        'FindLazerVaultUsers',
        findLazerVaultUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $10.FindLazerVaultUsersRequest.fromBuffer(value),
        ($10.FindLazerVaultUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.UpdateSyncPreferencesRequest, $10.UpdateSyncPreferencesResponse>(
        'UpdateSyncPreferences',
        updateSyncPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $10.UpdateSyncPreferencesRequest.fromBuffer(value),
        ($10.UpdateSyncPreferencesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$10.SyncContactsResponse> syncContacts_Pre($grpc.ServiceCall call, $async.Future<$10.SyncContactsRequest> request) async {
    return syncContacts(call, await request);
  }

  $async.Future<$10.GetSyncedContactsResponse> getSyncedContacts_Pre($grpc.ServiceCall call, $async.Future<$10.GetSyncedContactsRequest> request) async {
    return getSyncedContacts(call, await request);
  }

  $async.Future<$10.DeleteSyncedContactsResponse> deleteSyncedContacts_Pre($grpc.ServiceCall call, $async.Future<$10.DeleteSyncedContactsRequest> request) async {
    return deleteSyncedContacts(call, await request);
  }

  $async.Future<$10.ConvertContactToRecipientResponse> convertContactToRecipient_Pre($grpc.ServiceCall call, $async.Future<$10.ConvertContactToRecipientRequest> request) async {
    return convertContactToRecipient(call, await request);
  }

  $async.Future<$10.FindLazerVaultUsersResponse> findLazerVaultUsers_Pre($grpc.ServiceCall call, $async.Future<$10.FindLazerVaultUsersRequest> request) async {
    return findLazerVaultUsers(call, await request);
  }

  $async.Future<$10.UpdateSyncPreferencesResponse> updateSyncPreferences_Pre($grpc.ServiceCall call, $async.Future<$10.UpdateSyncPreferencesRequest> request) async {
    return updateSyncPreferences(call, await request);
  }

  $async.Future<$10.SyncContactsResponse> syncContacts($grpc.ServiceCall call, $10.SyncContactsRequest request);
  $async.Future<$10.GetSyncedContactsResponse> getSyncedContacts($grpc.ServiceCall call, $10.GetSyncedContactsRequest request);
  $async.Future<$10.DeleteSyncedContactsResponse> deleteSyncedContacts($grpc.ServiceCall call, $10.DeleteSyncedContactsRequest request);
  $async.Future<$10.ConvertContactToRecipientResponse> convertContactToRecipient($grpc.ServiceCall call, $10.ConvertContactToRecipientRequest request);
  $async.Future<$10.FindLazerVaultUsersResponse> findLazerVaultUsers($grpc.ServiceCall call, $10.FindLazerVaultUsersRequest request);
  $async.Future<$10.UpdateSyncPreferencesResponse> updateSyncPreferences($grpc.ServiceCall call, $10.UpdateSyncPreferencesRequest request);
}
