///
//  Generated code. Do not modify.
//  source: family_accounts.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'family_accounts.pb.dart' as $18;
export 'family_accounts.pb.dart';

class FamilyAccountsServiceClient extends $grpc.Client {
  static final _$createFamilyAccount = $grpc.ClientMethod<
          $18.CreateFamilyAccountRequest, $18.CreateFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/CreateFamilyAccount',
      ($18.CreateFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.CreateFamilyAccountResponse.fromBuffer(value));
  static final _$getFamilyAccounts = $grpc.ClientMethod<
          $18.GetFamilyAccountsRequest, $18.GetFamilyAccountsResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyAccounts',
      ($18.GetFamilyAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetFamilyAccountsResponse.fromBuffer(value));
  static final _$getFamilyAccount = $grpc.ClientMethod<
          $18.GetFamilyAccountRequest, $18.GetFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyAccount',
      ($18.GetFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetFamilyAccountResponse.fromBuffer(value));
  static final _$addFamilyMember = $grpc.ClientMethod<
          $18.AddFamilyMemberRequest, $18.AddFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/AddFamilyMember',
      ($18.AddFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.AddFamilyMemberResponse.fromBuffer(value));
  static final _$updateFamilyMember = $grpc.ClientMethod<
          $18.UpdateFamilyMemberRequest, $18.UpdateFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/UpdateFamilyMember',
      ($18.UpdateFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.UpdateFamilyMemberResponse.fromBuffer(value));
  static final _$removeFamilyMember = $grpc.ClientMethod<
          $18.RemoveFamilyMemberRequest, $18.RemoveFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/RemoveFamilyMember',
      ($18.RemoveFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.RemoveFamilyMemberResponse.fromBuffer(value));
  static final _$acceptFamilyInvitation = $grpc.ClientMethod<
          $18.AcceptFamilyInvitationRequest,
          $18.AcceptFamilyInvitationResponse>(
      '/accounts.v1.FamilyAccountsService/AcceptFamilyInvitation',
      ($18.AcceptFamilyInvitationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.AcceptFamilyInvitationResponse.fromBuffer(value));
  static final _$declineFamilyInvitation = $grpc.ClientMethod<
          $18.DeclineFamilyInvitationRequest,
          $18.DeclineFamilyInvitationResponse>(
      '/accounts.v1.FamilyAccountsService/DeclineFamilyInvitation',
      ($18.DeclineFamilyInvitationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.DeclineFamilyInvitationResponse.fromBuffer(value));
  static final _$getPendingInvitations = $grpc.ClientMethod<
          $18.GetPendingInvitationsRequest, $18.GetPendingInvitationsResponse>(
      '/accounts.v1.FamilyAccountsService/GetPendingInvitations',
      ($18.GetPendingInvitationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetPendingInvitationsResponse.fromBuffer(value));
  static final _$getFamilyTransactions = $grpc.ClientMethod<
          $18.GetFamilyTransactionsRequest, $18.GetFamilyTransactionsResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyTransactions',
      ($18.GetFamilyTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetFamilyTransactionsResponse.fromBuffer(value));
  static final _$allocateFunds =
      $grpc.ClientMethod<$18.AllocateFundsRequest, $18.AllocateFundsResponse>(
          '/accounts.v1.FamilyAccountsService/AllocateFunds',
          ($18.AllocateFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.AllocateFundsResponse.fromBuffer(value));
  static final _$generateMemberCard = $grpc.ClientMethod<
          $18.GenerateMemberCardRequest, $18.GenerateMemberCardResponse>(
      '/accounts.v1.FamilyAccountsService/GenerateMemberCard',
      ($18.GenerateMemberCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GenerateMemberCardResponse.fromBuffer(value));
  static final _$freezeFamilyAccount = $grpc.ClientMethod<
          $18.FreezeFamilyAccountRequest, $18.FreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/FreezeFamilyAccount',
      ($18.FreezeFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.FreezeFamilyAccountResponse.fromBuffer(value));
  static final _$unfreezeFamilyAccount = $grpc.ClientMethod<
          $18.UnfreezeFamilyAccountRequest, $18.UnfreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/UnfreezeFamilyAccount',
      ($18.UnfreezeFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.UnfreezeFamilyAccountResponse.fromBuffer(value));
  static final _$deleteFamilyAccount = $grpc.ClientMethod<
          $18.DeleteFamilyAccountRequest, $18.DeleteFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/DeleteFamilyAccount',
      ($18.DeleteFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.DeleteFamilyAccountResponse.fromBuffer(value));
  static final _$processMemberContribution = $grpc.ClientMethod<
          $18.ProcessMemberContributionRequest,
          $18.ProcessMemberContributionResponse>(
      '/accounts.v1.FamilyAccountsService/ProcessMemberContribution',
      ($18.ProcessMemberContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.ProcessMemberContributionResponse.fromBuffer(value));
  static final _$setupFamilyAccount = $grpc.ClientMethod<
          $18.SetupFamilyAccountRequest, $18.SetupFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/SetupFamilyAccount',
      ($18.SetupFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.SetupFamilyAccountResponse.fromBuffer(value));
  static final _$updateFundDistributionMode = $grpc.ClientMethod<
          $18.UpdateFundDistributionModeRequest,
          $18.UpdateFundDistributionModeResponse>(
      '/accounts.v1.FamilyAccountsService/UpdateFundDistributionMode',
      ($18.UpdateFundDistributionModeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.UpdateFundDistributionModeResponse.fromBuffer(value));

  FamilyAccountsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$18.CreateFamilyAccountResponse> createFamilyAccount(
      $18.CreateFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetFamilyAccountsResponse> getFamilyAccounts(
      $18.GetFamilyAccountsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetFamilyAccountResponse> getFamilyAccount(
      $18.GetFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$18.AddFamilyMemberResponse> addFamilyMember(
      $18.AddFamilyMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$18.UpdateFamilyMemberResponse> updateFamilyMember(
      $18.UpdateFamilyMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$18.RemoveFamilyMemberResponse> removeFamilyMember(
      $18.RemoveFamilyMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeFamilyMember, request, options: options);
  }

  $grpc.ResponseFuture<$18.AcceptFamilyInvitationResponse>
      acceptFamilyInvitation($18.AcceptFamilyInvitationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptFamilyInvitation, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.DeclineFamilyInvitationResponse>
      declineFamilyInvitation($18.DeclineFamilyInvitationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineFamilyInvitation, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.GetPendingInvitationsResponse> getPendingInvitations(
      $18.GetPendingInvitationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingInvitations, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetFamilyTransactionsResponse> getFamilyTransactions(
      $18.GetFamilyTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFamilyTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$18.AllocateFundsResponse> allocateFunds(
      $18.AllocateFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$allocateFunds, request, options: options);
  }

  $grpc.ResponseFuture<$18.GenerateMemberCardResponse> generateMemberCard(
      $18.GenerateMemberCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateMemberCard, request, options: options);
  }

  $grpc.ResponseFuture<$18.FreezeFamilyAccountResponse> freezeFamilyAccount(
      $18.FreezeFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$freezeFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$18.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount(
      $18.UnfreezeFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unfreezeFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$18.DeleteFamilyAccountResponse> deleteFamilyAccount(
      $18.DeleteFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$18.ProcessMemberContributionResponse>
      processMemberContribution($18.ProcessMemberContributionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processMemberContribution, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.SetupFamilyAccountResponse> setupFamilyAccount(
      $18.SetupFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setupFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$18.UpdateFundDistributionModeResponse>
      updateFundDistributionMode($18.UpdateFundDistributionModeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFundDistributionMode, request,
        options: options);
  }
}

abstract class FamilyAccountsServiceBase extends $grpc.Service {
  $core.String get $name => 'accounts.v1.FamilyAccountsService';

  FamilyAccountsServiceBase() {
    $addMethod($grpc.ServiceMethod<$18.CreateFamilyAccountRequest,
            $18.CreateFamilyAccountResponse>(
        'CreateFamilyAccount',
        createFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.CreateFamilyAccountRequest.fromBuffer(value),
        ($18.CreateFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetFamilyAccountsRequest,
            $18.GetFamilyAccountsResponse>(
        'GetFamilyAccounts',
        getFamilyAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetFamilyAccountsRequest.fromBuffer(value),
        ($18.GetFamilyAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetFamilyAccountRequest,
            $18.GetFamilyAccountResponse>(
        'GetFamilyAccount',
        getFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetFamilyAccountRequest.fromBuffer(value),
        ($18.GetFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.AddFamilyMemberRequest,
            $18.AddFamilyMemberResponse>(
        'AddFamilyMember',
        addFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.AddFamilyMemberRequest.fromBuffer(value),
        ($18.AddFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.UpdateFamilyMemberRequest,
            $18.UpdateFamilyMemberResponse>(
        'UpdateFamilyMember',
        updateFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.UpdateFamilyMemberRequest.fromBuffer(value),
        ($18.UpdateFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.RemoveFamilyMemberRequest,
            $18.RemoveFamilyMemberResponse>(
        'RemoveFamilyMember',
        removeFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.RemoveFamilyMemberRequest.fromBuffer(value),
        ($18.RemoveFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.AcceptFamilyInvitationRequest,
            $18.AcceptFamilyInvitationResponse>(
        'AcceptFamilyInvitation',
        acceptFamilyInvitation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.AcceptFamilyInvitationRequest.fromBuffer(value),
        ($18.AcceptFamilyInvitationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.DeclineFamilyInvitationRequest,
            $18.DeclineFamilyInvitationResponse>(
        'DeclineFamilyInvitation',
        declineFamilyInvitation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.DeclineFamilyInvitationRequest.fromBuffer(value),
        ($18.DeclineFamilyInvitationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetPendingInvitationsRequest,
            $18.GetPendingInvitationsResponse>(
        'GetPendingInvitations',
        getPendingInvitations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetPendingInvitationsRequest.fromBuffer(value),
        ($18.GetPendingInvitationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetFamilyTransactionsRequest,
            $18.GetFamilyTransactionsResponse>(
        'GetFamilyTransactions',
        getFamilyTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetFamilyTransactionsRequest.fromBuffer(value),
        ($18.GetFamilyTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.AllocateFundsRequest,
            $18.AllocateFundsResponse>(
        'AllocateFunds',
        allocateFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.AllocateFundsRequest.fromBuffer(value),
        ($18.AllocateFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GenerateMemberCardRequest,
            $18.GenerateMemberCardResponse>(
        'GenerateMemberCard',
        generateMemberCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GenerateMemberCardRequest.fromBuffer(value),
        ($18.GenerateMemberCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.FreezeFamilyAccountRequest,
            $18.FreezeFamilyAccountResponse>(
        'FreezeFamilyAccount',
        freezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.FreezeFamilyAccountRequest.fromBuffer(value),
        ($18.FreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.UnfreezeFamilyAccountRequest,
            $18.UnfreezeFamilyAccountResponse>(
        'UnfreezeFamilyAccount',
        unfreezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.UnfreezeFamilyAccountRequest.fromBuffer(value),
        ($18.UnfreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.DeleteFamilyAccountRequest,
            $18.DeleteFamilyAccountResponse>(
        'DeleteFamilyAccount',
        deleteFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.DeleteFamilyAccountRequest.fromBuffer(value),
        ($18.DeleteFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.ProcessMemberContributionRequest,
            $18.ProcessMemberContributionResponse>(
        'ProcessMemberContribution',
        processMemberContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.ProcessMemberContributionRequest.fromBuffer(value),
        ($18.ProcessMemberContributionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.SetupFamilyAccountRequest,
            $18.SetupFamilyAccountResponse>(
        'SetupFamilyAccount',
        setupFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.SetupFamilyAccountRequest.fromBuffer(value),
        ($18.SetupFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.UpdateFundDistributionModeRequest,
            $18.UpdateFundDistributionModeResponse>(
        'UpdateFundDistributionMode',
        updateFundDistributionMode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.UpdateFundDistributionModeRequest.fromBuffer(value),
        ($18.UpdateFundDistributionModeResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$18.CreateFamilyAccountResponse> createFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.CreateFamilyAccountRequest> request) async {
    return createFamilyAccount(call, await request);
  }

  $async.Future<$18.GetFamilyAccountsResponse> getFamilyAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetFamilyAccountsRequest> request) async {
    return getFamilyAccounts(call, await request);
  }

  $async.Future<$18.GetFamilyAccountResponse> getFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetFamilyAccountRequest> request) async {
    return getFamilyAccount(call, await request);
  }

  $async.Future<$18.AddFamilyMemberResponse> addFamilyMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.AddFamilyMemberRequest> request) async {
    return addFamilyMember(call, await request);
  }

  $async.Future<$18.UpdateFamilyMemberResponse> updateFamilyMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.UpdateFamilyMemberRequest> request) async {
    return updateFamilyMember(call, await request);
  }

  $async.Future<$18.RemoveFamilyMemberResponse> removeFamilyMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.RemoveFamilyMemberRequest> request) async {
    return removeFamilyMember(call, await request);
  }

  $async.Future<$18.AcceptFamilyInvitationResponse> acceptFamilyInvitation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.AcceptFamilyInvitationRequest> request) async {
    return acceptFamilyInvitation(call, await request);
  }

  $async.Future<$18.DeclineFamilyInvitationResponse>
      declineFamilyInvitation_Pre($grpc.ServiceCall call,
          $async.Future<$18.DeclineFamilyInvitationRequest> request) async {
    return declineFamilyInvitation(call, await request);
  }

  $async.Future<$18.GetPendingInvitationsResponse> getPendingInvitations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetPendingInvitationsRequest> request) async {
    return getPendingInvitations(call, await request);
  }

  $async.Future<$18.GetFamilyTransactionsResponse> getFamilyTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetFamilyTransactionsRequest> request) async {
    return getFamilyTransactions(call, await request);
  }

  $async.Future<$18.AllocateFundsResponse> allocateFunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.AllocateFundsRequest> request) async {
    return allocateFunds(call, await request);
  }

  $async.Future<$18.GenerateMemberCardResponse> generateMemberCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GenerateMemberCardRequest> request) async {
    return generateMemberCard(call, await request);
  }

  $async.Future<$18.FreezeFamilyAccountResponse> freezeFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.FreezeFamilyAccountRequest> request) async {
    return freezeFamilyAccount(call, await request);
  }

  $async.Future<$18.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.UnfreezeFamilyAccountRequest> request) async {
    return unfreezeFamilyAccount(call, await request);
  }

  $async.Future<$18.DeleteFamilyAccountResponse> deleteFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.DeleteFamilyAccountRequest> request) async {
    return deleteFamilyAccount(call, await request);
  }

  $async.Future<$18.ProcessMemberContributionResponse>
      processMemberContribution_Pre($grpc.ServiceCall call,
          $async.Future<$18.ProcessMemberContributionRequest> request) async {
    return processMemberContribution(call, await request);
  }

  $async.Future<$18.SetupFamilyAccountResponse> setupFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.SetupFamilyAccountRequest> request) async {
    return setupFamilyAccount(call, await request);
  }

  $async.Future<$18.UpdateFundDistributionModeResponse>
      updateFundDistributionMode_Pre($grpc.ServiceCall call,
          $async.Future<$18.UpdateFundDistributionModeRequest> request) async {
    return updateFundDistributionMode(call, await request);
  }

  $async.Future<$18.CreateFamilyAccountResponse> createFamilyAccount(
      $grpc.ServiceCall call, $18.CreateFamilyAccountRequest request);
  $async.Future<$18.GetFamilyAccountsResponse> getFamilyAccounts(
      $grpc.ServiceCall call, $18.GetFamilyAccountsRequest request);
  $async.Future<$18.GetFamilyAccountResponse> getFamilyAccount(
      $grpc.ServiceCall call, $18.GetFamilyAccountRequest request);
  $async.Future<$18.AddFamilyMemberResponse> addFamilyMember(
      $grpc.ServiceCall call, $18.AddFamilyMemberRequest request);
  $async.Future<$18.UpdateFamilyMemberResponse> updateFamilyMember(
      $grpc.ServiceCall call, $18.UpdateFamilyMemberRequest request);
  $async.Future<$18.RemoveFamilyMemberResponse> removeFamilyMember(
      $grpc.ServiceCall call, $18.RemoveFamilyMemberRequest request);
  $async.Future<$18.AcceptFamilyInvitationResponse> acceptFamilyInvitation(
      $grpc.ServiceCall call, $18.AcceptFamilyInvitationRequest request);
  $async.Future<$18.DeclineFamilyInvitationResponse> declineFamilyInvitation(
      $grpc.ServiceCall call, $18.DeclineFamilyInvitationRequest request);
  $async.Future<$18.GetPendingInvitationsResponse> getPendingInvitations(
      $grpc.ServiceCall call, $18.GetPendingInvitationsRequest request);
  $async.Future<$18.GetFamilyTransactionsResponse> getFamilyTransactions(
      $grpc.ServiceCall call, $18.GetFamilyTransactionsRequest request);
  $async.Future<$18.AllocateFundsResponse> allocateFunds(
      $grpc.ServiceCall call, $18.AllocateFundsRequest request);
  $async.Future<$18.GenerateMemberCardResponse> generateMemberCard(
      $grpc.ServiceCall call, $18.GenerateMemberCardRequest request);
  $async.Future<$18.FreezeFamilyAccountResponse> freezeFamilyAccount(
      $grpc.ServiceCall call, $18.FreezeFamilyAccountRequest request);
  $async.Future<$18.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount(
      $grpc.ServiceCall call, $18.UnfreezeFamilyAccountRequest request);
  $async.Future<$18.DeleteFamilyAccountResponse> deleteFamilyAccount(
      $grpc.ServiceCall call, $18.DeleteFamilyAccountRequest request);
  $async.Future<$18.ProcessMemberContributionResponse>
      processMemberContribution(
          $grpc.ServiceCall call, $18.ProcessMemberContributionRequest request);
  $async.Future<$18.SetupFamilyAccountResponse> setupFamilyAccount(
      $grpc.ServiceCall call, $18.SetupFamilyAccountRequest request);
  $async.Future<$18.UpdateFundDistributionModeResponse>
      updateFundDistributionMode($grpc.ServiceCall call,
          $18.UpdateFundDistributionModeRequest request);
}
