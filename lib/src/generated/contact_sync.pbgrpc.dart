///
//  Generated code. Do not modify.
//  source: contact_sync.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'contact_sync.pb.dart' as $8;
export 'contact_sync.pb.dart';

class ContactSyncServiceClient extends $grpc.Client {
  static final _$syncContacts =
      $grpc.ClientMethod<$8.SyncContactsRequest, $8.SyncContactsResponse>(
          '/lazervault.contact.ContactSyncService/SyncContacts',
          ($8.SyncContactsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $8.SyncContactsResponse.fromBuffer(value));
  static final _$getSyncedContacts = $grpc.ClientMethod<
          $8.GetSyncedContactsRequest, $8.GetSyncedContactsResponse>(
      '/lazervault.contact.ContactSyncService/GetSyncedContacts',
      ($8.GetSyncedContactsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $8.GetSyncedContactsResponse.fromBuffer(value));
  static final _$deleteSyncedContacts = $grpc.ClientMethod<
          $8.DeleteSyncedContactsRequest, $8.DeleteSyncedContactsResponse>(
      '/lazervault.contact.ContactSyncService/DeleteSyncedContacts',
      ($8.DeleteSyncedContactsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $8.DeleteSyncedContactsResponse.fromBuffer(value));
  static final _$convertContactToRecipient = $grpc.ClientMethod<
          $8.ConvertContactToRecipientRequest,
          $8.ConvertContactToRecipientResponse>(
      '/lazervault.contact.ContactSyncService/ConvertContactToRecipient',
      ($8.ConvertContactToRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $8.ConvertContactToRecipientResponse.fromBuffer(value));
  static final _$findLazerVaultUsers = $grpc.ClientMethod<
          $8.FindLazerVaultUsersRequest, $8.FindLazerVaultUsersResponse>(
      '/lazervault.contact.ContactSyncService/FindLazerVaultUsers',
      ($8.FindLazerVaultUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $8.FindLazerVaultUsersResponse.fromBuffer(value));
  static final _$updateSyncPreferences = $grpc.ClientMethod<
          $8.UpdateSyncPreferencesRequest, $8.UpdateSyncPreferencesResponse>(
      '/lazervault.contact.ContactSyncService/UpdateSyncPreferences',
      ($8.UpdateSyncPreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $8.UpdateSyncPreferencesResponse.fromBuffer(value));

  ContactSyncServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$8.SyncContactsResponse> syncContacts(
      $8.SyncContactsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$syncContacts, request, options: options);
  }

  $grpc.ResponseFuture<$8.GetSyncedContactsResponse> getSyncedContacts(
      $8.GetSyncedContactsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSyncedContacts, request, options: options);
  }

  $grpc.ResponseFuture<$8.DeleteSyncedContactsResponse> deleteSyncedContacts(
      $8.DeleteSyncedContactsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteSyncedContacts, request, options: options);
  }

  $grpc.ResponseFuture<$8.ConvertContactToRecipientResponse>
      convertContactToRecipient($8.ConvertContactToRecipientRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertContactToRecipient, request,
        options: options);
  }

  $grpc.ResponseFuture<$8.FindLazerVaultUsersResponse> findLazerVaultUsers(
      $8.FindLazerVaultUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findLazerVaultUsers, request, options: options);
  }

  $grpc.ResponseFuture<$8.UpdateSyncPreferencesResponse> updateSyncPreferences(
      $8.UpdateSyncPreferencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSyncPreferences, request, options: options);
  }
}

abstract class ContactSyncServiceBase extends $grpc.Service {
  $core.String get $name => 'lazervault.contact.ContactSyncService';

  ContactSyncServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$8.SyncContactsRequest, $8.SyncContactsResponse>(
            'SyncContacts',
            syncContacts_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $8.SyncContactsRequest.fromBuffer(value),
            ($8.SyncContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.GetSyncedContactsRequest,
            $8.GetSyncedContactsResponse>(
        'GetSyncedContacts',
        getSyncedContacts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $8.GetSyncedContactsRequest.fromBuffer(value),
        ($8.GetSyncedContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.DeleteSyncedContactsRequest,
            $8.DeleteSyncedContactsResponse>(
        'DeleteSyncedContacts',
        deleteSyncedContacts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $8.DeleteSyncedContactsRequest.fromBuffer(value),
        ($8.DeleteSyncedContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.ConvertContactToRecipientRequest,
            $8.ConvertContactToRecipientResponse>(
        'ConvertContactToRecipient',
        convertContactToRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $8.ConvertContactToRecipientRequest.fromBuffer(value),
        ($8.ConvertContactToRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.FindLazerVaultUsersRequest,
            $8.FindLazerVaultUsersResponse>(
        'FindLazerVaultUsers',
        findLazerVaultUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $8.FindLazerVaultUsersRequest.fromBuffer(value),
        ($8.FindLazerVaultUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.UpdateSyncPreferencesRequest,
            $8.UpdateSyncPreferencesResponse>(
        'UpdateSyncPreferences',
        updateSyncPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $8.UpdateSyncPreferencesRequest.fromBuffer(value),
        ($8.UpdateSyncPreferencesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$8.SyncContactsResponse> syncContacts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$8.SyncContactsRequest> request) async {
    return syncContacts(call, await request);
  }

  $async.Future<$8.GetSyncedContactsResponse> getSyncedContacts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$8.GetSyncedContactsRequest> request) async {
    return getSyncedContacts(call, await request);
  }

  $async.Future<$8.DeleteSyncedContactsResponse> deleteSyncedContacts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$8.DeleteSyncedContactsRequest> request) async {
    return deleteSyncedContacts(call, await request);
  }

  $async.Future<$8.ConvertContactToRecipientResponse>
      convertContactToRecipient_Pre($grpc.ServiceCall call,
          $async.Future<$8.ConvertContactToRecipientRequest> request) async {
    return convertContactToRecipient(call, await request);
  }

  $async.Future<$8.FindLazerVaultUsersResponse> findLazerVaultUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$8.FindLazerVaultUsersRequest> request) async {
    return findLazerVaultUsers(call, await request);
  }

  $async.Future<$8.UpdateSyncPreferencesResponse> updateSyncPreferences_Pre(
      $grpc.ServiceCall call,
      $async.Future<$8.UpdateSyncPreferencesRequest> request) async {
    return updateSyncPreferences(call, await request);
  }

  $async.Future<$8.SyncContactsResponse> syncContacts(
      $grpc.ServiceCall call, $8.SyncContactsRequest request);
  $async.Future<$8.GetSyncedContactsResponse> getSyncedContacts(
      $grpc.ServiceCall call, $8.GetSyncedContactsRequest request);
  $async.Future<$8.DeleteSyncedContactsResponse> deleteSyncedContacts(
      $grpc.ServiceCall call, $8.DeleteSyncedContactsRequest request);
  $async.Future<$8.ConvertContactToRecipientResponse> convertContactToRecipient(
      $grpc.ServiceCall call, $8.ConvertContactToRecipientRequest request);
  $async.Future<$8.FindLazerVaultUsersResponse> findLazerVaultUsers(
      $grpc.ServiceCall call, $8.FindLazerVaultUsersRequest request);
  $async.Future<$8.UpdateSyncPreferencesResponse> updateSyncPreferences(
      $grpc.ServiceCall call, $8.UpdateSyncPreferencesRequest request);
}
