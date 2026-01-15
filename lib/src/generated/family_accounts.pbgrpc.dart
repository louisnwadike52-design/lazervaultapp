///
//  Generated code. Do not modify.
//  source: family_accounts.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'family_accounts.pb.dart' as $1;
export 'family_accounts.pb.dart';

class FamilyAccountsServiceClient extends $grpc.Client {
  static final _$createFamilyAccount = $grpc.ClientMethod<
          $1.CreateFamilyAccountRequest, $1.CreateFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/CreateFamilyAccount',
      ($1.CreateFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateFamilyAccountResponse.fromBuffer(value));
  static final _$getFamilyAccounts = $grpc.ClientMethod<
          $1.GetFamilyAccountsRequest, $1.GetFamilyAccountsResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyAccounts',
      ($1.GetFamilyAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetFamilyAccountsResponse.fromBuffer(value));
  static final _$getFamilyAccount = $grpc.ClientMethod<
          $1.GetFamilyAccountRequest, $1.GetFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyAccount',
      ($1.GetFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetFamilyAccountResponse.fromBuffer(value));
  static final _$addFamilyMember =
      $grpc.ClientMethod<$1.AddFamilyMemberRequest, $1.AddFamilyMemberResponse>(
          '/accounts.v1.FamilyAccountsService/AddFamilyMember',
          ($1.AddFamilyMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.AddFamilyMemberResponse.fromBuffer(value));
  static final _$updateFamilyMember = $grpc.ClientMethod<
          $1.UpdateFamilyMemberRequest, $1.UpdateFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/UpdateFamilyMember',
      ($1.UpdateFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateFamilyMemberResponse.fromBuffer(value));
  static final _$removeFamilyMember = $grpc.ClientMethod<
          $1.RemoveFamilyMemberRequest, $1.RemoveFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/RemoveFamilyMember',
      ($1.RemoveFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.RemoveFamilyMemberResponse.fromBuffer(value));
  static final _$acceptFamilyInvitation = $grpc.ClientMethod<
          $1.AcceptFamilyInvitationRequest, $1.AcceptFamilyInvitationResponse>(
      '/accounts.v1.FamilyAccountsService/AcceptFamilyInvitation',
      ($1.AcceptFamilyInvitationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AcceptFamilyInvitationResponse.fromBuffer(value));
  static final _$declineFamilyInvitation = $grpc.ClientMethod<
          $1.DeclineFamilyInvitationRequest,
          $1.DeclineFamilyInvitationResponse>(
      '/accounts.v1.FamilyAccountsService/DeclineFamilyInvitation',
      ($1.DeclineFamilyInvitationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeclineFamilyInvitationResponse.fromBuffer(value));
  static final _$getPendingInvitations = $grpc.ClientMethod<
          $1.GetPendingInvitationsRequest, $1.GetPendingInvitationsResponse>(
      '/accounts.v1.FamilyAccountsService/GetPendingInvitations',
      ($1.GetPendingInvitationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetPendingInvitationsResponse.fromBuffer(value));
  static final _$getFamilyTransactions = $grpc.ClientMethod<
          $1.GetFamilyTransactionsRequest, $1.GetFamilyTransactionsResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyTransactions',
      ($1.GetFamilyTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetFamilyTransactionsResponse.fromBuffer(value));
  static final _$allocateFunds =
      $grpc.ClientMethod<$1.AllocateFundsRequest, $1.AllocateFundsResponse>(
          '/accounts.v1.FamilyAccountsService/AllocateFunds',
          ($1.AllocateFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.AllocateFundsResponse.fromBuffer(value));
  static final _$generateMemberCard = $grpc.ClientMethod<
          $1.GenerateMemberCardRequest, $1.GenerateMemberCardResponse>(
      '/accounts.v1.FamilyAccountsService/GenerateMemberCard',
      ($1.GenerateMemberCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GenerateMemberCardResponse.fromBuffer(value));
  static final _$freezeFamilyAccount = $grpc.ClientMethod<
          $1.FreezeFamilyAccountRequest, $1.FreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/FreezeFamilyAccount',
      ($1.FreezeFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.FreezeFamilyAccountResponse.fromBuffer(value));
  static final _$unfreezeFamilyAccount = $grpc.ClientMethod<
          $1.UnfreezeFamilyAccountRequest, $1.UnfreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/UnfreezeFamilyAccount',
      ($1.UnfreezeFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UnfreezeFamilyAccountResponse.fromBuffer(value));
  static final _$deleteFamilyAccount = $grpc.ClientMethod<
          $1.DeleteFamilyAccountRequest, $1.DeleteFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/DeleteFamilyAccount',
      ($1.DeleteFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteFamilyAccountResponse.fromBuffer(value));

  FamilyAccountsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.CreateFamilyAccountResponse> createFamilyAccount(
      $1.CreateFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetFamilyAccountsResponse> getFamilyAccounts(
      $1.GetFamilyAccountsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetFamilyAccountResponse> getFamilyAccount(
      $1.GetFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.AddFamilyMemberResponse> addFamilyMember(
      $1.AddFamilyMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateFamilyMemberResponse> updateFamilyMember(
      $1.UpdateFamilyMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$1.RemoveFamilyMemberResponse> removeFamilyMember(
      $1.RemoveFamilyMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$1.AcceptFamilyInvitationResponse>
      acceptFamilyInvitation($1.AcceptFamilyInvitationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptFamilyInvitation, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeclineFamilyInvitationResponse>
      declineFamilyInvitation($1.DeclineFamilyInvitationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineFamilyInvitation, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetPendingInvitationsResponse> getPendingInvitations(
      $1.GetPendingInvitationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingInvitations, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetFamilyTransactionsResponse> getFamilyTransactions(
      $1.GetFamilyTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$1.AllocateFundsResponse> allocateFunds(
      $1.AllocateFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$allocateFunds, request, options: options);
  }

  $grpc.ResponseFuture<$1.GenerateMemberCardResponse> generateMemberCard(
      $1.GenerateMemberCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateMemberCard, request, options: options);
  }

  $grpc.ResponseFuture<$1.FreezeFamilyAccountResponse> freezeFamilyAccount(
      $1.FreezeFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$freezeFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount(
      $1.UnfreezeFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unfreezeFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteFamilyAccountResponse> deleteFamilyAccount(
      $1.DeleteFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteFamilyAccount, request, options: options);
  }
}

abstract class FamilyAccountsServiceBase extends $grpc.Service {
  $core.String get $name => 'accounts.v1.FamilyAccountsService';

  FamilyAccountsServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.CreateFamilyAccountRequest,
            $1.CreateFamilyAccountResponse>(
        'CreateFamilyAccount',
        createFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateFamilyAccountRequest.fromBuffer(value),
        ($1.CreateFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetFamilyAccountsRequest,
            $1.GetFamilyAccountsResponse>(
        'GetFamilyAccounts',
        getFamilyAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetFamilyAccountsRequest.fromBuffer(value),
        ($1.GetFamilyAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetFamilyAccountRequest,
            $1.GetFamilyAccountResponse>(
        'GetFamilyAccount',
        getFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetFamilyAccountRequest.fromBuffer(value),
        ($1.GetFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddFamilyMemberRequest,
            $1.AddFamilyMemberResponse>(
        'AddFamilyMember',
        addFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AddFamilyMemberRequest.fromBuffer(value),
        ($1.AddFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateFamilyMemberRequest,
            $1.UpdateFamilyMemberResponse>(
        'UpdateFamilyMember',
        updateFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateFamilyMemberRequest.fromBuffer(value),
        ($1.UpdateFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RemoveFamilyMemberRequest,
            $1.RemoveFamilyMemberResponse>(
        'RemoveFamilyMember',
        removeFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RemoveFamilyMemberRequest.fromBuffer(value),
        ($1.RemoveFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AcceptFamilyInvitationRequest,
            $1.AcceptFamilyInvitationResponse>(
        'AcceptFamilyInvitation',
        acceptFamilyInvitation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AcceptFamilyInvitationRequest.fromBuffer(value),
        ($1.AcceptFamilyInvitationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeclineFamilyInvitationRequest,
            $1.DeclineFamilyInvitationResponse>(
        'DeclineFamilyInvitation',
        declineFamilyInvitation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeclineFamilyInvitationRequest.fromBuffer(value),
        ($1.DeclineFamilyInvitationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetPendingInvitationsRequest,
            $1.GetPendingInvitationsResponse>(
        'GetPendingInvitations',
        getPendingInvitations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetPendingInvitationsRequest.fromBuffer(value),
        ($1.GetPendingInvitationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetFamilyTransactionsRequest,
            $1.GetFamilyTransactionsResponse>(
        'GetFamilyTransactions',
        getFamilyTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetFamilyTransactionsRequest.fromBuffer(value),
        ($1.GetFamilyTransactionsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.AllocateFundsRequest, $1.AllocateFundsResponse>(
            'AllocateFunds',
            allocateFunds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.AllocateFundsRequest.fromBuffer(value),
            ($1.AllocateFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GenerateMemberCardRequest,
            $1.GenerateMemberCardResponse>(
        'GenerateMemberCard',
        generateMemberCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GenerateMemberCardRequest.fromBuffer(value),
        ($1.GenerateMemberCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.FreezeFamilyAccountRequest,
            $1.FreezeFamilyAccountResponse>(
        'FreezeFamilyAccount',
        freezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.FreezeFamilyAccountRequest.fromBuffer(value),
        ($1.FreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UnfreezeFamilyAccountRequest,
            $1.UnfreezeFamilyAccountResponse>(
        'UnfreezeFamilyAccount',
        unfreezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UnfreezeFamilyAccountRequest.fromBuffer(value),
        ($1.UnfreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteFamilyAccountRequest,
            $1.DeleteFamilyAccountResponse>(
        'DeleteFamilyAccount',
        deleteFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteFamilyAccountRequest.fromBuffer(value),
        ($1.DeleteFamilyAccountResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.CreateFamilyAccountResponse> createFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateFamilyAccountRequest> request) async {
    return createFamilyAccount(call, await request);
  }

  $async.Future<$1.GetFamilyAccountsResponse> getFamilyAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetFamilyAccountsRequest> request) async {
    return getFamilyAccounts(call, await request);
  }

  $async.Future<$1.GetFamilyAccountResponse> getFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetFamilyAccountRequest> request) async {
    return getFamilyAccount(call, await request);
  }

  $async.Future<$1.AddFamilyMemberResponse> addFamilyMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AddFamilyMemberRequest> request) async {
    return addFamilyMember(call, await request);
  }

  $async.Future<$1.UpdateFamilyMemberResponse> updateFamilyMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateFamilyMemberRequest> request) async {
    return updateFamilyMember(call, await request);
  }

  $async.Future<$1.RemoveFamilyMemberResponse> removeFamilyMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.RemoveFamilyMemberRequest> request) async {
    return removeFamilyMember(call, await request);
  }

  $async.Future<$1.AcceptFamilyInvitationResponse> acceptFamilyInvitation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AcceptFamilyInvitationRequest> request) async {
    return acceptFamilyInvitation(call, await request);
  }

  $async.Future<$1.DeclineFamilyInvitationResponse> declineFamilyInvitation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeclineFamilyInvitationRequest> request) async {
    return declineFamilyInvitation(call, await request);
  }

  $async.Future<$1.GetPendingInvitationsResponse> getPendingInvitations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetPendingInvitationsRequest> request) async {
    return getPendingInvitations(call, await request);
  }

  $async.Future<$1.GetFamilyTransactionsResponse> getFamilyTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetFamilyTransactionsRequest> request) async {
    return getFamilyTransactions(call, await request);
  }

  $async.Future<$1.AllocateFundsResponse> allocateFunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AllocateFundsRequest> request) async {
    return allocateFunds(call, await request);
  }

  $async.Future<$1.GenerateMemberCardResponse> generateMemberCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GenerateMemberCardRequest> request) async {
    return generateMemberCard(call, await request);
  }

  $async.Future<$1.FreezeFamilyAccountResponse> freezeFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.FreezeFamilyAccountRequest> request) async {
    return freezeFamilyAccount(call, await request);
  }

  $async.Future<$1.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UnfreezeFamilyAccountRequest> request) async {
    return unfreezeFamilyAccount(call, await request);
  }

  $async.Future<$1.DeleteFamilyAccountResponse> deleteFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteFamilyAccountRequest> request) async {
    return deleteFamilyAccount(call, await request);
  }

  $async.Future<$1.CreateFamilyAccountResponse> createFamilyAccount(
      $grpc.ServiceCall call, $1.CreateFamilyAccountRequest request);
  $async.Future<$1.GetFamilyAccountsResponse> getFamilyAccounts(
      $grpc.ServiceCall call, $1.GetFamilyAccountsRequest request);
  $async.Future<$1.GetFamilyAccountResponse> getFamilyAccount(
      $grpc.ServiceCall call, $1.GetFamilyAccountRequest request);
  $async.Future<$1.AddFamilyMemberResponse> addFamilyMember(
      $grpc.ServiceCall call, $1.AddFamilyMemberRequest request);
  $async.Future<$1.UpdateFamilyMemberResponse> updateFamilyMember(
      $grpc.ServiceCall call, $1.UpdateFamilyMemberRequest request);
  $async.Future<$1.RemoveFamilyMemberResponse> removeFamilyMember(
      $grpc.ServiceCall call, $1.RemoveFamilyMemberRequest request);
  $async.Future<$1.AcceptFamilyInvitationResponse> acceptFamilyInvitation(
      $grpc.ServiceCall call, $1.AcceptFamilyInvitationRequest request);
  $async.Future<$1.DeclineFamilyInvitationResponse> declineFamilyInvitation(
      $grpc.ServiceCall call, $1.DeclineFamilyInvitationRequest request);
  $async.Future<$1.GetPendingInvitationsResponse> getPendingInvitations(
      $grpc.ServiceCall call, $1.GetPendingInvitationsRequest request);
  $async.Future<$1.GetFamilyTransactionsResponse> getFamilyTransactions(
      $grpc.ServiceCall call, $1.GetFamilyTransactionsRequest request);
  $async.Future<$1.AllocateFundsResponse> allocateFunds(
      $grpc.ServiceCall call, $1.AllocateFundsRequest request);
  $async.Future<$1.GenerateMemberCardResponse> generateMemberCard(
      $grpc.ServiceCall call, $1.GenerateMemberCardRequest request);
  $async.Future<$1.FreezeFamilyAccountResponse> freezeFamilyAccount(
      $grpc.ServiceCall call, $1.FreezeFamilyAccountRequest request);
  $async.Future<$1.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount(
      $grpc.ServiceCall call, $1.UnfreezeFamilyAccountRequest request);
  $async.Future<$1.DeleteFamilyAccountResponse> deleteFamilyAccount(
      $grpc.ServiceCall call, $1.DeleteFamilyAccountRequest request);
}
