//
//  Generated code. Do not modify.
//  source: financial-products.proto
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

import 'financial-products.pb.dart' as $0;

export 'financial-products.pb.dart';

@$pb.GrpcServiceName('financialproducts.FinancialProductsService')
class FinancialProductsServiceClient extends $grpc.Client {
  static final _$createGroupAccount = $grpc.ClientMethod<$0.CreateGroupAccountRequest, $0.CreateGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/CreateGroupAccount',
      ($0.CreateGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateGroupAccountResponse.fromBuffer(value));
  static final _$getGroupAccounts = $grpc.ClientMethod<$0.GetGroupAccountsRequest, $0.GetGroupAccountsResponse>(
      '/financialproducts.FinancialProductsService/GetGroupAccounts',
      ($0.GetGroupAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetGroupAccountsResponse.fromBuffer(value));
  static final _$getGroupAccount = $grpc.ClientMethod<$0.GetGroupAccountRequest, $0.GetGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/GetGroupAccount',
      ($0.GetGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetGroupAccountResponse.fromBuffer(value));
  static final _$addGroupMember = $grpc.ClientMethod<$0.AddGroupMemberRequest, $0.AddGroupMemberResponse>(
      '/financialproducts.FinancialProductsService/AddGroupMember',
      ($0.AddGroupMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AddGroupMemberResponse.fromBuffer(value));
  static final _$removeGroupMember = $grpc.ClientMethod<$0.RemoveGroupMemberRequest, $0.RemoveGroupMemberResponse>(
      '/financialproducts.FinancialProductsService/RemoveGroupMember',
      ($0.RemoveGroupMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RemoveGroupMemberResponse.fromBuffer(value));
  static final _$contributeToGroup = $grpc.ClientMethod<$0.ContributeToGroupRequest, $0.ContributeToGroupResponse>(
      '/financialproducts.FinancialProductsService/ContributeToGroup',
      ($0.ContributeToGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ContributeToGroupResponse.fromBuffer(value));
  static final _$withdrawFromGroup = $grpc.ClientMethod<$0.WithdrawFromGroupRequest, $0.WithdrawFromGroupResponse>(
      '/financialproducts.FinancialProductsService/WithdrawFromGroup',
      ($0.WithdrawFromGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.WithdrawFromGroupResponse.fromBuffer(value));
  static final _$closeGroupAccount = $grpc.ClientMethod<$0.CloseGroupAccountRequest, $0.CloseGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/CloseGroupAccount',
      ($0.CloseGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CloseGroupAccountResponse.fromBuffer(value));
  static final _$buyInsurance = $grpc.ClientMethod<$0.BuyInsuranceRequest, $0.BuyInsuranceResponse>(
      '/financialproducts.FinancialProductsService/BuyInsurance',
      ($0.BuyInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.BuyInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePolicies = $grpc.ClientMethod<$0.GetInsurancePoliciesRequest, $0.GetInsurancePoliciesResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePolicies',
      ($0.GetInsurancePoliciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsurancePoliciesResponse.fromBuffer(value));
  static final _$getInsurancePolicy = $grpc.ClientMethod<$0.GetInsurancePolicyRequest, $0.GetInsurancePolicyResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePolicy',
      ($0.GetInsurancePolicyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsurancePolicyResponse.fromBuffer(value));
  static final _$makeInsuranceClaim = $grpc.ClientMethod<$0.MakeInsuranceClaimRequest, $0.MakeInsuranceClaimResponse>(
      '/financialproducts.FinancialProductsService/MakeInsuranceClaim',
      ($0.MakeInsuranceClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MakeInsuranceClaimResponse.fromBuffer(value));
  static final _$cancelInsurance = $grpc.ClientMethod<$0.CancelInsuranceRequest, $0.CancelInsuranceResponse>(
      '/financialproducts.FinancialProductsService/CancelInsurance',
      ($0.CancelInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CancelInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePlans = $grpc.ClientMethod<$0.GetInsurancePlansRequest, $0.GetInsurancePlansResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePlans',
      ($0.GetInsurancePlansRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsurancePlansResponse.fromBuffer(value));
  static final _$createCrowdfund = $grpc.ClientMethod<$0.CreateCrowdfundRequest, $0.CreateCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/CreateCrowdfund',
      ($0.CreateCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfunds = $grpc.ClientMethod<$0.GetCrowdfundsRequest, $0.GetCrowdfundsResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfunds',
      ($0.GetCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCrowdfundsResponse.fromBuffer(value));
  static final _$getCrowdfund = $grpc.ClientMethod<$0.GetCrowdfundRequest, $0.GetCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfund',
      ($0.GetCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCrowdfundResponse.fromBuffer(value));
  static final _$contributeToCrowdfund = $grpc.ClientMethod<$0.ContributeToCrowdfundRequest, $0.ContributeToCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/ContributeToCrowdfund',
      ($0.ContributeToCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ContributeToCrowdfundResponse.fromBuffer(value));
  static final _$withdrawFromCrowdfund = $grpc.ClientMethod<$0.WithdrawFromCrowdfundRequest, $0.WithdrawFromCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/WithdrawFromCrowdfund',
      ($0.WithdrawFromCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.WithdrawFromCrowdfundResponse.fromBuffer(value));
  static final _$closeCrowdfund = $grpc.ClientMethod<$0.CloseCrowdfundRequest, $0.CloseCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/CloseCrowdfund',
      ($0.CloseCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CloseCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfundStatistics = $grpc.ClientMethod<$0.GetCrowdfundStatisticsRequest, $0.GetCrowdfundStatisticsResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundStatistics',
      ($0.GetCrowdfundStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCrowdfundStatisticsResponse.fromBuffer(value));
  static final _$searchCrowdfunds = $grpc.ClientMethod<$0.SearchCrowdfundsRequest, $0.SearchCrowdfundsResponse>(
      '/financialproducts.FinancialProductsService/SearchCrowdfunds',
      ($0.SearchCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SearchCrowdfundsResponse.fromBuffer(value));
  static final _$updateCrowdfund = $grpc.ClientMethod<$0.UpdateCrowdfundRequest, $0.UpdateCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/UpdateCrowdfund',
      ($0.UpdateCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateCrowdfundResponse.fromBuffer(value));
  static final _$deleteCrowdfund = $grpc.ClientMethod<$0.DeleteCrowdfundRequest, $0.DeleteCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/DeleteCrowdfund',
      ($0.DeleteCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfundDonations = $grpc.ClientMethod<$0.GetCrowdfundDonationsRequest, $0.GetCrowdfundDonationsResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundDonations',
      ($0.GetCrowdfundDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCrowdfundDonationsResponse.fromBuffer(value));
  static final _$getUserDonations = $grpc.ClientMethod<$0.GetUserDonationsRequest, $0.GetUserDonationsResponse>(
      '/financialproducts.FinancialProductsService/GetUserDonations',
      ($0.GetUserDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserDonationsResponse.fromBuffer(value));
  static final _$generateDonationReceipt = $grpc.ClientMethod<$0.GenerateDonationReceiptRequest, $0.GenerateDonationReceiptResponse>(
      '/financialproducts.FinancialProductsService/GenerateDonationReceipt',
      ($0.GenerateDonationReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GenerateDonationReceiptResponse.fromBuffer(value));
  static final _$getUserCrowdfundReceipts = $grpc.ClientMethod<$0.GetUserCrowdfundReceiptsRequest, $0.GetUserCrowdfundReceiptsResponse>(
      '/financialproducts.FinancialProductsService/GetUserCrowdfundReceipts',
      ($0.GetUserCrowdfundReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserCrowdfundReceiptsResponse.fromBuffer(value));
  static final _$connectNotificationChannel = $grpc.ClientMethod<$0.ConnectNotificationChannelRequest, $0.ConnectNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/ConnectNotificationChannel',
      ($0.ConnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ConnectNotificationChannelResponse.fromBuffer(value));
  static final _$disconnectNotificationChannel = $grpc.ClientMethod<$0.DisconnectNotificationChannelRequest, $0.DisconnectNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/DisconnectNotificationChannel',
      ($0.DisconnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DisconnectNotificationChannelResponse.fromBuffer(value));
  static final _$getNotificationChannels = $grpc.ClientMethod<$0.GetNotificationChannelsRequest, $0.GetNotificationChannelsResponse>(
      '/financialproducts.FinancialProductsService/GetNotificationChannels',
      ($0.GetNotificationChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetNotificationChannelsResponse.fromBuffer(value));
  static final _$updateNotificationChannel = $grpc.ClientMethod<$0.UpdateNotificationChannelRequest, $0.UpdateNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/UpdateNotificationChannel',
      ($0.UpdateNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateNotificationChannelResponse.fromBuffer(value));
  static final _$testNotificationChannel = $grpc.ClientMethod<$0.TestNotificationChannelRequest, $0.TestNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/TestNotificationChannel',
      ($0.TestNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TestNotificationChannelResponse.fromBuffer(value));
  static final _$getTelegramBotInfo = $grpc.ClientMethod<$0.GetTelegramBotInfoRequest, $0.GetTelegramBotInfoResponse>(
      '/financialproducts.FinancialProductsService/GetTelegramBotInfo',
      ($0.GetTelegramBotInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTelegramBotInfoResponse.fromBuffer(value));
  static final _$verifyTelegramChannel = $grpc.ClientMethod<$0.VerifyTelegramChannelRequest, $0.VerifyTelegramChannelResponse>(
      '/financialproducts.FinancialProductsService/VerifyTelegramChannel',
      ($0.VerifyTelegramChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyTelegramChannelResponse.fromBuffer(value));
  static final _$getNotificationHistory = $grpc.ClientMethod<$0.GetNotificationHistoryRequest, $0.GetNotificationHistoryResponse>(
      '/financialproducts.FinancialProductsService/GetNotificationHistory',
      ($0.GetNotificationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetNotificationHistoryResponse.fromBuffer(value));

  FinancialProductsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateGroupAccountResponse> createGroupAccount($0.CreateGroupAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupAccountsResponse> getGroupAccounts($0.GetGroupAccountsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupAccountResponse> getGroupAccount($0.GetGroupAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddGroupMemberResponse> addGroupMember($0.AddGroupMemberRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addGroupMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.RemoveGroupMemberResponse> removeGroupMember($0.RemoveGroupMemberRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeGroupMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.ContributeToGroupResponse> contributeToGroup($0.ContributeToGroupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$contributeToGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawFromGroupResponse> withdrawFromGroup($0.WithdrawFromGroupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.CloseGroupAccountResponse> closeGroupAccount($0.CloseGroupAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyInsuranceResponse> buyInsurance($0.BuyInsuranceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePoliciesResponse> getInsurancePolicies($0.GetInsurancePoliciesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePolicies, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePolicyResponse> getInsurancePolicy($0.GetInsurancePolicyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePolicy, request, options: options);
  }

  $grpc.ResponseFuture<$0.MakeInsuranceClaimResponse> makeInsuranceClaim($0.MakeInsuranceClaimRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makeInsuranceClaim, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelInsuranceResponse> cancelInsurance($0.CancelInsuranceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePlansResponse> getInsurancePlans($0.GetInsurancePlansRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePlans, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateCrowdfundResponse> createCrowdfund($0.CreateCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundsResponse> getCrowdfunds($0.GetCrowdfundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundResponse> getCrowdfund($0.GetCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.ContributeToCrowdfundResponse> contributeToCrowdfund($0.ContributeToCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$contributeToCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund($0.WithdrawFromCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.CloseCrowdfundResponse> closeCrowdfund($0.CloseCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundStatisticsResponse> getCrowdfundStatistics($0.GetCrowdfundStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchCrowdfundsResponse> searchCrowdfunds($0.SearchCrowdfundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateCrowdfundResponse> updateCrowdfund($0.UpdateCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteCrowdfundResponse> deleteCrowdfund($0.DeleteCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundDonationsResponse> getCrowdfundDonations($0.GetCrowdfundDonationsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundDonations, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserDonationsResponse> getUserDonations($0.GetUserDonationsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDonations, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateDonationReceiptResponse> generateDonationReceipt($0.GenerateDonationReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateDonationReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts($0.GetUserCrowdfundReceiptsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCrowdfundReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$0.ConnectNotificationChannelResponse> connectNotificationChannel($0.ConnectNotificationChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connectNotificationChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.DisconnectNotificationChannelResponse> disconnectNotificationChannel($0.DisconnectNotificationChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectNotificationChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetNotificationChannelsResponse> getNotificationChannels($0.GetNotificationChannelsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationChannels, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateNotificationChannelResponse> updateNotificationChannel($0.UpdateNotificationChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateNotificationChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.TestNotificationChannelResponse> testNotificationChannel($0.TestNotificationChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$testNotificationChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTelegramBotInfoResponse> getTelegramBotInfo($0.GetTelegramBotInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTelegramBotInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyTelegramChannelResponse> verifyTelegramChannel($0.VerifyTelegramChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTelegramChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetNotificationHistoryResponse> getNotificationHistory($0.GetNotificationHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationHistory, request, options: options);
  }
}

@$pb.GrpcServiceName('financialproducts.FinancialProductsService')
abstract class FinancialProductsServiceBase extends $grpc.Service {
  $core.String get $name => 'financialproducts.FinancialProductsService';

  FinancialProductsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateGroupAccountRequest, $0.CreateGroupAccountResponse>(
        'CreateGroupAccount',
        createGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateGroupAccountRequest.fromBuffer(value),
        ($0.CreateGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGroupAccountsRequest, $0.GetGroupAccountsResponse>(
        'GetGroupAccounts',
        getGroupAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetGroupAccountsRequest.fromBuffer(value),
        ($0.GetGroupAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGroupAccountRequest, $0.GetGroupAccountResponse>(
        'GetGroupAccount',
        getGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetGroupAccountRequest.fromBuffer(value),
        ($0.GetGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddGroupMemberRequest, $0.AddGroupMemberResponse>(
        'AddGroupMember',
        addGroupMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddGroupMemberRequest.fromBuffer(value),
        ($0.AddGroupMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveGroupMemberRequest, $0.RemoveGroupMemberResponse>(
        'RemoveGroupMember',
        removeGroupMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RemoveGroupMemberRequest.fromBuffer(value),
        ($0.RemoveGroupMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ContributeToGroupRequest, $0.ContributeToGroupResponse>(
        'ContributeToGroup',
        contributeToGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ContributeToGroupRequest.fromBuffer(value),
        ($0.ContributeToGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawFromGroupRequest, $0.WithdrawFromGroupResponse>(
        'WithdrawFromGroup',
        withdrawFromGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WithdrawFromGroupRequest.fromBuffer(value),
        ($0.WithdrawFromGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CloseGroupAccountRequest, $0.CloseGroupAccountResponse>(
        'CloseGroupAccount',
        closeGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CloseGroupAccountRequest.fromBuffer(value),
        ($0.CloseGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyInsuranceRequest, $0.BuyInsuranceResponse>(
        'BuyInsurance',
        buyInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyInsuranceRequest.fromBuffer(value),
        ($0.BuyInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePoliciesRequest, $0.GetInsurancePoliciesResponse>(
        'GetInsurancePolicies',
        getInsurancePolicies_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsurancePoliciesRequest.fromBuffer(value),
        ($0.GetInsurancePoliciesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePolicyRequest, $0.GetInsurancePolicyResponse>(
        'GetInsurancePolicy',
        getInsurancePolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsurancePolicyRequest.fromBuffer(value),
        ($0.GetInsurancePolicyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MakeInsuranceClaimRequest, $0.MakeInsuranceClaimResponse>(
        'MakeInsuranceClaim',
        makeInsuranceClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MakeInsuranceClaimRequest.fromBuffer(value),
        ($0.MakeInsuranceClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelInsuranceRequest, $0.CancelInsuranceResponse>(
        'CancelInsurance',
        cancelInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CancelInsuranceRequest.fromBuffer(value),
        ($0.CancelInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePlansRequest, $0.GetInsurancePlansResponse>(
        'GetInsurancePlans',
        getInsurancePlans_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsurancePlansRequest.fromBuffer(value),
        ($0.GetInsurancePlansResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateCrowdfundRequest, $0.CreateCrowdfundResponse>(
        'CreateCrowdfund',
        createCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateCrowdfundRequest.fromBuffer(value),
        ($0.CreateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCrowdfundsRequest, $0.GetCrowdfundsResponse>(
        'GetCrowdfunds',
        getCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCrowdfundsRequest.fromBuffer(value),
        ($0.GetCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCrowdfundRequest, $0.GetCrowdfundResponse>(
        'GetCrowdfund',
        getCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCrowdfundRequest.fromBuffer(value),
        ($0.GetCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ContributeToCrowdfundRequest, $0.ContributeToCrowdfundResponse>(
        'ContributeToCrowdfund',
        contributeToCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ContributeToCrowdfundRequest.fromBuffer(value),
        ($0.ContributeToCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawFromCrowdfundRequest, $0.WithdrawFromCrowdfundResponse>(
        'WithdrawFromCrowdfund',
        withdrawFromCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WithdrawFromCrowdfundRequest.fromBuffer(value),
        ($0.WithdrawFromCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CloseCrowdfundRequest, $0.CloseCrowdfundResponse>(
        'CloseCrowdfund',
        closeCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CloseCrowdfundRequest.fromBuffer(value),
        ($0.CloseCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCrowdfundStatisticsRequest, $0.GetCrowdfundStatisticsResponse>(
        'GetCrowdfundStatistics',
        getCrowdfundStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCrowdfundStatisticsRequest.fromBuffer(value),
        ($0.GetCrowdfundStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchCrowdfundsRequest, $0.SearchCrowdfundsResponse>(
        'SearchCrowdfunds',
        searchCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchCrowdfundsRequest.fromBuffer(value),
        ($0.SearchCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCrowdfundRequest, $0.UpdateCrowdfundResponse>(
        'UpdateCrowdfund',
        updateCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateCrowdfundRequest.fromBuffer(value),
        ($0.UpdateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteCrowdfundRequest, $0.DeleteCrowdfundResponse>(
        'DeleteCrowdfund',
        deleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteCrowdfundRequest.fromBuffer(value),
        ($0.DeleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCrowdfundDonationsRequest, $0.GetCrowdfundDonationsResponse>(
        'GetCrowdfundDonations',
        getCrowdfundDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCrowdfundDonationsRequest.fromBuffer(value),
        ($0.GetCrowdfundDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserDonationsRequest, $0.GetUserDonationsResponse>(
        'GetUserDonations',
        getUserDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserDonationsRequest.fromBuffer(value),
        ($0.GetUserDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateDonationReceiptRequest, $0.GenerateDonationReceiptResponse>(
        'GenerateDonationReceipt',
        generateDonationReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GenerateDonationReceiptRequest.fromBuffer(value),
        ($0.GenerateDonationReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserCrowdfundReceiptsRequest, $0.GetUserCrowdfundReceiptsResponse>(
        'GetUserCrowdfundReceipts',
        getUserCrowdfundReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserCrowdfundReceiptsRequest.fromBuffer(value),
        ($0.GetUserCrowdfundReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConnectNotificationChannelRequest, $0.ConnectNotificationChannelResponse>(
        'ConnectNotificationChannel',
        connectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ConnectNotificationChannelRequest.fromBuffer(value),
        ($0.ConnectNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DisconnectNotificationChannelRequest, $0.DisconnectNotificationChannelResponse>(
        'DisconnectNotificationChannel',
        disconnectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DisconnectNotificationChannelRequest.fromBuffer(value),
        ($0.DisconnectNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetNotificationChannelsRequest, $0.GetNotificationChannelsResponse>(
        'GetNotificationChannels',
        getNotificationChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetNotificationChannelsRequest.fromBuffer(value),
        ($0.GetNotificationChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateNotificationChannelRequest, $0.UpdateNotificationChannelResponse>(
        'UpdateNotificationChannel',
        updateNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateNotificationChannelRequest.fromBuffer(value),
        ($0.UpdateNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TestNotificationChannelRequest, $0.TestNotificationChannelResponse>(
        'TestNotificationChannel',
        testNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TestNotificationChannelRequest.fromBuffer(value),
        ($0.TestNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTelegramBotInfoRequest, $0.GetTelegramBotInfoResponse>(
        'GetTelegramBotInfo',
        getTelegramBotInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTelegramBotInfoRequest.fromBuffer(value),
        ($0.GetTelegramBotInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyTelegramChannelRequest, $0.VerifyTelegramChannelResponse>(
        'VerifyTelegramChannel',
        verifyTelegramChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyTelegramChannelRequest.fromBuffer(value),
        ($0.VerifyTelegramChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetNotificationHistoryRequest, $0.GetNotificationHistoryResponse>(
        'GetNotificationHistory',
        getNotificationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetNotificationHistoryRequest.fromBuffer(value),
        ($0.GetNotificationHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateGroupAccountResponse> createGroupAccount_Pre($grpc.ServiceCall call, $async.Future<$0.CreateGroupAccountRequest> request) async {
    return createGroupAccount(call, await request);
  }

  $async.Future<$0.GetGroupAccountsResponse> getGroupAccounts_Pre($grpc.ServiceCall call, $async.Future<$0.GetGroupAccountsRequest> request) async {
    return getGroupAccounts(call, await request);
  }

  $async.Future<$0.GetGroupAccountResponse> getGroupAccount_Pre($grpc.ServiceCall call, $async.Future<$0.GetGroupAccountRequest> request) async {
    return getGroupAccount(call, await request);
  }

  $async.Future<$0.AddGroupMemberResponse> addGroupMember_Pre($grpc.ServiceCall call, $async.Future<$0.AddGroupMemberRequest> request) async {
    return addGroupMember(call, await request);
  }

  $async.Future<$0.RemoveGroupMemberResponse> removeGroupMember_Pre($grpc.ServiceCall call, $async.Future<$0.RemoveGroupMemberRequest> request) async {
    return removeGroupMember(call, await request);
  }

  $async.Future<$0.ContributeToGroupResponse> contributeToGroup_Pre($grpc.ServiceCall call, $async.Future<$0.ContributeToGroupRequest> request) async {
    return contributeToGroup(call, await request);
  }

  $async.Future<$0.WithdrawFromGroupResponse> withdrawFromGroup_Pre($grpc.ServiceCall call, $async.Future<$0.WithdrawFromGroupRequest> request) async {
    return withdrawFromGroup(call, await request);
  }

  $async.Future<$0.CloseGroupAccountResponse> closeGroupAccount_Pre($grpc.ServiceCall call, $async.Future<$0.CloseGroupAccountRequest> request) async {
    return closeGroupAccount(call, await request);
  }

  $async.Future<$0.BuyInsuranceResponse> buyInsurance_Pre($grpc.ServiceCall call, $async.Future<$0.BuyInsuranceRequest> request) async {
    return buyInsurance(call, await request);
  }

  $async.Future<$0.GetInsurancePoliciesResponse> getInsurancePolicies_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsurancePoliciesRequest> request) async {
    return getInsurancePolicies(call, await request);
  }

  $async.Future<$0.GetInsurancePolicyResponse> getInsurancePolicy_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsurancePolicyRequest> request) async {
    return getInsurancePolicy(call, await request);
  }

  $async.Future<$0.MakeInsuranceClaimResponse> makeInsuranceClaim_Pre($grpc.ServiceCall call, $async.Future<$0.MakeInsuranceClaimRequest> request) async {
    return makeInsuranceClaim(call, await request);
  }

  $async.Future<$0.CancelInsuranceResponse> cancelInsurance_Pre($grpc.ServiceCall call, $async.Future<$0.CancelInsuranceRequest> request) async {
    return cancelInsurance(call, await request);
  }

  $async.Future<$0.GetInsurancePlansResponse> getInsurancePlans_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsurancePlansRequest> request) async {
    return getInsurancePlans(call, await request);
  }

  $async.Future<$0.CreateCrowdfundResponse> createCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$0.CreateCrowdfundRequest> request) async {
    return createCrowdfund(call, await request);
  }

  $async.Future<$0.GetCrowdfundsResponse> getCrowdfunds_Pre($grpc.ServiceCall call, $async.Future<$0.GetCrowdfundsRequest> request) async {
    return getCrowdfunds(call, await request);
  }

  $async.Future<$0.GetCrowdfundResponse> getCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$0.GetCrowdfundRequest> request) async {
    return getCrowdfund(call, await request);
  }

  $async.Future<$0.ContributeToCrowdfundResponse> contributeToCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$0.ContributeToCrowdfundRequest> request) async {
    return contributeToCrowdfund(call, await request);
  }

  $async.Future<$0.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$0.WithdrawFromCrowdfundRequest> request) async {
    return withdrawFromCrowdfund(call, await request);
  }

  $async.Future<$0.CloseCrowdfundResponse> closeCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$0.CloseCrowdfundRequest> request) async {
    return closeCrowdfund(call, await request);
  }

  $async.Future<$0.GetCrowdfundStatisticsResponse> getCrowdfundStatistics_Pre($grpc.ServiceCall call, $async.Future<$0.GetCrowdfundStatisticsRequest> request) async {
    return getCrowdfundStatistics(call, await request);
  }

  $async.Future<$0.SearchCrowdfundsResponse> searchCrowdfunds_Pre($grpc.ServiceCall call, $async.Future<$0.SearchCrowdfundsRequest> request) async {
    return searchCrowdfunds(call, await request);
  }

  $async.Future<$0.UpdateCrowdfundResponse> updateCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateCrowdfundRequest> request) async {
    return updateCrowdfund(call, await request);
  }

  $async.Future<$0.DeleteCrowdfundResponse> deleteCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteCrowdfundRequest> request) async {
    return deleteCrowdfund(call, await request);
  }

  $async.Future<$0.GetCrowdfundDonationsResponse> getCrowdfundDonations_Pre($grpc.ServiceCall call, $async.Future<$0.GetCrowdfundDonationsRequest> request) async {
    return getCrowdfundDonations(call, await request);
  }

  $async.Future<$0.GetUserDonationsResponse> getUserDonations_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserDonationsRequest> request) async {
    return getUserDonations(call, await request);
  }

  $async.Future<$0.GenerateDonationReceiptResponse> generateDonationReceipt_Pre($grpc.ServiceCall call, $async.Future<$0.GenerateDonationReceiptRequest> request) async {
    return generateDonationReceipt(call, await request);
  }

  $async.Future<$0.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserCrowdfundReceiptsRequest> request) async {
    return getUserCrowdfundReceipts(call, await request);
  }

  $async.Future<$0.ConnectNotificationChannelResponse> connectNotificationChannel_Pre($grpc.ServiceCall call, $async.Future<$0.ConnectNotificationChannelRequest> request) async {
    return connectNotificationChannel(call, await request);
  }

  $async.Future<$0.DisconnectNotificationChannelResponse> disconnectNotificationChannel_Pre($grpc.ServiceCall call, $async.Future<$0.DisconnectNotificationChannelRequest> request) async {
    return disconnectNotificationChannel(call, await request);
  }

  $async.Future<$0.GetNotificationChannelsResponse> getNotificationChannels_Pre($grpc.ServiceCall call, $async.Future<$0.GetNotificationChannelsRequest> request) async {
    return getNotificationChannels(call, await request);
  }

  $async.Future<$0.UpdateNotificationChannelResponse> updateNotificationChannel_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateNotificationChannelRequest> request) async {
    return updateNotificationChannel(call, await request);
  }

  $async.Future<$0.TestNotificationChannelResponse> testNotificationChannel_Pre($grpc.ServiceCall call, $async.Future<$0.TestNotificationChannelRequest> request) async {
    return testNotificationChannel(call, await request);
  }

  $async.Future<$0.GetTelegramBotInfoResponse> getTelegramBotInfo_Pre($grpc.ServiceCall call, $async.Future<$0.GetTelegramBotInfoRequest> request) async {
    return getTelegramBotInfo(call, await request);
  }

  $async.Future<$0.VerifyTelegramChannelResponse> verifyTelegramChannel_Pre($grpc.ServiceCall call, $async.Future<$0.VerifyTelegramChannelRequest> request) async {
    return verifyTelegramChannel(call, await request);
  }

  $async.Future<$0.GetNotificationHistoryResponse> getNotificationHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetNotificationHistoryRequest> request) async {
    return getNotificationHistory(call, await request);
  }

  $async.Future<$0.CreateGroupAccountResponse> createGroupAccount($grpc.ServiceCall call, $0.CreateGroupAccountRequest request);
  $async.Future<$0.GetGroupAccountsResponse> getGroupAccounts($grpc.ServiceCall call, $0.GetGroupAccountsRequest request);
  $async.Future<$0.GetGroupAccountResponse> getGroupAccount($grpc.ServiceCall call, $0.GetGroupAccountRequest request);
  $async.Future<$0.AddGroupMemberResponse> addGroupMember($grpc.ServiceCall call, $0.AddGroupMemberRequest request);
  $async.Future<$0.RemoveGroupMemberResponse> removeGroupMember($grpc.ServiceCall call, $0.RemoveGroupMemberRequest request);
  $async.Future<$0.ContributeToGroupResponse> contributeToGroup($grpc.ServiceCall call, $0.ContributeToGroupRequest request);
  $async.Future<$0.WithdrawFromGroupResponse> withdrawFromGroup($grpc.ServiceCall call, $0.WithdrawFromGroupRequest request);
  $async.Future<$0.CloseGroupAccountResponse> closeGroupAccount($grpc.ServiceCall call, $0.CloseGroupAccountRequest request);
  $async.Future<$0.BuyInsuranceResponse> buyInsurance($grpc.ServiceCall call, $0.BuyInsuranceRequest request);
  $async.Future<$0.GetInsurancePoliciesResponse> getInsurancePolicies($grpc.ServiceCall call, $0.GetInsurancePoliciesRequest request);
  $async.Future<$0.GetInsurancePolicyResponse> getInsurancePolicy($grpc.ServiceCall call, $0.GetInsurancePolicyRequest request);
  $async.Future<$0.MakeInsuranceClaimResponse> makeInsuranceClaim($grpc.ServiceCall call, $0.MakeInsuranceClaimRequest request);
  $async.Future<$0.CancelInsuranceResponse> cancelInsurance($grpc.ServiceCall call, $0.CancelInsuranceRequest request);
  $async.Future<$0.GetInsurancePlansResponse> getInsurancePlans($grpc.ServiceCall call, $0.GetInsurancePlansRequest request);
  $async.Future<$0.CreateCrowdfundResponse> createCrowdfund($grpc.ServiceCall call, $0.CreateCrowdfundRequest request);
  $async.Future<$0.GetCrowdfundsResponse> getCrowdfunds($grpc.ServiceCall call, $0.GetCrowdfundsRequest request);
  $async.Future<$0.GetCrowdfundResponse> getCrowdfund($grpc.ServiceCall call, $0.GetCrowdfundRequest request);
  $async.Future<$0.ContributeToCrowdfundResponse> contributeToCrowdfund($grpc.ServiceCall call, $0.ContributeToCrowdfundRequest request);
  $async.Future<$0.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund($grpc.ServiceCall call, $0.WithdrawFromCrowdfundRequest request);
  $async.Future<$0.CloseCrowdfundResponse> closeCrowdfund($grpc.ServiceCall call, $0.CloseCrowdfundRequest request);
  $async.Future<$0.GetCrowdfundStatisticsResponse> getCrowdfundStatistics($grpc.ServiceCall call, $0.GetCrowdfundStatisticsRequest request);
  $async.Future<$0.SearchCrowdfundsResponse> searchCrowdfunds($grpc.ServiceCall call, $0.SearchCrowdfundsRequest request);
  $async.Future<$0.UpdateCrowdfundResponse> updateCrowdfund($grpc.ServiceCall call, $0.UpdateCrowdfundRequest request);
  $async.Future<$0.DeleteCrowdfundResponse> deleteCrowdfund($grpc.ServiceCall call, $0.DeleteCrowdfundRequest request);
  $async.Future<$0.GetCrowdfundDonationsResponse> getCrowdfundDonations($grpc.ServiceCall call, $0.GetCrowdfundDonationsRequest request);
  $async.Future<$0.GetUserDonationsResponse> getUserDonations($grpc.ServiceCall call, $0.GetUserDonationsRequest request);
  $async.Future<$0.GenerateDonationReceiptResponse> generateDonationReceipt($grpc.ServiceCall call, $0.GenerateDonationReceiptRequest request);
  $async.Future<$0.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts($grpc.ServiceCall call, $0.GetUserCrowdfundReceiptsRequest request);
  $async.Future<$0.ConnectNotificationChannelResponse> connectNotificationChannel($grpc.ServiceCall call, $0.ConnectNotificationChannelRequest request);
  $async.Future<$0.DisconnectNotificationChannelResponse> disconnectNotificationChannel($grpc.ServiceCall call, $0.DisconnectNotificationChannelRequest request);
  $async.Future<$0.GetNotificationChannelsResponse> getNotificationChannels($grpc.ServiceCall call, $0.GetNotificationChannelsRequest request);
  $async.Future<$0.UpdateNotificationChannelResponse> updateNotificationChannel($grpc.ServiceCall call, $0.UpdateNotificationChannelRequest request);
  $async.Future<$0.TestNotificationChannelResponse> testNotificationChannel($grpc.ServiceCall call, $0.TestNotificationChannelRequest request);
  $async.Future<$0.GetTelegramBotInfoResponse> getTelegramBotInfo($grpc.ServiceCall call, $0.GetTelegramBotInfoRequest request);
  $async.Future<$0.VerifyTelegramChannelResponse> verifyTelegramChannel($grpc.ServiceCall call, $0.VerifyTelegramChannelRequest request);
  $async.Future<$0.GetNotificationHistoryResponse> getNotificationHistory($grpc.ServiceCall call, $0.GetNotificationHistoryRequest request);
}
