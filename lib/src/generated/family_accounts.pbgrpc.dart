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

import 'family_accounts.pb.dart' as $2;

export 'family_accounts.pb.dart';

@$pb.GrpcServiceName('accounts.v1.FamilyAccountsService')
class FamilyAccountsServiceClient extends $grpc.Client {
  static final _$createFamilyAccount = $grpc.ClientMethod<$2.CreateFamilyAccountRequest, $2.CreateFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/CreateFamilyAccount',
      ($2.CreateFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.CreateFamilyAccountResponse.fromBuffer(value));
  static final _$getFamilyAccounts = $grpc.ClientMethod<$2.GetFamilyAccountsRequest, $2.GetFamilyAccountsResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyAccounts',
      ($2.GetFamilyAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetFamilyAccountsResponse.fromBuffer(value));
  static final _$getFamilyAccount = $grpc.ClientMethod<$2.GetFamilyAccountRequest, $2.GetFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyAccount',
      ($2.GetFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetFamilyAccountResponse.fromBuffer(value));
  static final _$addFamilyMember = $grpc.ClientMethod<$2.AddFamilyMemberRequest, $2.AddFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/AddFamilyMember',
      ($2.AddFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AddFamilyMemberResponse.fromBuffer(value));
  static final _$updateFamilyMember = $grpc.ClientMethod<$2.UpdateFamilyMemberRequest, $2.UpdateFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/UpdateFamilyMember',
      ($2.UpdateFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.UpdateFamilyMemberResponse.fromBuffer(value));
  static final _$removeFamilyMember = $grpc.ClientMethod<$2.RemoveFamilyMemberRequest, $2.RemoveFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/RemoveFamilyMember',
      ($2.RemoveFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.RemoveFamilyMemberResponse.fromBuffer(value));
  static final _$acceptFamilyInvitation = $grpc.ClientMethod<$2.AcceptFamilyInvitationRequest, $2.AcceptFamilyInvitationResponse>(
      '/accounts.v1.FamilyAccountsService/AcceptFamilyInvitation',
      ($2.AcceptFamilyInvitationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AcceptFamilyInvitationResponse.fromBuffer(value));
  static final _$declineFamilyInvitation = $grpc.ClientMethod<$2.DeclineFamilyInvitationRequest, $2.DeclineFamilyInvitationResponse>(
      '/accounts.v1.FamilyAccountsService/DeclineFamilyInvitation',
      ($2.DeclineFamilyInvitationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.DeclineFamilyInvitationResponse.fromBuffer(value));
  static final _$getPendingInvitations = $grpc.ClientMethod<$2.GetPendingInvitationsRequest, $2.GetPendingInvitationsResponse>(
      '/accounts.v1.FamilyAccountsService/GetPendingInvitations',
      ($2.GetPendingInvitationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetPendingInvitationsResponse.fromBuffer(value));
  static final _$getFamilyTransactions = $grpc.ClientMethod<$2.GetFamilyTransactionsRequest, $2.GetFamilyTransactionsResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyTransactions',
      ($2.GetFamilyTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetFamilyTransactionsResponse.fromBuffer(value));
  static final _$allocateFunds = $grpc.ClientMethod<$2.AllocateFundsRequest, $2.AllocateFundsResponse>(
      '/accounts.v1.FamilyAccountsService/AllocateFunds',
      ($2.AllocateFundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AllocateFundsResponse.fromBuffer(value));
  static final _$generateMemberCard = $grpc.ClientMethod<$2.GenerateMemberCardRequest, $2.GenerateMemberCardResponse>(
      '/accounts.v1.FamilyAccountsService/GenerateMemberCard',
      ($2.GenerateMemberCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GenerateMemberCardResponse.fromBuffer(value));
  static final _$freezeFamilyAccount = $grpc.ClientMethod<$2.FreezeFamilyAccountRequest, $2.FreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/FreezeFamilyAccount',
      ($2.FreezeFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.FreezeFamilyAccountResponse.fromBuffer(value));
  static final _$unfreezeFamilyAccount = $grpc.ClientMethod<$2.UnfreezeFamilyAccountRequest, $2.UnfreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/UnfreezeFamilyAccount',
      ($2.UnfreezeFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.UnfreezeFamilyAccountResponse.fromBuffer(value));
  static final _$deleteFamilyAccount = $grpc.ClientMethod<$2.DeleteFamilyAccountRequest, $2.DeleteFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/DeleteFamilyAccount',
      ($2.DeleteFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.DeleteFamilyAccountResponse.fromBuffer(value));
  static final _$processMemberContribution = $grpc.ClientMethod<$2.ProcessMemberContributionRequest, $2.ProcessMemberContributionResponse>(
      '/accounts.v1.FamilyAccountsService/ProcessMemberContribution',
      ($2.ProcessMemberContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.ProcessMemberContributionResponse.fromBuffer(value));
  static final _$setupFamilyAccount = $grpc.ClientMethod<$2.SetupFamilyAccountRequest, $2.SetupFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/SetupFamilyAccount',
      ($2.SetupFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.SetupFamilyAccountResponse.fromBuffer(value));
  static final _$updateFundDistributionMode = $grpc.ClientMethod<$2.UpdateFundDistributionModeRequest, $2.UpdateFundDistributionModeResponse>(
      '/accounts.v1.FamilyAccountsService/UpdateFundDistributionMode',
      ($2.UpdateFundDistributionModeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.UpdateFundDistributionModeResponse.fromBuffer(value));

  FamilyAccountsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$2.CreateFamilyAccountResponse> createFamilyAccount($2.CreateFamilyAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetFamilyAccountsResponse> getFamilyAccounts($2.GetFamilyAccountsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetFamilyAccountResponse> getFamilyAccount($2.GetFamilyAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$2.AddFamilyMemberResponse> addFamilyMember($2.AddFamilyMemberRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateFamilyMemberResponse> updateFamilyMember($2.UpdateFamilyMemberRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$2.RemoveFamilyMemberResponse> removeFamilyMember($2.RemoveFamilyMemberRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$2.AcceptFamilyInvitationResponse> acceptFamilyInvitation($2.AcceptFamilyInvitationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptFamilyInvitation, request, options: options);
  }

  $grpc.ResponseFuture<$2.DeclineFamilyInvitationResponse> declineFamilyInvitation($2.DeclineFamilyInvitationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineFamilyInvitation, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetPendingInvitationsResponse> getPendingInvitations($2.GetPendingInvitationsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingInvitations, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetFamilyTransactionsResponse> getFamilyTransactions($2.GetFamilyTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$2.AllocateFundsResponse> allocateFunds($2.AllocateFundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$allocateFunds, request, options: options);
  }

  $grpc.ResponseFuture<$2.GenerateMemberCardResponse> generateMemberCard($2.GenerateMemberCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateMemberCard, request, options: options);
  }

  $grpc.ResponseFuture<$2.FreezeFamilyAccountResponse> freezeFamilyAccount($2.FreezeFamilyAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$freezeFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$2.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount($2.UnfreezeFamilyAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unfreezeFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$2.DeleteFamilyAccountResponse> deleteFamilyAccount($2.DeleteFamilyAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$2.ProcessMemberContributionResponse> processMemberContribution($2.ProcessMemberContributionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processMemberContribution, request, options: options);
  }

  $grpc.ResponseFuture<$2.SetupFamilyAccountResponse> setupFamilyAccount($2.SetupFamilyAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setupFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateFundDistributionModeResponse> updateFundDistributionMode($2.UpdateFundDistributionModeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFundDistributionMode, request, options: options);
  }
}

@$pb.GrpcServiceName('accounts.v1.FamilyAccountsService')
abstract class FamilyAccountsServiceBase extends $grpc.Service {
  $core.String get $name => 'accounts.v1.FamilyAccountsService';

  FamilyAccountsServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.CreateFamilyAccountRequest, $2.CreateFamilyAccountResponse>(
        'CreateFamilyAccount',
        createFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CreateFamilyAccountRequest.fromBuffer(value),
        ($2.CreateFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetFamilyAccountsRequest, $2.GetFamilyAccountsResponse>(
        'GetFamilyAccounts',
        getFamilyAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetFamilyAccountsRequest.fromBuffer(value),
        ($2.GetFamilyAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetFamilyAccountRequest, $2.GetFamilyAccountResponse>(
        'GetFamilyAccount',
        getFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetFamilyAccountRequest.fromBuffer(value),
        ($2.GetFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.AddFamilyMemberRequest, $2.AddFamilyMemberResponse>(
        'AddFamilyMember',
        addFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.AddFamilyMemberRequest.fromBuffer(value),
        ($2.AddFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateFamilyMemberRequest, $2.UpdateFamilyMemberResponse>(
        'UpdateFamilyMember',
        updateFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.UpdateFamilyMemberRequest.fromBuffer(value),
        ($2.UpdateFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.RemoveFamilyMemberRequest, $2.RemoveFamilyMemberResponse>(
        'RemoveFamilyMember',
        removeFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.RemoveFamilyMemberRequest.fromBuffer(value),
        ($2.RemoveFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.AcceptFamilyInvitationRequest, $2.AcceptFamilyInvitationResponse>(
        'AcceptFamilyInvitation',
        acceptFamilyInvitation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.AcceptFamilyInvitationRequest.fromBuffer(value),
        ($2.AcceptFamilyInvitationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeclineFamilyInvitationRequest, $2.DeclineFamilyInvitationResponse>(
        'DeclineFamilyInvitation',
        declineFamilyInvitation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeclineFamilyInvitationRequest.fromBuffer(value),
        ($2.DeclineFamilyInvitationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetPendingInvitationsRequest, $2.GetPendingInvitationsResponse>(
        'GetPendingInvitations',
        getPendingInvitations_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetPendingInvitationsRequest.fromBuffer(value),
        ($2.GetPendingInvitationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetFamilyTransactionsRequest, $2.GetFamilyTransactionsResponse>(
        'GetFamilyTransactions',
        getFamilyTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetFamilyTransactionsRequest.fromBuffer(value),
        ($2.GetFamilyTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.AllocateFundsRequest, $2.AllocateFundsResponse>(
        'AllocateFunds',
        allocateFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.AllocateFundsRequest.fromBuffer(value),
        ($2.AllocateFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GenerateMemberCardRequest, $2.GenerateMemberCardResponse>(
        'GenerateMemberCard',
        generateMemberCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GenerateMemberCardRequest.fromBuffer(value),
        ($2.GenerateMemberCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.FreezeFamilyAccountRequest, $2.FreezeFamilyAccountResponse>(
        'FreezeFamilyAccount',
        freezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.FreezeFamilyAccountRequest.fromBuffer(value),
        ($2.FreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UnfreezeFamilyAccountRequest, $2.UnfreezeFamilyAccountResponse>(
        'UnfreezeFamilyAccount',
        unfreezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.UnfreezeFamilyAccountRequest.fromBuffer(value),
        ($2.UnfreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteFamilyAccountRequest, $2.DeleteFamilyAccountResponse>(
        'DeleteFamilyAccount',
        deleteFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeleteFamilyAccountRequest.fromBuffer(value),
        ($2.DeleteFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ProcessMemberContributionRequest, $2.ProcessMemberContributionResponse>(
        'ProcessMemberContribution',
        processMemberContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ProcessMemberContributionRequest.fromBuffer(value),
        ($2.ProcessMemberContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.SetupFamilyAccountRequest, $2.SetupFamilyAccountResponse>(
        'SetupFamilyAccount',
        setupFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.SetupFamilyAccountRequest.fromBuffer(value),
        ($2.SetupFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateFundDistributionModeRequest, $2.UpdateFundDistributionModeResponse>(
        'UpdateFundDistributionMode',
        updateFundDistributionMode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.UpdateFundDistributionModeRequest.fromBuffer(value),
        ($2.UpdateFundDistributionModeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.CreateFamilyAccountResponse> createFamilyAccount_Pre($grpc.ServiceCall call, $async.Future<$2.CreateFamilyAccountRequest> request) async {
    return createFamilyAccount(call, await request);
  }

  $async.Future<$2.GetFamilyAccountsResponse> getFamilyAccounts_Pre($grpc.ServiceCall call, $async.Future<$2.GetFamilyAccountsRequest> request) async {
    return getFamilyAccounts(call, await request);
  }

  $async.Future<$2.GetFamilyAccountResponse> getFamilyAccount_Pre($grpc.ServiceCall call, $async.Future<$2.GetFamilyAccountRequest> request) async {
    return getFamilyAccount(call, await request);
  }

  $async.Future<$2.AddFamilyMemberResponse> addFamilyMember_Pre($grpc.ServiceCall call, $async.Future<$2.AddFamilyMemberRequest> request) async {
    return addFamilyMember(call, await request);
  }

  $async.Future<$2.UpdateFamilyMemberResponse> updateFamilyMember_Pre($grpc.ServiceCall call, $async.Future<$2.UpdateFamilyMemberRequest> request) async {
    return updateFamilyMember(call, await request);
  }

  $async.Future<$2.RemoveFamilyMemberResponse> removeFamilyMember_Pre($grpc.ServiceCall call, $async.Future<$2.RemoveFamilyMemberRequest> request) async {
    return removeFamilyMember(call, await request);
  }

  $async.Future<$2.AcceptFamilyInvitationResponse> acceptFamilyInvitation_Pre($grpc.ServiceCall call, $async.Future<$2.AcceptFamilyInvitationRequest> request) async {
    return acceptFamilyInvitation(call, await request);
  }

  $async.Future<$2.DeclineFamilyInvitationResponse> declineFamilyInvitation_Pre($grpc.ServiceCall call, $async.Future<$2.DeclineFamilyInvitationRequest> request) async {
    return declineFamilyInvitation(call, await request);
  }

  $async.Future<$2.GetPendingInvitationsResponse> getPendingInvitations_Pre($grpc.ServiceCall call, $async.Future<$2.GetPendingInvitationsRequest> request) async {
    return getPendingInvitations(call, await request);
  }

  $async.Future<$2.GetFamilyTransactionsResponse> getFamilyTransactions_Pre($grpc.ServiceCall call, $async.Future<$2.GetFamilyTransactionsRequest> request) async {
    return getFamilyTransactions(call, await request);
  }

  $async.Future<$2.AllocateFundsResponse> allocateFunds_Pre($grpc.ServiceCall call, $async.Future<$2.AllocateFundsRequest> request) async {
    return allocateFunds(call, await request);
  }

  $async.Future<$2.GenerateMemberCardResponse> generateMemberCard_Pre($grpc.ServiceCall call, $async.Future<$2.GenerateMemberCardRequest> request) async {
    return generateMemberCard(call, await request);
  }

  $async.Future<$2.FreezeFamilyAccountResponse> freezeFamilyAccount_Pre($grpc.ServiceCall call, $async.Future<$2.FreezeFamilyAccountRequest> request) async {
    return freezeFamilyAccount(call, await request);
  }

  $async.Future<$2.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount_Pre($grpc.ServiceCall call, $async.Future<$2.UnfreezeFamilyAccountRequest> request) async {
    return unfreezeFamilyAccount(call, await request);
  }

  $async.Future<$2.DeleteFamilyAccountResponse> deleteFamilyAccount_Pre($grpc.ServiceCall call, $async.Future<$2.DeleteFamilyAccountRequest> request) async {
    return deleteFamilyAccount(call, await request);
  }

  $async.Future<$2.ProcessMemberContributionResponse> processMemberContribution_Pre($grpc.ServiceCall call, $async.Future<$2.ProcessMemberContributionRequest> request) async {
    return processMemberContribution(call, await request);
  }

  $async.Future<$2.SetupFamilyAccountResponse> setupFamilyAccount_Pre($grpc.ServiceCall call, $async.Future<$2.SetupFamilyAccountRequest> request) async {
    return setupFamilyAccount(call, await request);
  }

  $async.Future<$2.UpdateFundDistributionModeResponse> updateFundDistributionMode_Pre($grpc.ServiceCall call, $async.Future<$2.UpdateFundDistributionModeRequest> request) async {
    return updateFundDistributionMode(call, await request);
  }

  $async.Future<$2.CreateFamilyAccountResponse> createFamilyAccount($grpc.ServiceCall call, $2.CreateFamilyAccountRequest request);
  $async.Future<$2.GetFamilyAccountsResponse> getFamilyAccounts($grpc.ServiceCall call, $2.GetFamilyAccountsRequest request);
  $async.Future<$2.GetFamilyAccountResponse> getFamilyAccount($grpc.ServiceCall call, $2.GetFamilyAccountRequest request);
  $async.Future<$2.AddFamilyMemberResponse> addFamilyMember($grpc.ServiceCall call, $2.AddFamilyMemberRequest request);
  $async.Future<$2.UpdateFamilyMemberResponse> updateFamilyMember($grpc.ServiceCall call, $2.UpdateFamilyMemberRequest request);
  $async.Future<$2.RemoveFamilyMemberResponse> removeFamilyMember($grpc.ServiceCall call, $2.RemoveFamilyMemberRequest request);
  $async.Future<$2.AcceptFamilyInvitationResponse> acceptFamilyInvitation($grpc.ServiceCall call, $2.AcceptFamilyInvitationRequest request);
  $async.Future<$2.DeclineFamilyInvitationResponse> declineFamilyInvitation($grpc.ServiceCall call, $2.DeclineFamilyInvitationRequest request);
  $async.Future<$2.GetPendingInvitationsResponse> getPendingInvitations($grpc.ServiceCall call, $2.GetPendingInvitationsRequest request);
  $async.Future<$2.GetFamilyTransactionsResponse> getFamilyTransactions($grpc.ServiceCall call, $2.GetFamilyTransactionsRequest request);
  $async.Future<$2.AllocateFundsResponse> allocateFunds($grpc.ServiceCall call, $2.AllocateFundsRequest request);
  $async.Future<$2.GenerateMemberCardResponse> generateMemberCard($grpc.ServiceCall call, $2.GenerateMemberCardRequest request);
  $async.Future<$2.FreezeFamilyAccountResponse> freezeFamilyAccount($grpc.ServiceCall call, $2.FreezeFamilyAccountRequest request);
  $async.Future<$2.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount($grpc.ServiceCall call, $2.UnfreezeFamilyAccountRequest request);
  $async.Future<$2.DeleteFamilyAccountResponse> deleteFamilyAccount($grpc.ServiceCall call, $2.DeleteFamilyAccountRequest request);
  $async.Future<$2.ProcessMemberContributionResponse> processMemberContribution($grpc.ServiceCall call, $2.ProcessMemberContributionRequest request);
  $async.Future<$2.SetupFamilyAccountResponse> setupFamilyAccount($grpc.ServiceCall call, $2.SetupFamilyAccountRequest request);
  $async.Future<$2.UpdateFundDistributionModeResponse> updateFundDistributionMode($grpc.ServiceCall call, $2.UpdateFundDistributionModeRequest request);
}
