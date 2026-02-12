//
//  Generated code. Do not modify.
//  source: family_accounts.proto
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

import 'family_accounts.pb.dart' as $0;

export 'family_accounts.pb.dart';

@$pb.GrpcServiceName('accounts.v1.FamilyAccountsService')
class FamilyAccountsServiceClient extends $grpc.Client {
  static final _$createFamilyAccount = $grpc.ClientMethod<$0.CreateFamilyAccountRequest, $0.CreateFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/CreateFamilyAccount',
      ($0.CreateFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateFamilyAccountResponse.fromBuffer(value));
  static final _$getFamilyAccounts = $grpc.ClientMethod<$0.GetFamilyAccountsRequest, $0.GetFamilyAccountsResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyAccounts',
      ($0.GetFamilyAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetFamilyAccountsResponse.fromBuffer(value));
  static final _$getFamilyAccount = $grpc.ClientMethod<$0.GetFamilyAccountRequest, $0.GetFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyAccount',
      ($0.GetFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetFamilyAccountResponse.fromBuffer(value));
  static final _$addFamilyMember = $grpc.ClientMethod<$0.AddFamilyMemberRequest, $0.AddFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/AddFamilyMember',
      ($0.AddFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AddFamilyMemberResponse.fromBuffer(value));
  static final _$updateFamilyMember = $grpc.ClientMethod<$0.UpdateFamilyMemberRequest, $0.UpdateFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/UpdateFamilyMember',
      ($0.UpdateFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateFamilyMemberResponse.fromBuffer(value));
  static final _$removeFamilyMember = $grpc.ClientMethod<$0.RemoveFamilyMemberRequest, $0.RemoveFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/RemoveFamilyMember',
      ($0.RemoveFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RemoveFamilyMemberResponse.fromBuffer(value));
  static final _$acceptFamilyInvitation = $grpc.ClientMethod<$0.AcceptFamilyInvitationRequest, $0.AcceptFamilyInvitationResponse>(
      '/accounts.v1.FamilyAccountsService/AcceptFamilyInvitation',
      ($0.AcceptFamilyInvitationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AcceptFamilyInvitationResponse.fromBuffer(value));
  static final _$declineFamilyInvitation = $grpc.ClientMethod<$0.DeclineFamilyInvitationRequest, $0.DeclineFamilyInvitationResponse>(
      '/accounts.v1.FamilyAccountsService/DeclineFamilyInvitation',
      ($0.DeclineFamilyInvitationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeclineFamilyInvitationResponse.fromBuffer(value));
  static final _$getPendingInvitations = $grpc.ClientMethod<$0.GetPendingInvitationsRequest, $0.GetPendingInvitationsResponse>(
      '/accounts.v1.FamilyAccountsService/GetPendingInvitations',
      ($0.GetPendingInvitationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPendingInvitationsResponse.fromBuffer(value));
  static final _$getFamilyTransactions = $grpc.ClientMethod<$0.GetFamilyTransactionsRequest, $0.GetFamilyTransactionsResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyTransactions',
      ($0.GetFamilyTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetFamilyTransactionsResponse.fromBuffer(value));
  static final _$allocateFunds = $grpc.ClientMethod<$0.AllocateFundsRequest, $0.AllocateFundsResponse>(
      '/accounts.v1.FamilyAccountsService/AllocateFunds',
      ($0.AllocateFundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AllocateFundsResponse.fromBuffer(value));
  static final _$generateMemberCard = $grpc.ClientMethod<$0.GenerateMemberCardRequest, $0.GenerateMemberCardResponse>(
      '/accounts.v1.FamilyAccountsService/GenerateMemberCard',
      ($0.GenerateMemberCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GenerateMemberCardResponse.fromBuffer(value));
  static final _$freezeFamilyAccount = $grpc.ClientMethod<$0.FreezeFamilyAccountRequest, $0.FreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/FreezeFamilyAccount',
      ($0.FreezeFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.FreezeFamilyAccountResponse.fromBuffer(value));
  static final _$unfreezeFamilyAccount = $grpc.ClientMethod<$0.UnfreezeFamilyAccountRequest, $0.UnfreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/UnfreezeFamilyAccount',
      ($0.UnfreezeFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UnfreezeFamilyAccountResponse.fromBuffer(value));
  static final _$deleteFamilyAccount = $grpc.ClientMethod<$0.DeleteFamilyAccountRequest, $0.DeleteFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/DeleteFamilyAccount',
      ($0.DeleteFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteFamilyAccountResponse.fromBuffer(value));

  FamilyAccountsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateFamilyAccountResponse> createFamilyAccount($0.CreateFamilyAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFamilyAccountsResponse> getFamilyAccounts($0.GetFamilyAccountsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFamilyAccountResponse> getFamilyAccount($0.GetFamilyAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddFamilyMemberResponse> addFamilyMember($0.AddFamilyMemberRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateFamilyMemberResponse> updateFamilyMember($0.UpdateFamilyMemberRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.RemoveFamilyMemberResponse> removeFamilyMember($0.RemoveFamilyMemberRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.AcceptFamilyInvitationResponse> acceptFamilyInvitation($0.AcceptFamilyInvitationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptFamilyInvitation, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeclineFamilyInvitationResponse> declineFamilyInvitation($0.DeclineFamilyInvitationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineFamilyInvitation, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPendingInvitationsResponse> getPendingInvitations($0.GetPendingInvitationsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingInvitations, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFamilyTransactionsResponse> getFamilyTransactions($0.GetFamilyTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.AllocateFundsResponse> allocateFunds($0.AllocateFundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$allocateFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateMemberCardResponse> generateMemberCard($0.GenerateMemberCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateMemberCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.FreezeFamilyAccountResponse> freezeFamilyAccount($0.FreezeFamilyAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$freezeFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount($0.UnfreezeFamilyAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unfreezeFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteFamilyAccountResponse> deleteFamilyAccount($0.DeleteFamilyAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteFamilyAccount, request, options: options);
  }
}

@$pb.GrpcServiceName('accounts.v1.FamilyAccountsService')
abstract class FamilyAccountsServiceBase extends $grpc.Service {
  $core.String get $name => 'accounts.v1.FamilyAccountsService';

  FamilyAccountsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateFamilyAccountRequest, $0.CreateFamilyAccountResponse>(
        'CreateFamilyAccount',
        createFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateFamilyAccountRequest.fromBuffer(value),
        ($0.CreateFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFamilyAccountsRequest, $0.GetFamilyAccountsResponse>(
        'GetFamilyAccounts',
        getFamilyAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetFamilyAccountsRequest.fromBuffer(value),
        ($0.GetFamilyAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFamilyAccountRequest, $0.GetFamilyAccountResponse>(
        'GetFamilyAccount',
        getFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetFamilyAccountRequest.fromBuffer(value),
        ($0.GetFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddFamilyMemberRequest, $0.AddFamilyMemberResponse>(
        'AddFamilyMember',
        addFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddFamilyMemberRequest.fromBuffer(value),
        ($0.AddFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateFamilyMemberRequest, $0.UpdateFamilyMemberResponse>(
        'UpdateFamilyMember',
        updateFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateFamilyMemberRequest.fromBuffer(value),
        ($0.UpdateFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveFamilyMemberRequest, $0.RemoveFamilyMemberResponse>(
        'RemoveFamilyMember',
        removeFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RemoveFamilyMemberRequest.fromBuffer(value),
        ($0.RemoveFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AcceptFamilyInvitationRequest, $0.AcceptFamilyInvitationResponse>(
        'AcceptFamilyInvitation',
        acceptFamilyInvitation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AcceptFamilyInvitationRequest.fromBuffer(value),
        ($0.AcceptFamilyInvitationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeclineFamilyInvitationRequest, $0.DeclineFamilyInvitationResponse>(
        'DeclineFamilyInvitation',
        declineFamilyInvitation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeclineFamilyInvitationRequest.fromBuffer(value),
        ($0.DeclineFamilyInvitationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPendingInvitationsRequest, $0.GetPendingInvitationsResponse>(
        'GetPendingInvitations',
        getPendingInvitations_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPendingInvitationsRequest.fromBuffer(value),
        ($0.GetPendingInvitationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFamilyTransactionsRequest, $0.GetFamilyTransactionsResponse>(
        'GetFamilyTransactions',
        getFamilyTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetFamilyTransactionsRequest.fromBuffer(value),
        ($0.GetFamilyTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AllocateFundsRequest, $0.AllocateFundsResponse>(
        'AllocateFunds',
        allocateFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AllocateFundsRequest.fromBuffer(value),
        ($0.AllocateFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateMemberCardRequest, $0.GenerateMemberCardResponse>(
        'GenerateMemberCard',
        generateMemberCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GenerateMemberCardRequest.fromBuffer(value),
        ($0.GenerateMemberCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FreezeFamilyAccountRequest, $0.FreezeFamilyAccountResponse>(
        'FreezeFamilyAccount',
        freezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FreezeFamilyAccountRequest.fromBuffer(value),
        ($0.FreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnfreezeFamilyAccountRequest, $0.UnfreezeFamilyAccountResponse>(
        'UnfreezeFamilyAccount',
        unfreezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UnfreezeFamilyAccountRequest.fromBuffer(value),
        ($0.UnfreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteFamilyAccountRequest, $0.DeleteFamilyAccountResponse>(
        'DeleteFamilyAccount',
        deleteFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteFamilyAccountRequest.fromBuffer(value),
        ($0.DeleteFamilyAccountResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateFamilyAccountResponse> createFamilyAccount_Pre($grpc.ServiceCall call, $async.Future<$0.CreateFamilyAccountRequest> request) async {
    return createFamilyAccount(call, await request);
  }

  $async.Future<$0.GetFamilyAccountsResponse> getFamilyAccounts_Pre($grpc.ServiceCall call, $async.Future<$0.GetFamilyAccountsRequest> request) async {
    return getFamilyAccounts(call, await request);
  }

  $async.Future<$0.GetFamilyAccountResponse> getFamilyAccount_Pre($grpc.ServiceCall call, $async.Future<$0.GetFamilyAccountRequest> request) async {
    return getFamilyAccount(call, await request);
  }

  $async.Future<$0.AddFamilyMemberResponse> addFamilyMember_Pre($grpc.ServiceCall call, $async.Future<$0.AddFamilyMemberRequest> request) async {
    return addFamilyMember(call, await request);
  }

  $async.Future<$0.UpdateFamilyMemberResponse> updateFamilyMember_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateFamilyMemberRequest> request) async {
    return updateFamilyMember(call, await request);
  }

  $async.Future<$0.RemoveFamilyMemberResponse> removeFamilyMember_Pre($grpc.ServiceCall call, $async.Future<$0.RemoveFamilyMemberRequest> request) async {
    return removeFamilyMember(call, await request);
  }

  $async.Future<$0.AcceptFamilyInvitationResponse> acceptFamilyInvitation_Pre($grpc.ServiceCall call, $async.Future<$0.AcceptFamilyInvitationRequest> request) async {
    return acceptFamilyInvitation(call, await request);
  }

  $async.Future<$0.DeclineFamilyInvitationResponse> declineFamilyInvitation_Pre($grpc.ServiceCall call, $async.Future<$0.DeclineFamilyInvitationRequest> request) async {
    return declineFamilyInvitation(call, await request);
  }

  $async.Future<$0.GetPendingInvitationsResponse> getPendingInvitations_Pre($grpc.ServiceCall call, $async.Future<$0.GetPendingInvitationsRequest> request) async {
    return getPendingInvitations(call, await request);
  }

  $async.Future<$0.GetFamilyTransactionsResponse> getFamilyTransactions_Pre($grpc.ServiceCall call, $async.Future<$0.GetFamilyTransactionsRequest> request) async {
    return getFamilyTransactions(call, await request);
  }

  $async.Future<$0.AllocateFundsResponse> allocateFunds_Pre($grpc.ServiceCall call, $async.Future<$0.AllocateFundsRequest> request) async {
    return allocateFunds(call, await request);
  }

  $async.Future<$0.GenerateMemberCardResponse> generateMemberCard_Pre($grpc.ServiceCall call, $async.Future<$0.GenerateMemberCardRequest> request) async {
    return generateMemberCard(call, await request);
  }

  $async.Future<$0.FreezeFamilyAccountResponse> freezeFamilyAccount_Pre($grpc.ServiceCall call, $async.Future<$0.FreezeFamilyAccountRequest> request) async {
    return freezeFamilyAccount(call, await request);
  }

  $async.Future<$0.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount_Pre($grpc.ServiceCall call, $async.Future<$0.UnfreezeFamilyAccountRequest> request) async {
    return unfreezeFamilyAccount(call, await request);
  }

  $async.Future<$0.DeleteFamilyAccountResponse> deleteFamilyAccount_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteFamilyAccountRequest> request) async {
    return deleteFamilyAccount(call, await request);
  }

  $async.Future<$0.CreateFamilyAccountResponse> createFamilyAccount($grpc.ServiceCall call, $0.CreateFamilyAccountRequest request);
  $async.Future<$0.GetFamilyAccountsResponse> getFamilyAccounts($grpc.ServiceCall call, $0.GetFamilyAccountsRequest request);
  $async.Future<$0.GetFamilyAccountResponse> getFamilyAccount($grpc.ServiceCall call, $0.GetFamilyAccountRequest request);
  $async.Future<$0.AddFamilyMemberResponse> addFamilyMember($grpc.ServiceCall call, $0.AddFamilyMemberRequest request);
  $async.Future<$0.UpdateFamilyMemberResponse> updateFamilyMember($grpc.ServiceCall call, $0.UpdateFamilyMemberRequest request);
  $async.Future<$0.RemoveFamilyMemberResponse> removeFamilyMember($grpc.ServiceCall call, $0.RemoveFamilyMemberRequest request);
  $async.Future<$0.AcceptFamilyInvitationResponse> acceptFamilyInvitation($grpc.ServiceCall call, $0.AcceptFamilyInvitationRequest request);
  $async.Future<$0.DeclineFamilyInvitationResponse> declineFamilyInvitation($grpc.ServiceCall call, $0.DeclineFamilyInvitationRequest request);
  $async.Future<$0.GetPendingInvitationsResponse> getPendingInvitations($grpc.ServiceCall call, $0.GetPendingInvitationsRequest request);
  $async.Future<$0.GetFamilyTransactionsResponse> getFamilyTransactions($grpc.ServiceCall call, $0.GetFamilyTransactionsRequest request);
  $async.Future<$0.AllocateFundsResponse> allocateFunds($grpc.ServiceCall call, $0.AllocateFundsRequest request);
  $async.Future<$0.GenerateMemberCardResponse> generateMemberCard($grpc.ServiceCall call, $0.GenerateMemberCardRequest request);
  $async.Future<$0.FreezeFamilyAccountResponse> freezeFamilyAccount($grpc.ServiceCall call, $0.FreezeFamilyAccountRequest request);
  $async.Future<$0.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount($grpc.ServiceCall call, $0.UnfreezeFamilyAccountRequest request);
  $async.Future<$0.DeleteFamilyAccountResponse> deleteFamilyAccount($grpc.ServiceCall call, $0.DeleteFamilyAccountRequest request);
}
