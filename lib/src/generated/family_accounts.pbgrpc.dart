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
  static final _$getMyInvitationHistory = $grpc.ClientMethod<
          $1.GetMyInvitationHistoryRequest, $1.GetMyInvitationHistoryResponse>(
      '/accounts.v1.FamilyAccountsService/GetMyInvitationHistory',
      ($1.GetMyInvitationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetMyInvitationHistoryResponse.fromBuffer(value));
  static final _$getSentInvitations = $grpc.ClientMethod<
          $1.GetSentInvitationsRequest, $1.GetSentInvitationsResponse>(
      '/accounts.v1.FamilyAccountsService/GetSentInvitations',
      ($1.GetSentInvitationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetSentInvitationsResponse.fromBuffer(value));
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
  static final _$leaveFamilyAccount = $grpc.ClientMethod<
          $1.LeaveFamilyAccountRequest, $1.LeaveFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/LeaveFamilyAccount',
      ($1.LeaveFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.LeaveFamilyAccountResponse.fromBuffer(value));
  static final _$processMemberContribution = $grpc.ClientMethod<
          $1.ProcessMemberContributionRequest,
          $1.ProcessMemberContributionResponse>(
      '/accounts.v1.FamilyAccountsService/ProcessMemberContribution',
      ($1.ProcessMemberContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ProcessMemberContributionResponse.fromBuffer(value));
  static final _$setupFamilyAccount = $grpc.ClientMethod<
          $1.SetupFamilyAccountRequest, $1.SetupFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/SetupFamilyAccount',
      ($1.SetupFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.SetupFamilyAccountResponse.fromBuffer(value));
  static final _$updateFundDistributionMode = $grpc.ClientMethod<
          $1.UpdateFundDistributionModeRequest,
          $1.UpdateFundDistributionModeResponse>(
      '/accounts.v1.FamilyAccountsService/UpdateFundDistributionMode',
      ($1.UpdateFundDistributionModeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateFundDistributionModeResponse.fromBuffer(value));
  static final _$adminListFamilyAccounts = $grpc.ClientMethod<
          $1.AdminListFamilyAccountsRequest,
          $1.AdminListFamilyAccountsResponse>(
      '/accounts.v1.FamilyAccountsService/AdminListFamilyAccounts',
      ($1.AdminListFamilyAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AdminListFamilyAccountsResponse.fromBuffer(value));
  static final _$adminGetFamilyAccount = $grpc.ClientMethod<
          $1.AdminGetFamilyAccountRequest, $1.AdminGetFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/AdminGetFamilyAccount',
      ($1.AdminGetFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AdminGetFamilyAccountResponse.fromBuffer(value));
  static final _$adminFreezeFamilyAccount = $grpc.ClientMethod<
          $1.AdminFreezeFamilyAccountRequest,
          $1.AdminFreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/AdminFreezeFamilyAccount',
      ($1.AdminFreezeFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AdminFreezeFamilyAccountResponse.fromBuffer(value));
  static final _$adminUnfreezeFamilyAccount = $grpc.ClientMethod<
          $1.AdminUnfreezeFamilyAccountRequest,
          $1.AdminUnfreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/AdminUnfreezeFamilyAccount',
      ($1.AdminUnfreezeFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AdminUnfreezeFamilyAccountResponse.fromBuffer(value));
  static final _$adminDeleteFamilyAccount = $grpc.ClientMethod<
          $1.AdminDeleteFamilyAccountRequest,
          $1.AdminDeleteFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/AdminDeleteFamilyAccount',
      ($1.AdminDeleteFamilyAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AdminDeleteFamilyAccountResponse.fromBuffer(value));
  static final _$adminForceAllocateFunds = $grpc.ClientMethod<
          $1.AdminForceAllocateFundsRequest,
          $1.AdminForceAllocateFundsResponse>(
      '/accounts.v1.FamilyAccountsService/AdminForceAllocateFunds',
      ($1.AdminForceAllocateFundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AdminForceAllocateFundsResponse.fromBuffer(value));
  static final _$adminRemoveFamilyMember = $grpc.ClientMethod<
          $1.AdminRemoveFamilyMemberRequest,
          $1.AdminRemoveFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/AdminRemoveFamilyMember',
      ($1.AdminRemoveFamilyMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AdminRemoveFamilyMemberResponse.fromBuffer(value));
  static final _$adminUpdateFamilyAccountNotes = $grpc.ClientMethod<
          $1.AdminUpdateFamilyAccountNotesRequest,
          $1.AdminUpdateFamilyAccountNotesResponse>(
      '/accounts.v1.FamilyAccountsService/AdminUpdateFamilyAccountNotes',
      ($1.AdminUpdateFamilyAccountNotesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AdminUpdateFamilyAccountNotesResponse.fromBuffer(value));

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

  $grpc.ResponseFuture<$1.GetMyInvitationHistoryResponse>
      getMyInvitationHistory($1.GetMyInvitationHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyInvitationHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetSentInvitationsResponse> getSentInvitations(
      $1.GetSentInvitationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSentInvitations, request, options: options);
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

  $grpc.ResponseFuture<$1.LeaveFamilyAccountResponse> leaveFamilyAccount(
      $1.LeaveFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$leaveFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.ProcessMemberContributionResponse>
      processMemberContribution($1.ProcessMemberContributionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processMemberContribution, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.SetupFamilyAccountResponse> setupFamilyAccount(
      $1.SetupFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setupFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateFundDistributionModeResponse>
      updateFundDistributionMode($1.UpdateFundDistributionModeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFundDistributionMode, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.AdminListFamilyAccountsResponse>
      adminListFamilyAccounts($1.AdminListFamilyAccountsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListFamilyAccounts, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.AdminGetFamilyAccountResponse> adminGetFamilyAccount(
      $1.AdminGetFamilyAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetFamilyAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.AdminFreezeFamilyAccountResponse>
      adminFreezeFamilyAccount($1.AdminFreezeFamilyAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminFreezeFamilyAccount, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.AdminUnfreezeFamilyAccountResponse>
      adminUnfreezeFamilyAccount($1.AdminUnfreezeFamilyAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminUnfreezeFamilyAccount, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.AdminDeleteFamilyAccountResponse>
      adminDeleteFamilyAccount($1.AdminDeleteFamilyAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminDeleteFamilyAccount, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.AdminForceAllocateFundsResponse>
      adminForceAllocateFunds($1.AdminForceAllocateFundsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminForceAllocateFunds, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.AdminRemoveFamilyMemberResponse>
      adminRemoveFamilyMember($1.AdminRemoveFamilyMemberRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminRemoveFamilyMember, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.AdminUpdateFamilyAccountNotesResponse>
      adminUpdateFamilyAccountNotes(
          $1.AdminUpdateFamilyAccountNotesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminUpdateFamilyAccountNotes, request,
        options: options);
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
    $addMethod($grpc.ServiceMethod<$1.GetMyInvitationHistoryRequest,
            $1.GetMyInvitationHistoryResponse>(
        'GetMyInvitationHistory',
        getMyInvitationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetMyInvitationHistoryRequest.fromBuffer(value),
        ($1.GetMyInvitationHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetSentInvitationsRequest,
            $1.GetSentInvitationsResponse>(
        'GetSentInvitations',
        getSentInvitations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetSentInvitationsRequest.fromBuffer(value),
        ($1.GetSentInvitationsResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$1.LeaveFamilyAccountRequest,
            $1.LeaveFamilyAccountResponse>(
        'LeaveFamilyAccount',
        leaveFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.LeaveFamilyAccountRequest.fromBuffer(value),
        ($1.LeaveFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ProcessMemberContributionRequest,
            $1.ProcessMemberContributionResponse>(
        'ProcessMemberContribution',
        processMemberContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ProcessMemberContributionRequest.fromBuffer(value),
        ($1.ProcessMemberContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SetupFamilyAccountRequest,
            $1.SetupFamilyAccountResponse>(
        'SetupFamilyAccount',
        setupFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SetupFamilyAccountRequest.fromBuffer(value),
        ($1.SetupFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateFundDistributionModeRequest,
            $1.UpdateFundDistributionModeResponse>(
        'UpdateFundDistributionMode',
        updateFundDistributionMode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateFundDistributionModeRequest.fromBuffer(value),
        ($1.UpdateFundDistributionModeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AdminListFamilyAccountsRequest,
            $1.AdminListFamilyAccountsResponse>(
        'AdminListFamilyAccounts',
        adminListFamilyAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AdminListFamilyAccountsRequest.fromBuffer(value),
        ($1.AdminListFamilyAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AdminGetFamilyAccountRequest,
            $1.AdminGetFamilyAccountResponse>(
        'AdminGetFamilyAccount',
        adminGetFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AdminGetFamilyAccountRequest.fromBuffer(value),
        ($1.AdminGetFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AdminFreezeFamilyAccountRequest,
            $1.AdminFreezeFamilyAccountResponse>(
        'AdminFreezeFamilyAccount',
        adminFreezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AdminFreezeFamilyAccountRequest.fromBuffer(value),
        ($1.AdminFreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AdminUnfreezeFamilyAccountRequest,
            $1.AdminUnfreezeFamilyAccountResponse>(
        'AdminUnfreezeFamilyAccount',
        adminUnfreezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AdminUnfreezeFamilyAccountRequest.fromBuffer(value),
        ($1.AdminUnfreezeFamilyAccountResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AdminDeleteFamilyAccountRequest,
            $1.AdminDeleteFamilyAccountResponse>(
        'AdminDeleteFamilyAccount',
        adminDeleteFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AdminDeleteFamilyAccountRequest.fromBuffer(value),
        ($1.AdminDeleteFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AdminForceAllocateFundsRequest,
            $1.AdminForceAllocateFundsResponse>(
        'AdminForceAllocateFunds',
        adminForceAllocateFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AdminForceAllocateFundsRequest.fromBuffer(value),
        ($1.AdminForceAllocateFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AdminRemoveFamilyMemberRequest,
            $1.AdminRemoveFamilyMemberResponse>(
        'AdminRemoveFamilyMember',
        adminRemoveFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AdminRemoveFamilyMemberRequest.fromBuffer(value),
        ($1.AdminRemoveFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AdminUpdateFamilyAccountNotesRequest,
            $1.AdminUpdateFamilyAccountNotesResponse>(
        'AdminUpdateFamilyAccountNotes',
        adminUpdateFamilyAccountNotes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AdminUpdateFamilyAccountNotesRequest.fromBuffer(value),
        ($1.AdminUpdateFamilyAccountNotesResponse value) =>
            value.writeToBuffer()));
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

  $async.Future<$1.GetMyInvitationHistoryResponse> getMyInvitationHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetMyInvitationHistoryRequest> request) async {
    return getMyInvitationHistory(call, await request);
  }

  $async.Future<$1.GetSentInvitationsResponse> getSentInvitations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetSentInvitationsRequest> request) async {
    return getSentInvitations(call, await request);
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

  $async.Future<$1.LeaveFamilyAccountResponse> leaveFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.LeaveFamilyAccountRequest> request) async {
    return leaveFamilyAccount(call, await request);
  }

  $async.Future<$1.ProcessMemberContributionResponse>
      processMemberContribution_Pre($grpc.ServiceCall call,
          $async.Future<$1.ProcessMemberContributionRequest> request) async {
    return processMemberContribution(call, await request);
  }

  $async.Future<$1.SetupFamilyAccountResponse> setupFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SetupFamilyAccountRequest> request) async {
    return setupFamilyAccount(call, await request);
  }

  $async.Future<$1.UpdateFundDistributionModeResponse>
      updateFundDistributionMode_Pre($grpc.ServiceCall call,
          $async.Future<$1.UpdateFundDistributionModeRequest> request) async {
    return updateFundDistributionMode(call, await request);
  }

  $async.Future<$1.AdminListFamilyAccountsResponse> adminListFamilyAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AdminListFamilyAccountsRequest> request) async {
    return adminListFamilyAccounts(call, await request);
  }

  $async.Future<$1.AdminGetFamilyAccountResponse> adminGetFamilyAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AdminGetFamilyAccountRequest> request) async {
    return adminGetFamilyAccount(call, await request);
  }

  $async.Future<$1.AdminFreezeFamilyAccountResponse>
      adminFreezeFamilyAccount_Pre($grpc.ServiceCall call,
          $async.Future<$1.AdminFreezeFamilyAccountRequest> request) async {
    return adminFreezeFamilyAccount(call, await request);
  }

  $async.Future<$1.AdminUnfreezeFamilyAccountResponse>
      adminUnfreezeFamilyAccount_Pre($grpc.ServiceCall call,
          $async.Future<$1.AdminUnfreezeFamilyAccountRequest> request) async {
    return adminUnfreezeFamilyAccount(call, await request);
  }

  $async.Future<$1.AdminDeleteFamilyAccountResponse>
      adminDeleteFamilyAccount_Pre($grpc.ServiceCall call,
          $async.Future<$1.AdminDeleteFamilyAccountRequest> request) async {
    return adminDeleteFamilyAccount(call, await request);
  }

  $async.Future<$1.AdminForceAllocateFundsResponse> adminForceAllocateFunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AdminForceAllocateFundsRequest> request) async {
    return adminForceAllocateFunds(call, await request);
  }

  $async.Future<$1.AdminRemoveFamilyMemberResponse> adminRemoveFamilyMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AdminRemoveFamilyMemberRequest> request) async {
    return adminRemoveFamilyMember(call, await request);
  }

  $async.Future<$1.AdminUpdateFamilyAccountNotesResponse>
      adminUpdateFamilyAccountNotes_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.AdminUpdateFamilyAccountNotesRequest>
              request) async {
    return adminUpdateFamilyAccountNotes(call, await request);
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
  $async.Future<$1.GetMyInvitationHistoryResponse> getMyInvitationHistory(
      $grpc.ServiceCall call, $1.GetMyInvitationHistoryRequest request);
  $async.Future<$1.GetSentInvitationsResponse> getSentInvitations(
      $grpc.ServiceCall call, $1.GetSentInvitationsRequest request);
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
  $async.Future<$1.LeaveFamilyAccountResponse> leaveFamilyAccount(
      $grpc.ServiceCall call, $1.LeaveFamilyAccountRequest request);
  $async.Future<$1.ProcessMemberContributionResponse> processMemberContribution(
      $grpc.ServiceCall call, $1.ProcessMemberContributionRequest request);
  $async.Future<$1.SetupFamilyAccountResponse> setupFamilyAccount(
      $grpc.ServiceCall call, $1.SetupFamilyAccountRequest request);
  $async.Future<$1.UpdateFundDistributionModeResponse>
      updateFundDistributionMode(
          $grpc.ServiceCall call, $1.UpdateFundDistributionModeRequest request);
  $async.Future<$1.AdminListFamilyAccountsResponse> adminListFamilyAccounts(
      $grpc.ServiceCall call, $1.AdminListFamilyAccountsRequest request);
  $async.Future<$1.AdminGetFamilyAccountResponse> adminGetFamilyAccount(
      $grpc.ServiceCall call, $1.AdminGetFamilyAccountRequest request);
  $async.Future<$1.AdminFreezeFamilyAccountResponse> adminFreezeFamilyAccount(
      $grpc.ServiceCall call, $1.AdminFreezeFamilyAccountRequest request);
  $async.Future<$1.AdminUnfreezeFamilyAccountResponse>
      adminUnfreezeFamilyAccount(
          $grpc.ServiceCall call, $1.AdminUnfreezeFamilyAccountRequest request);
  $async.Future<$1.AdminDeleteFamilyAccountResponse> adminDeleteFamilyAccount(
      $grpc.ServiceCall call, $1.AdminDeleteFamilyAccountRequest request);
  $async.Future<$1.AdminForceAllocateFundsResponse> adminForceAllocateFunds(
      $grpc.ServiceCall call, $1.AdminForceAllocateFundsRequest request);
  $async.Future<$1.AdminRemoveFamilyMemberResponse> adminRemoveFamilyMember(
      $grpc.ServiceCall call, $1.AdminRemoveFamilyMemberRequest request);
  $async.Future<$1.AdminUpdateFamilyAccountNotesResponse>
      adminUpdateFamilyAccountNotes($grpc.ServiceCall call,
          $1.AdminUpdateFamilyAccountNotesRequest request);
}
