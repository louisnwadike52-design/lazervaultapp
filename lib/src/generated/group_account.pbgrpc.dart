///
//  Generated code. Do not modify.
//  source: group_account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'group_account.pb.dart' as $15;
export 'group_account.pb.dart';

class GroupAccountServiceClient extends $grpc.Client {
  static final _$createGroup =
      $grpc.ClientMethod<$15.CreateGroupRequest, $15.CreateGroupResponse>(
          '/pb.GroupAccountService/CreateGroup',
          ($15.CreateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.CreateGroupResponse.fromBuffer(value));
  static final _$getGroup =
      $grpc.ClientMethod<$15.GetGroupRequest, $15.GetGroupResponse>(
          '/pb.GroupAccountService/GetGroup',
          ($15.GetGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.GetGroupResponse.fromBuffer(value));
  static final _$listUserGroups =
      $grpc.ClientMethod<$15.ListUserGroupsRequest, $15.ListUserGroupsResponse>(
          '/pb.GroupAccountService/ListUserGroups',
          ($15.ListUserGroupsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.ListUserGroupsResponse.fromBuffer(value));
  static final _$updateGroup =
      $grpc.ClientMethod<$15.UpdateGroupRequest, $15.UpdateGroupResponse>(
          '/pb.GroupAccountService/UpdateGroup',
          ($15.UpdateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.UpdateGroupResponse.fromBuffer(value));
  static final _$deleteGroup =
      $grpc.ClientMethod<$15.DeleteGroupRequest, $15.DeleteGroupResponse>(
          '/pb.GroupAccountService/DeleteGroup',
          ($15.DeleteGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.DeleteGroupResponse.fromBuffer(value));
  static final _$getGroupMembers = $grpc.ClientMethod<
          $15.GetGroupMembersRequest, $15.GetGroupMembersResponse>(
      '/pb.GroupAccountService/GetGroupMembers',
      ($15.GetGroupMembersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetGroupMembersResponse.fromBuffer(value));
  static final _$addMember =
      $grpc.ClientMethod<$15.AddMemberRequest, $15.AddMemberResponse>(
          '/pb.GroupAccountService/AddMember',
          ($15.AddMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.AddMemberResponse.fromBuffer(value));
  static final _$updateMemberRole = $grpc.ClientMethod<
          $15.UpdateMemberRoleRequest, $15.UpdateMemberRoleResponse>(
      '/pb.GroupAccountService/UpdateMemberRole',
      ($15.UpdateMemberRoleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.UpdateMemberRoleResponse.fromBuffer(value));
  static final _$removeMember =
      $grpc.ClientMethod<$15.RemoveMemberRequest, $15.RemoveMemberResponse>(
          '/pb.GroupAccountService/RemoveMember',
          ($15.RemoveMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.RemoveMemberResponse.fromBuffer(value));
  static final _$searchUsers =
      $grpc.ClientMethod<$15.SearchUsersRequest, $15.SearchUsersResponse>(
          '/pb.GroupAccountService/SearchUsers',
          ($15.SearchUsersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.SearchUsersResponse.fromBuffer(value));
  static final _$createContribution = $grpc.ClientMethod<
          $15.CreateContributionRequest, $15.CreateContributionResponse>(
      '/pb.GroupAccountService/CreateContribution',
      ($15.CreateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.CreateContributionResponse.fromBuffer(value));
  static final _$getContribution = $grpc.ClientMethod<
          $15.GetContributionRequest, $15.GetContributionResponse>(
      '/pb.GroupAccountService/GetContribution',
      ($15.GetContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetContributionResponse.fromBuffer(value));
  static final _$listGroupContributions = $grpc.ClientMethod<
          $15.ListGroupContributionsRequest,
          $15.ListGroupContributionsResponse>(
      '/pb.GroupAccountService/ListGroupContributions',
      ($15.ListGroupContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.ListGroupContributionsResponse.fromBuffer(value));
  static final _$updateContribution = $grpc.ClientMethod<
          $15.UpdateContributionRequest, $15.UpdateContributionResponse>(
      '/pb.GroupAccountService/UpdateContribution',
      ($15.UpdateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.UpdateContributionResponse.fromBuffer(value));
  static final _$deleteContribution = $grpc.ClientMethod<
          $15.DeleteContributionRequest, $15.DeleteContributionResponse>(
      '/pb.GroupAccountService/DeleteContribution',
      ($15.DeleteContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.DeleteContributionResponse.fromBuffer(value));
  static final _$makePayment =
      $grpc.ClientMethod<$15.MakePaymentRequest, $15.MakePaymentResponse>(
          '/pb.GroupAccountService/MakePayment',
          ($15.MakePaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.MakePaymentResponse.fromBuffer(value));
  static final _$getContributionPayments = $grpc.ClientMethod<
          $15.GetContributionPaymentsRequest,
          $15.GetContributionPaymentsResponse>(
      '/pb.GroupAccountService/GetContributionPayments',
      ($15.GetContributionPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetContributionPaymentsResponse.fromBuffer(value));
  static final _$updatePaymentStatus = $grpc.ClientMethod<
          $15.UpdatePaymentStatusRequest, $15.UpdatePaymentStatusResponse>(
      '/pb.GroupAccountService/UpdatePaymentStatus',
      ($15.UpdatePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.UpdatePaymentStatusResponse.fromBuffer(value));
  static final _$processScheduledPayments = $grpc.ClientMethod<
          $15.ProcessScheduledPaymentsRequest,
          $15.ProcessScheduledPaymentsResponse>(
      '/pb.GroupAccountService/ProcessScheduledPayments',
      ($15.ProcessScheduledPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.ProcessScheduledPaymentsResponse.fromBuffer(value));
  static final _$getOverdueContributions = $grpc.ClientMethod<
          $15.GetOverdueContributionsRequest,
          $15.GetOverdueContributionsResponse>(
      '/pb.GroupAccountService/GetOverdueContributions',
      ($15.GetOverdueContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetOverdueContributionsResponse.fromBuffer(value));
  static final _$getPayoutSchedule = $grpc.ClientMethod<
          $15.GetPayoutScheduleRequest, $15.GetPayoutScheduleResponse>(
      '/pb.GroupAccountService/GetPayoutSchedule',
      ($15.GetPayoutScheduleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetPayoutScheduleResponse.fromBuffer(value));
  static final _$processPayout =
      $grpc.ClientMethod<$15.ProcessPayoutRequest, $15.ProcessPayoutResponse>(
          '/pb.GroupAccountService/ProcessPayout',
          ($15.ProcessPayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $15.ProcessPayoutResponse.fromBuffer(value));
  static final _$updatePayoutStatus = $grpc.ClientMethod<
          $15.UpdatePayoutStatusRequest, $15.UpdatePayoutStatusResponse>(
      '/pb.GroupAccountService/UpdatePayoutStatus',
      ($15.UpdatePayoutStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.UpdatePayoutStatusResponse.fromBuffer(value));
  static final _$advancePayoutRotation = $grpc.ClientMethod<
          $15.AdvancePayoutRotationRequest, $15.AdvancePayoutRotationResponse>(
      '/pb.GroupAccountService/AdvancePayoutRotation',
      ($15.AdvancePayoutRotationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.AdvancePayoutRotationResponse.fromBuffer(value));
  static final _$generateReceipt = $grpc.ClientMethod<
          $15.GenerateReceiptRequest, $15.GenerateReceiptResponse>(
      '/pb.GroupAccountService/GenerateReceipt',
      ($15.GenerateReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GenerateReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<
          $15.GetUserContributionReceiptsRequest,
          $15.GetUserContributionReceiptsResponse>(
      '/pb.GroupAccountService/GetUserReceipts',
      ($15.GetUserContributionReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetUserContributionReceiptsResponse.fromBuffer(value));
  static final _$generateTranscript = $grpc.ClientMethod<
          $15.GenerateTranscriptRequest, $15.GenerateTranscriptResponse>(
      '/pb.GroupAccountService/GenerateTranscript',
      ($15.GenerateTranscriptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GenerateTranscriptResponse.fromBuffer(value));
  static final _$getGroupStatistics = $grpc.ClientMethod<
          $15.GetGroupStatisticsRequest, $15.GetGroupStatisticsResponse>(
      '/pb.GroupAccountService/GetGroupStatistics',
      ($15.GetGroupStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetGroupStatisticsResponse.fromBuffer(value));
  static final _$getUserContributionStats = $grpc.ClientMethod<
          $15.GetUserContributionStatsRequest,
          $15.GetUserContributionStatsResponse>(
      '/pb.GroupAccountService/GetUserContributionStats',
      ($15.GetUserContributionStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetUserContributionStatsResponse.fromBuffer(value));
  static final _$getContributionAnalytics = $grpc.ClientMethod<
          $15.GetContributionAnalyticsRequest,
          $15.GetContributionAnalyticsResponse>(
      '/pb.GroupAccountService/GetContributionAnalytics',
      ($15.GetContributionAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetContributionAnalyticsResponse.fromBuffer(value));

  GroupAccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$15.CreateGroupResponse> createGroup(
      $15.CreateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroup, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetGroupResponse> getGroup(
      $15.GetGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroup, request, options: options);
  }

  $grpc.ResponseFuture<$15.ListUserGroupsResponse> listUserGroups(
      $15.ListUserGroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listUserGroups, request, options: options);
  }

  $grpc.ResponseFuture<$15.UpdateGroupResponse> updateGroup(
      $15.UpdateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateGroup, request, options: options);
  }

  $grpc.ResponseFuture<$15.DeleteGroupResponse> deleteGroup(
      $15.DeleteGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteGroup, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetGroupMembersResponse> getGroupMembers(
      $15.GetGroupMembersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupMembers, request, options: options);
  }

  $grpc.ResponseFuture<$15.AddMemberResponse> addMember(
      $15.AddMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMember, request, options: options);
  }

  $grpc.ResponseFuture<$15.UpdateMemberRoleResponse> updateMemberRole(
      $15.UpdateMemberRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMemberRole, request, options: options);
  }

  $grpc.ResponseFuture<$15.RemoveMemberResponse> removeMember(
      $15.RemoveMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeMember, request, options: options);
  }

  $grpc.ResponseFuture<$15.SearchUsersResponse> searchUsers(
      $15.SearchUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$15.CreateContributionResponse> createContribution(
      $15.CreateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createContribution, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetContributionResponse> getContribution(
      $15.GetContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContribution, request, options: options);
  }

  $grpc.ResponseFuture<$15.ListGroupContributionsResponse>
      listGroupContributions($15.ListGroupContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listGroupContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.UpdateContributionResponse> updateContribution(
      $15.UpdateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateContribution, request, options: options);
  }

  $grpc.ResponseFuture<$15.DeleteContributionResponse> deleteContribution(
      $15.DeleteContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteContribution, request, options: options);
  }

  $grpc.ResponseFuture<$15.MakePaymentResponse> makePayment(
      $15.MakePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makePayment, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetContributionPaymentsResponse>
      getContributionPayments($15.GetContributionPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.UpdatePaymentStatusResponse> updatePaymentStatus(
      $15.UpdatePaymentStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$15.ProcessScheduledPaymentsResponse>
      processScheduledPayments($15.ProcessScheduledPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processScheduledPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.GetOverdueContributionsResponse>
      getOverdueContributions($15.GetOverdueContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.GetPayoutScheduleResponse> getPayoutSchedule(
      $15.GetPayoutScheduleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutSchedule, request, options: options);
  }

  $grpc.ResponseFuture<$15.ProcessPayoutResponse> processPayout(
      $15.ProcessPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayout, request, options: options);
  }

  $grpc.ResponseFuture<$15.UpdatePayoutStatusResponse> updatePayoutStatus(
      $15.UpdatePayoutStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePayoutStatus, request, options: options);
  }

  $grpc.ResponseFuture<$15.AdvancePayoutRotationResponse> advancePayoutRotation(
      $15.AdvancePayoutRotationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$advancePayoutRotation, request, options: options);
  }

  $grpc.ResponseFuture<$15.GenerateReceiptResponse> generateReceipt(
      $15.GenerateReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetUserContributionReceiptsResponse> getUserReceipts(
      $15.GetUserContributionReceiptsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$15.GenerateTranscriptResponse> generateTranscript(
      $15.GenerateTranscriptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateTranscript, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetGroupStatisticsResponse> getGroupStatistics(
      $15.GetGroupStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetUserContributionStatsResponse>
      getUserContributionStats($15.GetUserContributionStatsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserContributionStats, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.GetContributionAnalyticsResponse>
      getContributionAnalytics($15.GetContributionAnalyticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionAnalytics, request,
        options: options);
  }
}

abstract class GroupAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GroupAccountService';

  GroupAccountServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$15.CreateGroupRequest, $15.CreateGroupResponse>(
            'CreateGroup',
            createGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $15.CreateGroupRequest.fromBuffer(value),
            ($15.CreateGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetGroupRequest, $15.GetGroupResponse>(
        'GetGroup',
        getGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.GetGroupRequest.fromBuffer(value),
        ($15.GetGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ListUserGroupsRequest,
            $15.ListUserGroupsResponse>(
        'ListUserGroups',
        listUserGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ListUserGroupsRequest.fromBuffer(value),
        ($15.ListUserGroupsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$15.UpdateGroupRequest, $15.UpdateGroupResponse>(
            'UpdateGroup',
            updateGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $15.UpdateGroupRequest.fromBuffer(value),
            ($15.UpdateGroupResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$15.DeleteGroupRequest, $15.DeleteGroupResponse>(
            'DeleteGroup',
            deleteGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $15.DeleteGroupRequest.fromBuffer(value),
            ($15.DeleteGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetGroupMembersRequest,
            $15.GetGroupMembersResponse>(
        'GetGroupMembers',
        getGroupMembers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetGroupMembersRequest.fromBuffer(value),
        ($15.GetGroupMembersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.AddMemberRequest, $15.AddMemberResponse>(
        'AddMember',
        addMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.AddMemberRequest.fromBuffer(value),
        ($15.AddMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.UpdateMemberRoleRequest,
            $15.UpdateMemberRoleResponse>(
        'UpdateMemberRole',
        updateMemberRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.UpdateMemberRoleRequest.fromBuffer(value),
        ($15.UpdateMemberRoleResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$15.RemoveMemberRequest, $15.RemoveMemberResponse>(
            'RemoveMember',
            removeMember_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $15.RemoveMemberRequest.fromBuffer(value),
            ($15.RemoveMemberResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$15.SearchUsersRequest, $15.SearchUsersResponse>(
            'SearchUsers',
            searchUsers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $15.SearchUsersRequest.fromBuffer(value),
            ($15.SearchUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.CreateContributionRequest,
            $15.CreateContributionResponse>(
        'CreateContribution',
        createContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.CreateContributionRequest.fromBuffer(value),
        ($15.CreateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetContributionRequest,
            $15.GetContributionResponse>(
        'GetContribution',
        getContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetContributionRequest.fromBuffer(value),
        ($15.GetContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ListGroupContributionsRequest,
            $15.ListGroupContributionsResponse>(
        'ListGroupContributions',
        listGroupContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ListGroupContributionsRequest.fromBuffer(value),
        ($15.ListGroupContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.UpdateContributionRequest,
            $15.UpdateContributionResponse>(
        'UpdateContribution',
        updateContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.UpdateContributionRequest.fromBuffer(value),
        ($15.UpdateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.DeleteContributionRequest,
            $15.DeleteContributionResponse>(
        'DeleteContribution',
        deleteContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.DeleteContributionRequest.fromBuffer(value),
        ($15.DeleteContributionResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$15.MakePaymentRequest, $15.MakePaymentResponse>(
            'MakePayment',
            makePayment_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $15.MakePaymentRequest.fromBuffer(value),
            ($15.MakePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetContributionPaymentsRequest,
            $15.GetContributionPaymentsResponse>(
        'GetContributionPayments',
        getContributionPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetContributionPaymentsRequest.fromBuffer(value),
        ($15.GetContributionPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.UpdatePaymentStatusRequest,
            $15.UpdatePaymentStatusResponse>(
        'UpdatePaymentStatus',
        updatePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.UpdatePaymentStatusRequest.fromBuffer(value),
        ($15.UpdatePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ProcessScheduledPaymentsRequest,
            $15.ProcessScheduledPaymentsResponse>(
        'ProcessScheduledPayments',
        processScheduledPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ProcessScheduledPaymentsRequest.fromBuffer(value),
        ($15.ProcessScheduledPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetOverdueContributionsRequest,
            $15.GetOverdueContributionsResponse>(
        'GetOverdueContributions',
        getOverdueContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetOverdueContributionsRequest.fromBuffer(value),
        ($15.GetOverdueContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetPayoutScheduleRequest,
            $15.GetPayoutScheduleResponse>(
        'GetPayoutSchedule',
        getPayoutSchedule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetPayoutScheduleRequest.fromBuffer(value),
        ($15.GetPayoutScheduleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ProcessPayoutRequest,
            $15.ProcessPayoutResponse>(
        'ProcessPayout',
        processPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ProcessPayoutRequest.fromBuffer(value),
        ($15.ProcessPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.UpdatePayoutStatusRequest,
            $15.UpdatePayoutStatusResponse>(
        'UpdatePayoutStatus',
        updatePayoutStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.UpdatePayoutStatusRequest.fromBuffer(value),
        ($15.UpdatePayoutStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.AdvancePayoutRotationRequest,
            $15.AdvancePayoutRotationResponse>(
        'AdvancePayoutRotation',
        advancePayoutRotation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.AdvancePayoutRotationRequest.fromBuffer(value),
        ($15.AdvancePayoutRotationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GenerateReceiptRequest,
            $15.GenerateReceiptResponse>(
        'GenerateReceipt',
        generateReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GenerateReceiptRequest.fromBuffer(value),
        ($15.GenerateReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetUserContributionReceiptsRequest,
            $15.GetUserContributionReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetUserContributionReceiptsRequest.fromBuffer(value),
        ($15.GetUserContributionReceiptsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GenerateTranscriptRequest,
            $15.GenerateTranscriptResponse>(
        'GenerateTranscript',
        generateTranscript_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GenerateTranscriptRequest.fromBuffer(value),
        ($15.GenerateTranscriptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetGroupStatisticsRequest,
            $15.GetGroupStatisticsResponse>(
        'GetGroupStatistics',
        getGroupStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetGroupStatisticsRequest.fromBuffer(value),
        ($15.GetGroupStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetUserContributionStatsRequest,
            $15.GetUserContributionStatsResponse>(
        'GetUserContributionStats',
        getUserContributionStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetUserContributionStatsRequest.fromBuffer(value),
        ($15.GetUserContributionStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetContributionAnalyticsRequest,
            $15.GetContributionAnalyticsResponse>(
        'GetContributionAnalytics',
        getContributionAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetContributionAnalyticsRequest.fromBuffer(value),
        ($15.GetContributionAnalyticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$15.CreateGroupResponse> createGroup_Pre($grpc.ServiceCall call,
      $async.Future<$15.CreateGroupRequest> request) async {
    return createGroup(call, await request);
  }

  $async.Future<$15.GetGroupResponse> getGroup_Pre($grpc.ServiceCall call,
      $async.Future<$15.GetGroupRequest> request) async {
    return getGroup(call, await request);
  }

  $async.Future<$15.ListUserGroupsResponse> listUserGroups_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.ListUserGroupsRequest> request) async {
    return listUserGroups(call, await request);
  }

  $async.Future<$15.UpdateGroupResponse> updateGroup_Pre($grpc.ServiceCall call,
      $async.Future<$15.UpdateGroupRequest> request) async {
    return updateGroup(call, await request);
  }

  $async.Future<$15.DeleteGroupResponse> deleteGroup_Pre($grpc.ServiceCall call,
      $async.Future<$15.DeleteGroupRequest> request) async {
    return deleteGroup(call, await request);
  }

  $async.Future<$15.GetGroupMembersResponse> getGroupMembers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GetGroupMembersRequest> request) async {
    return getGroupMembers(call, await request);
  }

  $async.Future<$15.AddMemberResponse> addMember_Pre($grpc.ServiceCall call,
      $async.Future<$15.AddMemberRequest> request) async {
    return addMember(call, await request);
  }

  $async.Future<$15.UpdateMemberRoleResponse> updateMemberRole_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.UpdateMemberRoleRequest> request) async {
    return updateMemberRole(call, await request);
  }

  $async.Future<$15.RemoveMemberResponse> removeMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.RemoveMemberRequest> request) async {
    return removeMember(call, await request);
  }

  $async.Future<$15.SearchUsersResponse> searchUsers_Pre($grpc.ServiceCall call,
      $async.Future<$15.SearchUsersRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$15.CreateContributionResponse> createContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.CreateContributionRequest> request) async {
    return createContribution(call, await request);
  }

  $async.Future<$15.GetContributionResponse> getContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GetContributionRequest> request) async {
    return getContribution(call, await request);
  }

  $async.Future<$15.ListGroupContributionsResponse> listGroupContributions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.ListGroupContributionsRequest> request) async {
    return listGroupContributions(call, await request);
  }

  $async.Future<$15.UpdateContributionResponse> updateContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.UpdateContributionRequest> request) async {
    return updateContribution(call, await request);
  }

  $async.Future<$15.DeleteContributionResponse> deleteContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.DeleteContributionRequest> request) async {
    return deleteContribution(call, await request);
  }

  $async.Future<$15.MakePaymentResponse> makePayment_Pre($grpc.ServiceCall call,
      $async.Future<$15.MakePaymentRequest> request) async {
    return makePayment(call, await request);
  }

  $async.Future<$15.GetContributionPaymentsResponse>
      getContributionPayments_Pre($grpc.ServiceCall call,
          $async.Future<$15.GetContributionPaymentsRequest> request) async {
    return getContributionPayments(call, await request);
  }

  $async.Future<$15.UpdatePaymentStatusResponse> updatePaymentStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.UpdatePaymentStatusRequest> request) async {
    return updatePaymentStatus(call, await request);
  }

  $async.Future<$15.ProcessScheduledPaymentsResponse>
      processScheduledPayments_Pre($grpc.ServiceCall call,
          $async.Future<$15.ProcessScheduledPaymentsRequest> request) async {
    return processScheduledPayments(call, await request);
  }

  $async.Future<$15.GetOverdueContributionsResponse>
      getOverdueContributions_Pre($grpc.ServiceCall call,
          $async.Future<$15.GetOverdueContributionsRequest> request) async {
    return getOverdueContributions(call, await request);
  }

  $async.Future<$15.GetPayoutScheduleResponse> getPayoutSchedule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GetPayoutScheduleRequest> request) async {
    return getPayoutSchedule(call, await request);
  }

  $async.Future<$15.ProcessPayoutResponse> processPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.ProcessPayoutRequest> request) async {
    return processPayout(call, await request);
  }

  $async.Future<$15.UpdatePayoutStatusResponse> updatePayoutStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.UpdatePayoutStatusRequest> request) async {
    return updatePayoutStatus(call, await request);
  }

  $async.Future<$15.AdvancePayoutRotationResponse> advancePayoutRotation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.AdvancePayoutRotationRequest> request) async {
    return advancePayoutRotation(call, await request);
  }

  $async.Future<$15.GenerateReceiptResponse> generateReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GenerateReceiptRequest> request) async {
    return generateReceipt(call, await request);
  }

  $async.Future<$15.GetUserContributionReceiptsResponse> getUserReceipts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GetUserContributionReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$15.GenerateTranscriptResponse> generateTranscript_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GenerateTranscriptRequest> request) async {
    return generateTranscript(call, await request);
  }

  $async.Future<$15.GetGroupStatisticsResponse> getGroupStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GetGroupStatisticsRequest> request) async {
    return getGroupStatistics(call, await request);
  }

  $async.Future<$15.GetUserContributionStatsResponse>
      getUserContributionStats_Pre($grpc.ServiceCall call,
          $async.Future<$15.GetUserContributionStatsRequest> request) async {
    return getUserContributionStats(call, await request);
  }

  $async.Future<$15.GetContributionAnalyticsResponse>
      getContributionAnalytics_Pre($grpc.ServiceCall call,
          $async.Future<$15.GetContributionAnalyticsRequest> request) async {
    return getContributionAnalytics(call, await request);
  }

  $async.Future<$15.CreateGroupResponse> createGroup(
      $grpc.ServiceCall call, $15.CreateGroupRequest request);
  $async.Future<$15.GetGroupResponse> getGroup(
      $grpc.ServiceCall call, $15.GetGroupRequest request);
  $async.Future<$15.ListUserGroupsResponse> listUserGroups(
      $grpc.ServiceCall call, $15.ListUserGroupsRequest request);
  $async.Future<$15.UpdateGroupResponse> updateGroup(
      $grpc.ServiceCall call, $15.UpdateGroupRequest request);
  $async.Future<$15.DeleteGroupResponse> deleteGroup(
      $grpc.ServiceCall call, $15.DeleteGroupRequest request);
  $async.Future<$15.GetGroupMembersResponse> getGroupMembers(
      $grpc.ServiceCall call, $15.GetGroupMembersRequest request);
  $async.Future<$15.AddMemberResponse> addMember(
      $grpc.ServiceCall call, $15.AddMemberRequest request);
  $async.Future<$15.UpdateMemberRoleResponse> updateMemberRole(
      $grpc.ServiceCall call, $15.UpdateMemberRoleRequest request);
  $async.Future<$15.RemoveMemberResponse> removeMember(
      $grpc.ServiceCall call, $15.RemoveMemberRequest request);
  $async.Future<$15.SearchUsersResponse> searchUsers(
      $grpc.ServiceCall call, $15.SearchUsersRequest request);
  $async.Future<$15.CreateContributionResponse> createContribution(
      $grpc.ServiceCall call, $15.CreateContributionRequest request);
  $async.Future<$15.GetContributionResponse> getContribution(
      $grpc.ServiceCall call, $15.GetContributionRequest request);
  $async.Future<$15.ListGroupContributionsResponse> listGroupContributions(
      $grpc.ServiceCall call, $15.ListGroupContributionsRequest request);
  $async.Future<$15.UpdateContributionResponse> updateContribution(
      $grpc.ServiceCall call, $15.UpdateContributionRequest request);
  $async.Future<$15.DeleteContributionResponse> deleteContribution(
      $grpc.ServiceCall call, $15.DeleteContributionRequest request);
  $async.Future<$15.MakePaymentResponse> makePayment(
      $grpc.ServiceCall call, $15.MakePaymentRequest request);
  $async.Future<$15.GetContributionPaymentsResponse> getContributionPayments(
      $grpc.ServiceCall call, $15.GetContributionPaymentsRequest request);
  $async.Future<$15.UpdatePaymentStatusResponse> updatePaymentStatus(
      $grpc.ServiceCall call, $15.UpdatePaymentStatusRequest request);
  $async.Future<$15.ProcessScheduledPaymentsResponse> processScheduledPayments(
      $grpc.ServiceCall call, $15.ProcessScheduledPaymentsRequest request);
  $async.Future<$15.GetOverdueContributionsResponse> getOverdueContributions(
      $grpc.ServiceCall call, $15.GetOverdueContributionsRequest request);
  $async.Future<$15.GetPayoutScheduleResponse> getPayoutSchedule(
      $grpc.ServiceCall call, $15.GetPayoutScheduleRequest request);
  $async.Future<$15.ProcessPayoutResponse> processPayout(
      $grpc.ServiceCall call, $15.ProcessPayoutRequest request);
  $async.Future<$15.UpdatePayoutStatusResponse> updatePayoutStatus(
      $grpc.ServiceCall call, $15.UpdatePayoutStatusRequest request);
  $async.Future<$15.AdvancePayoutRotationResponse> advancePayoutRotation(
      $grpc.ServiceCall call, $15.AdvancePayoutRotationRequest request);
  $async.Future<$15.GenerateReceiptResponse> generateReceipt(
      $grpc.ServiceCall call, $15.GenerateReceiptRequest request);
  $async.Future<$15.GetUserContributionReceiptsResponse> getUserReceipts(
      $grpc.ServiceCall call, $15.GetUserContributionReceiptsRequest request);
  $async.Future<$15.GenerateTranscriptResponse> generateTranscript(
      $grpc.ServiceCall call, $15.GenerateTranscriptRequest request);
  $async.Future<$15.GetGroupStatisticsResponse> getGroupStatistics(
      $grpc.ServiceCall call, $15.GetGroupStatisticsRequest request);
  $async.Future<$15.GetUserContributionStatsResponse> getUserContributionStats(
      $grpc.ServiceCall call, $15.GetUserContributionStatsRequest request);
  $async.Future<$15.GetContributionAnalyticsResponse> getContributionAnalytics(
      $grpc.ServiceCall call, $15.GetContributionAnalyticsRequest request);
}
