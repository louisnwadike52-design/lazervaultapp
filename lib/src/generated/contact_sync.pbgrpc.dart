///
//  Generated code. Do not modify.
//  source: contact_sync.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'contact_sync.pb.dart' as $9;
export 'contact_sync.pb.dart';

class ContactSyncServiceClient extends $grpc.Client {
  static final _$syncContacts =
      $grpc.ClientMethod<$9.SyncContactsRequest, $9.SyncContactsResponse>(
          '/lazervault.contact.ContactSyncService/SyncContacts',
          ($9.SyncContactsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $9.SyncContactsResponse.fromBuffer(value));
  static final _$getSyncedContacts = $grpc.ClientMethod<
          $9.GetSyncedContactsRequest, $9.GetSyncedContactsResponse>(
      '/lazervault.contact.ContactSyncService/GetSyncedContacts',
      ($9.GetSyncedContactsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $9.GetSyncedContactsResponse.fromBuffer(value));
  static final _$deleteSyncedContacts = $grpc.ClientMethod<
          $9.DeleteSyncedContactsRequest, $9.DeleteSyncedContactsResponse>(
      '/lazervault.contact.ContactSyncService/DeleteSyncedContacts',
      ($9.DeleteSyncedContactsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $9.DeleteSyncedContactsResponse.fromBuffer(value));
  static final _$convertContactToRecipient = $grpc.ClientMethod<
          $9.ConvertContactToRecipientRequest,
          $9.ConvertContactToRecipientResponse>(
      '/lazervault.contact.ContactSyncService/ConvertContactToRecipient',
      ($9.ConvertContactToRecipientRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $9.ConvertContactToRecipientResponse.fromBuffer(value));
  static final _$findLazerVaultUsers = $grpc.ClientMethod<
          $9.FindLazerVaultUsersRequest, $9.FindLazerVaultUsersResponse>(
      '/lazervault.contact.ContactSyncService/FindLazerVaultUsers',
      ($9.FindLazerVaultUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $9.FindLazerVaultUsersResponse.fromBuffer(value));
  static final _$updateSyncPreferences = $grpc.ClientMethod<
          $9.UpdateSyncPreferencesRequest, $9.UpdateSyncPreferencesResponse>(
      '/lazervault.contact.ContactSyncService/UpdateSyncPreferences',
      ($9.UpdateSyncPreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $9.UpdateSyncPreferencesResponse.fromBuffer(value));

  ContactSyncServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$9.SyncContactsResponse> syncContacts(
      $9.SyncContactsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$syncContacts, request, options: options);
  }

  $grpc.ResponseFuture<$9.GetSyncedContactsResponse> getSyncedContacts(
      $9.GetSyncedContactsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSyncedContacts, request, options: options);
  }

  $grpc.ResponseFuture<$9.DeleteSyncedContactsResponse> deleteSyncedContacts(
      $9.DeleteSyncedContactsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteSyncedContacts, request, options: options);
  }

  $grpc.ResponseFuture<$9.ConvertContactToRecipientResponse>
      convertContactToRecipient($9.ConvertContactToRecipientRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertContactToRecipient, request,
        options: options);
  }

  $grpc.ResponseFuture<$9.FindLazerVaultUsersResponse> findLazerVaultUsers(
      $9.FindLazerVaultUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findLazerVaultUsers, request, options: options);
  }

  $grpc.ResponseFuture<$9.UpdateSyncPreferencesResponse> updateSyncPreferences(
      $9.UpdateSyncPreferencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSyncPreferences, request, options: options);
  }
}

abstract class ContactSyncServiceBase extends $grpc.Service {
  $core.String get $name => 'lazervault.contact.ContactSyncService';

  ContactSyncServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$9.SyncContactsRequest, $9.SyncContactsResponse>(
            'SyncContacts',
            syncContacts_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $9.SyncContactsRequest.fromBuffer(value),
            ($9.SyncContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.GetSyncedContactsRequest,
            $9.GetSyncedContactsResponse>(
        'GetSyncedContacts',
        getSyncedContacts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.GetSyncedContactsRequest.fromBuffer(value),
        ($9.GetSyncedContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.DeleteSyncedContactsRequest,
            $9.DeleteSyncedContactsResponse>(
        'DeleteSyncedContacts',
        deleteSyncedContacts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.DeleteSyncedContactsRequest.fromBuffer(value),
        ($9.DeleteSyncedContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.ConvertContactToRecipientRequest,
            $9.ConvertContactToRecipientResponse>(
        'ConvertContactToRecipient',
        convertContactToRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.ConvertContactToRecipientRequest.fromBuffer(value),
        ($9.ConvertContactToRecipientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.FindLazerVaultUsersRequest,
            $9.FindLazerVaultUsersResponse>(
        'FindLazerVaultUsers',
        findLazerVaultUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.FindLazerVaultUsersRequest.fromBuffer(value),
        ($9.FindLazerVaultUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.UpdateSyncPreferencesRequest,
            $9.UpdateSyncPreferencesResponse>(
        'UpdateSyncPreferences',
        updateSyncPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.UpdateSyncPreferencesRequest.fromBuffer(value),
        ($9.UpdateSyncPreferencesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$9.SyncContactsResponse> syncContacts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.SyncContactsRequest> request) async {
    return syncContacts(call, await request);
  }

  $async.Future<$9.GetSyncedContactsResponse> getSyncedContacts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.GetSyncedContactsRequest> request) async {
    return getSyncedContacts(call, await request);
  }

  $async.Future<$9.DeleteSyncedContactsResponse> deleteSyncedContacts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.DeleteSyncedContactsRequest> request) async {
    return deleteSyncedContacts(call, await request);
  }

  $async.Future<$9.ConvertContactToRecipientResponse>
      convertContactToRecipient_Pre($grpc.ServiceCall call,
          $async.Future<$9.ConvertContactToRecipientRequest> request) async {
    return convertContactToRecipient(call, await request);
  }

  $async.Future<$9.FindLazerVaultUsersResponse> findLazerVaultUsers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.FindLazerVaultUsersRequest> request) async {
    return findLazerVaultUsers(call, await request);
  }

  $async.Future<$9.UpdateSyncPreferencesResponse> updateSyncPreferences_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.UpdateSyncPreferencesRequest> request) async {
    return updateSyncPreferences(call, await request);
  }

  $async.Future<$9.SyncContactsResponse> syncContacts(
      $grpc.ServiceCall call, $9.SyncContactsRequest request);
  $async.Future<$9.GetSyncedContactsResponse> getSyncedContacts(
      $grpc.ServiceCall call, $9.GetSyncedContactsRequest request);
  $async.Future<$9.DeleteSyncedContactsResponse> deleteSyncedContacts(
      $grpc.ServiceCall call, $9.DeleteSyncedContactsRequest request);
  $async.Future<$9.ConvertContactToRecipientResponse> convertContactToRecipient(
      $grpc.ServiceCall call, $9.ConvertContactToRecipientRequest request);
  $async.Future<$9.FindLazerVaultUsersResponse> findLazerVaultUsers(
      $grpc.ServiceCall call, $9.FindLazerVaultUsersRequest request);
  $async.Future<$9.UpdateSyncPreferencesResponse> updateSyncPreferences(
      $grpc.ServiceCall call, $9.UpdateSyncPreferencesRequest request);
}
