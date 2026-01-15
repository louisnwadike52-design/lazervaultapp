///
//  Generated code. Do not modify.
//  source: financial-products.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'financial-products.pb.dart' as $0;
export 'financial-products.pb.dart';

class FinancialProductsServiceClient extends $grpc.Client {
  static final _$createGroupAccount = $grpc.ClientMethod<
          $0.CreateGroupAccountRequest, $0.CreateGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/CreateGroupAccount',
      ($0.CreateGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateGroupAccountResponse.fromBuffer(value));
  static final _$getGroupAccounts = $grpc.ClientMethod<
          $0.GetGroupAccountsRequest, $0.GetGroupAccountsResponse>(
      '/financialproducts.FinancialProductsService/GetGroupAccounts',
      ($0.GetGroupAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetGroupAccountsResponse.fromBuffer(value));
  static final _$getGroupAccount =
      $grpc.ClientMethod<$0.GetGroupAccountRequest, $0.GetGroupAccountResponse>(
          '/financialproducts.FinancialProductsService/GetGroupAccount',
          ($0.GetGroupAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetGroupAccountResponse.fromBuffer(value));
  static final _$addGroupMember =
      $grpc.ClientMethod<$0.AddGroupMemberRequest, $0.AddGroupMemberResponse>(
          '/financialproducts.FinancialProductsService/AddGroupMember',
          ($0.AddGroupMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AddGroupMemberResponse.fromBuffer(value));
  static final _$removeGroupMember = $grpc.ClientMethod<
          $0.RemoveGroupMemberRequest, $0.RemoveGroupMemberResponse>(
      '/financialproducts.FinancialProductsService/RemoveGroupMember',
      ($0.RemoveGroupMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RemoveGroupMemberResponse.fromBuffer(value));
  static final _$contributeToGroup = $grpc.ClientMethod<
          $0.ContributeToGroupRequest, $0.ContributeToGroupResponse>(
      '/financialproducts.FinancialProductsService/ContributeToGroup',
      ($0.ContributeToGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ContributeToGroupResponse.fromBuffer(value));
  static final _$withdrawFromGroup = $grpc.ClientMethod<
          $0.WithdrawFromGroupRequest, $0.WithdrawFromGroupResponse>(
      '/financialproducts.FinancialProductsService/WithdrawFromGroup',
      ($0.WithdrawFromGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.WithdrawFromGroupResponse.fromBuffer(value));
  static final _$closeGroupAccount = $grpc.ClientMethod<
          $0.CloseGroupAccountRequest, $0.CloseGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/CloseGroupAccount',
      ($0.CloseGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CloseGroupAccountResponse.fromBuffer(value));
  static final _$buyInsurance =
      $grpc.ClientMethod<$0.BuyInsuranceRequest, $0.BuyInsuranceResponse>(
          '/financialproducts.FinancialProductsService/BuyInsurance',
          ($0.BuyInsuranceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BuyInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePolicies = $grpc.ClientMethod<
          $0.GetInsurancePoliciesRequest, $0.GetInsurancePoliciesResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePolicies',
      ($0.GetInsurancePoliciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsurancePoliciesResponse.fromBuffer(value));
  static final _$getInsurancePolicy = $grpc.ClientMethod<
          $0.GetInsurancePolicyRequest, $0.GetInsurancePolicyResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePolicy',
      ($0.GetInsurancePolicyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsurancePolicyResponse.fromBuffer(value));
  static final _$makeInsuranceClaim = $grpc.ClientMethod<
          $0.MakeInsuranceClaimRequest, $0.MakeInsuranceClaimResponse>(
      '/financialproducts.FinancialProductsService/MakeInsuranceClaim',
      ($0.MakeInsuranceClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.MakeInsuranceClaimResponse.fromBuffer(value));
  static final _$cancelInsurance =
      $grpc.ClientMethod<$0.CancelInsuranceRequest, $0.CancelInsuranceResponse>(
          '/financialproducts.FinancialProductsService/CancelInsurance',
          ($0.CancelInsuranceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CancelInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePlans = $grpc.ClientMethod<
          $0.GetInsurancePlansRequest, $0.GetInsurancePlansResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePlans',
      ($0.GetInsurancePlansRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsurancePlansResponse.fromBuffer(value));
  static final _$createCrowdfund =
      $grpc.ClientMethod<$0.CreateCrowdfundRequest, $0.CreateCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/CreateCrowdfund',
          ($0.CreateCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfunds =
      $grpc.ClientMethod<$0.GetCrowdfundsRequest, $0.GetCrowdfundsResponse>(
          '/financialproducts.FinancialProductsService/GetCrowdfunds',
          ($0.GetCrowdfundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetCrowdfundsResponse.fromBuffer(value));
  static final _$getCrowdfund =
      $grpc.ClientMethod<$0.GetCrowdfundRequest, $0.GetCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/GetCrowdfund',
          ($0.GetCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetCrowdfundResponse.fromBuffer(value));
  static final _$contributeToCrowdfund = $grpc.ClientMethod<
          $0.ContributeToCrowdfundRequest, $0.ContributeToCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/ContributeToCrowdfund',
      ($0.ContributeToCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ContributeToCrowdfundResponse.fromBuffer(value));
  static final _$withdrawFromCrowdfund = $grpc.ClientMethod<
          $0.WithdrawFromCrowdfundRequest, $0.WithdrawFromCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/WithdrawFromCrowdfund',
      ($0.WithdrawFromCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.WithdrawFromCrowdfundResponse.fromBuffer(value));
  static final _$closeCrowdfund =
      $grpc.ClientMethod<$0.CloseCrowdfundRequest, $0.CloseCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/CloseCrowdfund',
          ($0.CloseCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CloseCrowdfundResponse.fromBuffer(value));

  FinancialProductsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateGroupAccountResponse> createGroupAccount(
      $0.CreateGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupAccountsResponse> getGroupAccounts(
      $0.GetGroupAccountsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupAccountResponse> getGroupAccount(
      $0.GetGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddGroupMemberResponse> addGroupMember(
      $0.AddGroupMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addGroupMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.RemoveGroupMemberResponse> removeGroupMember(
      $0.RemoveGroupMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeGroupMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.ContributeToGroupResponse> contributeToGroup(
      $0.ContributeToGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$contributeToGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawFromGroupResponse> withdrawFromGroup(
      $0.WithdrawFromGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.CloseGroupAccountResponse> closeGroupAccount(
      $0.CloseGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyInsuranceResponse> buyInsurance(
      $0.BuyInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePoliciesResponse> getInsurancePolicies(
      $0.GetInsurancePoliciesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePolicies, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePolicyResponse> getInsurancePolicy(
      $0.GetInsurancePolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePolicy, request, options: options);
  }

  $grpc.ResponseFuture<$0.MakeInsuranceClaimResponse> makeInsuranceClaim(
      $0.MakeInsuranceClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makeInsuranceClaim, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelInsuranceResponse> cancelInsurance(
      $0.CancelInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePlansResponse> getInsurancePlans(
      $0.GetInsurancePlansRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePlans, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateCrowdfundResponse> createCrowdfund(
      $0.CreateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundsResponse> getCrowdfunds(
      $0.GetCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundResponse> getCrowdfund(
      $0.GetCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.ContributeToCrowdfundResponse> contributeToCrowdfund(
      $0.ContributeToCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$contributeToCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund(
      $0.WithdrawFromCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.CloseCrowdfundResponse> closeCrowdfund(
      $0.CloseCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeCrowdfund, request, options: options);
  }
}

abstract class FinancialProductsServiceBase extends $grpc.Service {
  $core.String get $name => 'financialproducts.FinancialProductsService';

  FinancialProductsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateGroupAccountRequest,
            $0.CreateGroupAccountResponse>(
        'CreateGroupAccount',
        createGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateGroupAccountRequest.fromBuffer(value),
        ($0.CreateGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGroupAccountsRequest,
            $0.GetGroupAccountsResponse>(
        'GetGroupAccounts',
        getGroupAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetGroupAccountsRequest.fromBuffer(value),
        ($0.GetGroupAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGroupAccountRequest,
            $0.GetGroupAccountResponse>(
        'GetGroupAccount',
        getGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetGroupAccountRequest.fromBuffer(value),
        ($0.GetGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddGroupMemberRequest,
            $0.AddGroupMemberResponse>(
        'AddGroupMember',
        addGroupMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AddGroupMemberRequest.fromBuffer(value),
        ($0.AddGroupMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveGroupMemberRequest,
            $0.RemoveGroupMemberResponse>(
        'RemoveGroupMember',
        removeGroupMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RemoveGroupMemberRequest.fromBuffer(value),
        ($0.RemoveGroupMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ContributeToGroupRequest,
            $0.ContributeToGroupResponse>(
        'ContributeToGroup',
        contributeToGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ContributeToGroupRequest.fromBuffer(value),
        ($0.ContributeToGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawFromGroupRequest,
            $0.WithdrawFromGroupResponse>(
        'WithdrawFromGroup',
        withdrawFromGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WithdrawFromGroupRequest.fromBuffer(value),
        ($0.WithdrawFromGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CloseGroupAccountRequest,
            $0.CloseGroupAccountResponse>(
        'CloseGroupAccount',
        closeGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CloseGroupAccountRequest.fromBuffer(value),
        ($0.CloseGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.BuyInsuranceRequest, $0.BuyInsuranceResponse>(
            'BuyInsurance',
            buyInsurance_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.BuyInsuranceRequest.fromBuffer(value),
            ($0.BuyInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePoliciesRequest,
            $0.GetInsurancePoliciesResponse>(
        'GetInsurancePolicies',
        getInsurancePolicies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsurancePoliciesRequest.fromBuffer(value),
        ($0.GetInsurancePoliciesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePolicyRequest,
            $0.GetInsurancePolicyResponse>(
        'GetInsurancePolicy',
        getInsurancePolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsurancePolicyRequest.fromBuffer(value),
        ($0.GetInsurancePolicyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MakeInsuranceClaimRequest,
            $0.MakeInsuranceClaimResponse>(
        'MakeInsuranceClaim',
        makeInsuranceClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MakeInsuranceClaimRequest.fromBuffer(value),
        ($0.MakeInsuranceClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelInsuranceRequest,
            $0.CancelInsuranceResponse>(
        'CancelInsurance',
        cancelInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelInsuranceRequest.fromBuffer(value),
        ($0.CancelInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePlansRequest,
            $0.GetInsurancePlansResponse>(
        'GetInsurancePlans',
        getInsurancePlans_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsurancePlansRequest.fromBuffer(value),
        ($0.GetInsurancePlansResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateCrowdfundRequest,
            $0.CreateCrowdfundResponse>(
        'CreateCrowdfund',
        createCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateCrowdfundRequest.fromBuffer(value),
        ($0.CreateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetCrowdfundsRequest, $0.GetCrowdfundsResponse>(
            'GetCrowdfunds',
            getCrowdfunds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetCrowdfundsRequest.fromBuffer(value),
            ($0.GetCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetCrowdfundRequest, $0.GetCrowdfundResponse>(
            'GetCrowdfund',
            getCrowdfund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetCrowdfundRequest.fromBuffer(value),
            ($0.GetCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ContributeToCrowdfundRequest,
            $0.ContributeToCrowdfundResponse>(
        'ContributeToCrowdfund',
        contributeToCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ContributeToCrowdfundRequest.fromBuffer(value),
        ($0.ContributeToCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawFromCrowdfundRequest,
            $0.WithdrawFromCrowdfundResponse>(
        'WithdrawFromCrowdfund',
        withdrawFromCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WithdrawFromCrowdfundRequest.fromBuffer(value),
        ($0.WithdrawFromCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CloseCrowdfundRequest,
            $0.CloseCrowdfundResponse>(
        'CloseCrowdfund',
        closeCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CloseCrowdfundRequest.fromBuffer(value),
        ($0.CloseCrowdfundResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateGroupAccountResponse> createGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateGroupAccountRequest> request) async {
    return createGroupAccount(call, await request);
  }

  $async.Future<$0.GetGroupAccountsResponse> getGroupAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetGroupAccountsRequest> request) async {
    return getGroupAccounts(call, await request);
  }

  $async.Future<$0.GetGroupAccountResponse> getGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetGroupAccountRequest> request) async {
    return getGroupAccount(call, await request);
  }

  $async.Future<$0.AddGroupMemberResponse> addGroupMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AddGroupMemberRequest> request) async {
    return addGroupMember(call, await request);
  }

  $async.Future<$0.RemoveGroupMemberResponse> removeGroupMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RemoveGroupMemberRequest> request) async {
    return removeGroupMember(call, await request);
  }

  $async.Future<$0.ContributeToGroupResponse> contributeToGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ContributeToGroupRequest> request) async {
    return contributeToGroup(call, await request);
  }

  $async.Future<$0.WithdrawFromGroupResponse> withdrawFromGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.WithdrawFromGroupRequest> request) async {
    return withdrawFromGroup(call, await request);
  }

  $async.Future<$0.CloseGroupAccountResponse> closeGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CloseGroupAccountRequest> request) async {
    return closeGroupAccount(call, await request);
  }

  $async.Future<$0.BuyInsuranceResponse> buyInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.BuyInsuranceRequest> request) async {
    return buyInsurance(call, await request);
  }

  $async.Future<$0.GetInsurancePoliciesResponse> getInsurancePolicies_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsurancePoliciesRequest> request) async {
    return getInsurancePolicies(call, await request);
  }

  $async.Future<$0.GetInsurancePolicyResponse> getInsurancePolicy_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsurancePolicyRequest> request) async {
    return getInsurancePolicy(call, await request);
  }

  $async.Future<$0.MakeInsuranceClaimResponse> makeInsuranceClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.MakeInsuranceClaimRequest> request) async {
    return makeInsuranceClaim(call, await request);
  }

  $async.Future<$0.CancelInsuranceResponse> cancelInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CancelInsuranceRequest> request) async {
    return cancelInsurance(call, await request);
  }

  $async.Future<$0.GetInsurancePlansResponse> getInsurancePlans_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsurancePlansRequest> request) async {
    return getInsurancePlans(call, await request);
  }

  $async.Future<$0.CreateCrowdfundResponse> createCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateCrowdfundRequest> request) async {
    return createCrowdfund(call, await request);
  }

  $async.Future<$0.GetCrowdfundsResponse> getCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCrowdfundsRequest> request) async {
    return getCrowdfunds(call, await request);
  }

  $async.Future<$0.GetCrowdfundResponse> getCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCrowdfundRequest> request) async {
    return getCrowdfund(call, await request);
  }

  $async.Future<$0.ContributeToCrowdfundResponse> contributeToCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ContributeToCrowdfundRequest> request) async {
    return contributeToCrowdfund(call, await request);
  }

  $async.Future<$0.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.WithdrawFromCrowdfundRequest> request) async {
    return withdrawFromCrowdfund(call, await request);
  }

  $async.Future<$0.CloseCrowdfundResponse> closeCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CloseCrowdfundRequest> request) async {
    return closeCrowdfund(call, await request);
  }

  $async.Future<$0.CreateGroupAccountResponse> createGroupAccount(
      $grpc.ServiceCall call, $0.CreateGroupAccountRequest request);
  $async.Future<$0.GetGroupAccountsResponse> getGroupAccounts(
      $grpc.ServiceCall call, $0.GetGroupAccountsRequest request);
  $async.Future<$0.GetGroupAccountResponse> getGroupAccount(
      $grpc.ServiceCall call, $0.GetGroupAccountRequest request);
  $async.Future<$0.AddGroupMemberResponse> addGroupMember(
      $grpc.ServiceCall call, $0.AddGroupMemberRequest request);
  $async.Future<$0.RemoveGroupMemberResponse> removeGroupMember(
      $grpc.ServiceCall call, $0.RemoveGroupMemberRequest request);
  $async.Future<$0.ContributeToGroupResponse> contributeToGroup(
      $grpc.ServiceCall call, $0.ContributeToGroupRequest request);
  $async.Future<$0.WithdrawFromGroupResponse> withdrawFromGroup(
      $grpc.ServiceCall call, $0.WithdrawFromGroupRequest request);
  $async.Future<$0.CloseGroupAccountResponse> closeGroupAccount(
      $grpc.ServiceCall call, $0.CloseGroupAccountRequest request);
  $async.Future<$0.BuyInsuranceResponse> buyInsurance(
      $grpc.ServiceCall call, $0.BuyInsuranceRequest request);
  $async.Future<$0.GetInsurancePoliciesResponse> getInsurancePolicies(
      $grpc.ServiceCall call, $0.GetInsurancePoliciesRequest request);
  $async.Future<$0.GetInsurancePolicyResponse> getInsurancePolicy(
      $grpc.ServiceCall call, $0.GetInsurancePolicyRequest request);
  $async.Future<$0.MakeInsuranceClaimResponse> makeInsuranceClaim(
      $grpc.ServiceCall call, $0.MakeInsuranceClaimRequest request);
  $async.Future<$0.CancelInsuranceResponse> cancelInsurance(
      $grpc.ServiceCall call, $0.CancelInsuranceRequest request);
  $async.Future<$0.GetInsurancePlansResponse> getInsurancePlans(
      $grpc.ServiceCall call, $0.GetInsurancePlansRequest request);
  $async.Future<$0.CreateCrowdfundResponse> createCrowdfund(
      $grpc.ServiceCall call, $0.CreateCrowdfundRequest request);
  $async.Future<$0.GetCrowdfundsResponse> getCrowdfunds(
      $grpc.ServiceCall call, $0.GetCrowdfundsRequest request);
  $async.Future<$0.GetCrowdfundResponse> getCrowdfund(
      $grpc.ServiceCall call, $0.GetCrowdfundRequest request);
  $async.Future<$0.ContributeToCrowdfundResponse> contributeToCrowdfund(
      $grpc.ServiceCall call, $0.ContributeToCrowdfundRequest request);
  $async.Future<$0.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund(
      $grpc.ServiceCall call, $0.WithdrawFromCrowdfundRequest request);
  $async.Future<$0.CloseCrowdfundResponse> closeCrowdfund(
      $grpc.ServiceCall call, $0.CloseCrowdfundRequest request);
}
