///
//  Generated code. Do not modify.
//  source: group_account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'group_account.pb.dart' as $12;
export 'group_account.pb.dart';

class GroupAccountServiceClient extends $grpc.Client {
  static final _$createGroup =
      $grpc.ClientMethod<$12.CreateGroupRequest, $12.CreateGroupResponse>(
          '/pb.GroupAccountService/CreateGroup',
          ($12.CreateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.CreateGroupResponse.fromBuffer(value));
  static final _$getGroup =
      $grpc.ClientMethod<$12.GetGroupRequest, $12.GetGroupResponse>(
          '/pb.GroupAccountService/GetGroup',
          ($12.GetGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetGroupResponse.fromBuffer(value));
  static final _$listUserGroups =
      $grpc.ClientMethod<$12.ListUserGroupsRequest, $12.ListUserGroupsResponse>(
          '/pb.GroupAccountService/ListUserGroups',
          ($12.ListUserGroupsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.ListUserGroupsResponse.fromBuffer(value));
  static final _$updateGroup =
      $grpc.ClientMethod<$12.UpdateGroupRequest, $12.UpdateGroupResponse>(
          '/pb.GroupAccountService/UpdateGroup',
          ($12.UpdateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.UpdateGroupResponse.fromBuffer(value));
  static final _$deleteGroup =
      $grpc.ClientMethod<$12.DeleteGroupRequest, $12.DeleteGroupResponse>(
          '/pb.GroupAccountService/DeleteGroup',
          ($12.DeleteGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.DeleteGroupResponse.fromBuffer(value));
  static final _$getGroupMembers = $grpc.ClientMethod<
          $12.GetGroupMembersRequest, $12.GetGroupMembersResponse>(
      '/pb.GroupAccountService/GetGroupMembers',
      ($12.GetGroupMembersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetGroupMembersResponse.fromBuffer(value));
  static final _$addMember =
      $grpc.ClientMethod<$12.AddMemberRequest, $12.AddMemberResponse>(
          '/pb.GroupAccountService/AddMember',
          ($12.AddMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.AddMemberResponse.fromBuffer(value));
  static final _$updateMemberRole = $grpc.ClientMethod<
          $12.UpdateMemberRoleRequest, $12.UpdateMemberRoleResponse>(
      '/pb.GroupAccountService/UpdateMemberRole',
      ($12.UpdateMemberRoleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.UpdateMemberRoleResponse.fromBuffer(value));
  static final _$removeMember =
      $grpc.ClientMethod<$12.RemoveMemberRequest, $12.RemoveMemberResponse>(
          '/pb.GroupAccountService/RemoveMember',
          ($12.RemoveMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.RemoveMemberResponse.fromBuffer(value));
  static final _$searchUsers =
      $grpc.ClientMethod<$12.SearchUsersRequest, $12.SearchUsersResponse>(
          '/pb.GroupAccountService/SearchUsers',
          ($12.SearchUsersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.SearchUsersResponse.fromBuffer(value));
  static final _$createContribution = $grpc.ClientMethod<
          $12.CreateContributionRequest, $12.CreateContributionResponse>(
      '/pb.GroupAccountService/CreateContribution',
      ($12.CreateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.CreateContributionResponse.fromBuffer(value));
  static final _$getContribution = $grpc.ClientMethod<
          $12.GetContributionRequest, $12.GetContributionResponse>(
      '/pb.GroupAccountService/GetContribution',
      ($12.GetContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetContributionResponse.fromBuffer(value));
  static final _$listGroupContributions = $grpc.ClientMethod<
          $12.ListGroupContributionsRequest,
          $12.ListGroupContributionsResponse>(
      '/pb.GroupAccountService/ListGroupContributions',
      ($12.ListGroupContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.ListGroupContributionsResponse.fromBuffer(value));
  static final _$updateContribution = $grpc.ClientMethod<
          $12.UpdateContributionRequest, $12.UpdateContributionResponse>(
      '/pb.GroupAccountService/UpdateContribution',
      ($12.UpdateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.UpdateContributionResponse.fromBuffer(value));
  static final _$deleteContribution = $grpc.ClientMethod<
          $12.DeleteContributionRequest, $12.DeleteContributionResponse>(
      '/pb.GroupAccountService/DeleteContribution',
      ($12.DeleteContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.DeleteContributionResponse.fromBuffer(value));
  static final _$makePayment =
      $grpc.ClientMethod<$12.MakePaymentRequest, $12.MakePaymentResponse>(
          '/pb.GroupAccountService/MakePayment',
          ($12.MakePaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.MakePaymentResponse.fromBuffer(value));
  static final _$getContributionPayments = $grpc.ClientMethod<
          $12.GetContributionPaymentsRequest,
          $12.GetContributionPaymentsResponse>(
      '/pb.GroupAccountService/GetContributionPayments',
      ($12.GetContributionPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetContributionPaymentsResponse.fromBuffer(value));
  static final _$updatePaymentStatus = $grpc.ClientMethod<
          $12.UpdatePaymentStatusRequest, $12.UpdatePaymentStatusResponse>(
      '/pb.GroupAccountService/UpdatePaymentStatus',
      ($12.UpdatePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.UpdatePaymentStatusResponse.fromBuffer(value));
  static final _$processScheduledPayments = $grpc.ClientMethod<
          $12.ProcessScheduledPaymentsRequest,
          $12.ProcessScheduledPaymentsResponse>(
      '/pb.GroupAccountService/ProcessScheduledPayments',
      ($12.ProcessScheduledPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.ProcessScheduledPaymentsResponse.fromBuffer(value));
  static final _$getOverdueContributions = $grpc.ClientMethod<
          $12.GetOverdueContributionsRequest,
          $12.GetOverdueContributionsResponse>(
      '/pb.GroupAccountService/GetOverdueContributions',
      ($12.GetOverdueContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetOverdueContributionsResponse.fromBuffer(value));
  static final _$getPayoutSchedule = $grpc.ClientMethod<
          $12.GetPayoutScheduleRequest, $12.GetPayoutScheduleResponse>(
      '/pb.GroupAccountService/GetPayoutSchedule',
      ($12.GetPayoutScheduleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetPayoutScheduleResponse.fromBuffer(value));
  static final _$processPayout =
      $grpc.ClientMethod<$12.ProcessPayoutRequest, $12.ProcessPayoutResponse>(
          '/pb.GroupAccountService/ProcessPayout',
          ($12.ProcessPayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.ProcessPayoutResponse.fromBuffer(value));
  static final _$updatePayoutStatus = $grpc.ClientMethod<
          $12.UpdatePayoutStatusRequest, $12.UpdatePayoutStatusResponse>(
      '/pb.GroupAccountService/UpdatePayoutStatus',
      ($12.UpdatePayoutStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.UpdatePayoutStatusResponse.fromBuffer(value));
  static final _$advancePayoutRotation = $grpc.ClientMethod<
          $12.AdvancePayoutRotationRequest, $12.AdvancePayoutRotationResponse>(
      '/pb.GroupAccountService/AdvancePayoutRotation',
      ($12.AdvancePayoutRotationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.AdvancePayoutRotationResponse.fromBuffer(value));
  static final _$generateReceipt = $grpc.ClientMethod<
          $12.GenerateReceiptRequest, $12.GenerateReceiptResponse>(
      '/pb.GroupAccountService/GenerateReceipt',
      ($12.GenerateReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GenerateReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<
          $12.GetUserContributionReceiptsRequest,
          $12.GetUserContributionReceiptsResponse>(
      '/pb.GroupAccountService/GetUserReceipts',
      ($12.GetUserContributionReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetUserContributionReceiptsResponse.fromBuffer(value));
  static final _$generateTranscript = $grpc.ClientMethod<
          $12.GenerateTranscriptRequest, $12.GenerateTranscriptResponse>(
      '/pb.GroupAccountService/GenerateTranscript',
      ($12.GenerateTranscriptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GenerateTranscriptResponse.fromBuffer(value));
  static final _$getGroupStatistics = $grpc.ClientMethod<
          $12.GetGroupStatisticsRequest, $12.GetGroupStatisticsResponse>(
      '/pb.GroupAccountService/GetGroupStatistics',
      ($12.GetGroupStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetGroupStatisticsResponse.fromBuffer(value));
  static final _$getUserContributionStats = $grpc.ClientMethod<
          $12.GetUserContributionStatsRequest,
          $12.GetUserContributionStatsResponse>(
      '/pb.GroupAccountService/GetUserContributionStats',
      ($12.GetUserContributionStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetUserContributionStatsResponse.fromBuffer(value));
  static final _$getContributionAnalytics = $grpc.ClientMethod<
          $12.GetContributionAnalyticsRequest,
          $12.GetContributionAnalyticsResponse>(
      '/pb.GroupAccountService/GetContributionAnalytics',
      ($12.GetContributionAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetContributionAnalyticsResponse.fromBuffer(value));

  GroupAccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$12.CreateGroupResponse> createGroup(
      $12.CreateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroup, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetGroupResponse> getGroup(
      $12.GetGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroup, request, options: options);
  }

  $grpc.ResponseFuture<$12.ListUserGroupsResponse> listUserGroups(
      $12.ListUserGroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listUserGroups, request, options: options);
  }

  $grpc.ResponseFuture<$12.UpdateGroupResponse> updateGroup(
      $12.UpdateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateGroup, request, options: options);
  }

  $grpc.ResponseFuture<$12.DeleteGroupResponse> deleteGroup(
      $12.DeleteGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteGroup, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetGroupMembersResponse> getGroupMembers(
      $12.GetGroupMembersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupMembers, request, options: options);
  }

  $grpc.ResponseFuture<$12.AddMemberResponse> addMember(
      $12.AddMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMember, request, options: options);
  }

  $grpc.ResponseFuture<$12.UpdateMemberRoleResponse> updateMemberRole(
      $12.UpdateMemberRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMemberRole, request, options: options);
  }

  $grpc.ResponseFuture<$12.RemoveMemberResponse> removeMember(
      $12.RemoveMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeMember, request, options: options);
  }

  $grpc.ResponseFuture<$12.SearchUsersResponse> searchUsers(
      $12.SearchUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$12.CreateContributionResponse> createContribution(
      $12.CreateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createContribution, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetContributionResponse> getContribution(
      $12.GetContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContribution, request, options: options);
  }

  $grpc.ResponseFuture<$12.ListGroupContributionsResponse>
      listGroupContributions($12.ListGroupContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listGroupContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$12.UpdateContributionResponse> updateContribution(
      $12.UpdateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateContribution, request, options: options);
  }

  $grpc.ResponseFuture<$12.DeleteContributionResponse> deleteContribution(
      $12.DeleteContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteContribution, request, options: options);
  }

  $grpc.ResponseFuture<$12.MakePaymentResponse> makePayment(
      $12.MakePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makePayment, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetContributionPaymentsResponse>
      getContributionPayments($12.GetContributionPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$12.UpdatePaymentStatusResponse> updatePaymentStatus(
      $12.UpdatePaymentStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$12.ProcessScheduledPaymentsResponse>
      processScheduledPayments($12.ProcessScheduledPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processScheduledPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$12.GetOverdueContributionsResponse>
      getOverdueContributions($12.GetOverdueContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$12.GetPayoutScheduleResponse> getPayoutSchedule(
      $12.GetPayoutScheduleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutSchedule, request, options: options);
  }

  $grpc.ResponseFuture<$12.ProcessPayoutResponse> processPayout(
      $12.ProcessPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayout, request, options: options);
  }

  $grpc.ResponseFuture<$12.UpdatePayoutStatusResponse> updatePayoutStatus(
      $12.UpdatePayoutStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePayoutStatus, request, options: options);
  }

  $grpc.ResponseFuture<$12.AdvancePayoutRotationResponse> advancePayoutRotation(
      $12.AdvancePayoutRotationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$advancePayoutRotation, request, options: options);
  }

  $grpc.ResponseFuture<$12.GenerateReceiptResponse> generateReceipt(
      $12.GenerateReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetUserContributionReceiptsResponse> getUserReceipts(
      $12.GetUserContributionReceiptsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$12.GenerateTranscriptResponse> generateTranscript(
      $12.GenerateTranscriptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateTranscript, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetGroupStatisticsResponse> getGroupStatistics(
      $12.GetGroupStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetUserContributionStatsResponse>
      getUserContributionStats($12.GetUserContributionStatsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserContributionStats, request,
        options: options);
  }

  $grpc.ResponseFuture<$12.GetContributionAnalyticsResponse>
      getContributionAnalytics($12.GetContributionAnalyticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionAnalytics, request,
        options: options);
  }
}

abstract class GroupAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GroupAccountService';

  GroupAccountServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$12.CreateGroupRequest, $12.CreateGroupResponse>(
            'CreateGroup',
            createGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.CreateGroupRequest.fromBuffer(value),
            ($12.CreateGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetGroupRequest, $12.GetGroupResponse>(
        'GetGroup',
        getGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetGroupRequest.fromBuffer(value),
        ($12.GetGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.ListUserGroupsRequest,
            $12.ListUserGroupsResponse>(
        'ListUserGroups',
        listUserGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.ListUserGroupsRequest.fromBuffer(value),
        ($12.ListUserGroupsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.UpdateGroupRequest, $12.UpdateGroupResponse>(
            'UpdateGroup',
            updateGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.UpdateGroupRequest.fromBuffer(value),
            ($12.UpdateGroupResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.DeleteGroupRequest, $12.DeleteGroupResponse>(
            'DeleteGroup',
            deleteGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.DeleteGroupRequest.fromBuffer(value),
            ($12.DeleteGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetGroupMembersRequest,
            $12.GetGroupMembersResponse>(
        'GetGroupMembers',
        getGroupMembers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetGroupMembersRequest.fromBuffer(value),
        ($12.GetGroupMembersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.AddMemberRequest, $12.AddMemberResponse>(
        'AddMember',
        addMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.AddMemberRequest.fromBuffer(value),
        ($12.AddMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdateMemberRoleRequest,
            $12.UpdateMemberRoleResponse>(
        'UpdateMemberRole',
        updateMemberRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.UpdateMemberRoleRequest.fromBuffer(value),
        ($12.UpdateMemberRoleResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.RemoveMemberRequest, $12.RemoveMemberResponse>(
            'RemoveMember',
            removeMember_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.RemoveMemberRequest.fromBuffer(value),
            ($12.RemoveMemberResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.SearchUsersRequest, $12.SearchUsersResponse>(
            'SearchUsers',
            searchUsers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.SearchUsersRequest.fromBuffer(value),
            ($12.SearchUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.CreateContributionRequest,
            $12.CreateContributionResponse>(
        'CreateContribution',
        createContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.CreateContributionRequest.fromBuffer(value),
        ($12.CreateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetContributionRequest,
            $12.GetContributionResponse>(
        'GetContribution',
        getContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetContributionRequest.fromBuffer(value),
        ($12.GetContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.ListGroupContributionsRequest,
            $12.ListGroupContributionsResponse>(
        'ListGroupContributions',
        listGroupContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.ListGroupContributionsRequest.fromBuffer(value),
        ($12.ListGroupContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdateContributionRequest,
            $12.UpdateContributionResponse>(
        'UpdateContribution',
        updateContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.UpdateContributionRequest.fromBuffer(value),
        ($12.UpdateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.DeleteContributionRequest,
            $12.DeleteContributionResponse>(
        'DeleteContribution',
        deleteContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.DeleteContributionRequest.fromBuffer(value),
        ($12.DeleteContributionResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.MakePaymentRequest, $12.MakePaymentResponse>(
            'MakePayment',
            makePayment_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.MakePaymentRequest.fromBuffer(value),
            ($12.MakePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetContributionPaymentsRequest,
            $12.GetContributionPaymentsResponse>(
        'GetContributionPayments',
        getContributionPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetContributionPaymentsRequest.fromBuffer(value),
        ($12.GetContributionPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdatePaymentStatusRequest,
            $12.UpdatePaymentStatusResponse>(
        'UpdatePaymentStatus',
        updatePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.UpdatePaymentStatusRequest.fromBuffer(value),
        ($12.UpdatePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.ProcessScheduledPaymentsRequest,
            $12.ProcessScheduledPaymentsResponse>(
        'ProcessScheduledPayments',
        processScheduledPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.ProcessScheduledPaymentsRequest.fromBuffer(value),
        ($12.ProcessScheduledPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetOverdueContributionsRequest,
            $12.GetOverdueContributionsResponse>(
        'GetOverdueContributions',
        getOverdueContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetOverdueContributionsRequest.fromBuffer(value),
        ($12.GetOverdueContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetPayoutScheduleRequest,
            $12.GetPayoutScheduleResponse>(
        'GetPayoutSchedule',
        getPayoutSchedule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetPayoutScheduleRequest.fromBuffer(value),
        ($12.GetPayoutScheduleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.ProcessPayoutRequest,
            $12.ProcessPayoutResponse>(
        'ProcessPayout',
        processPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.ProcessPayoutRequest.fromBuffer(value),
        ($12.ProcessPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdatePayoutStatusRequest,
            $12.UpdatePayoutStatusResponse>(
        'UpdatePayoutStatus',
        updatePayoutStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.UpdatePayoutStatusRequest.fromBuffer(value),
        ($12.UpdatePayoutStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.AdvancePayoutRotationRequest,
            $12.AdvancePayoutRotationResponse>(
        'AdvancePayoutRotation',
        advancePayoutRotation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.AdvancePayoutRotationRequest.fromBuffer(value),
        ($12.AdvancePayoutRotationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GenerateReceiptRequest,
            $12.GenerateReceiptResponse>(
        'GenerateReceipt',
        generateReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GenerateReceiptRequest.fromBuffer(value),
        ($12.GenerateReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetUserContributionReceiptsRequest,
            $12.GetUserContributionReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetUserContributionReceiptsRequest.fromBuffer(value),
        ($12.GetUserContributionReceiptsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GenerateTranscriptRequest,
            $12.GenerateTranscriptResponse>(
        'GenerateTranscript',
        generateTranscript_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GenerateTranscriptRequest.fromBuffer(value),
        ($12.GenerateTranscriptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetGroupStatisticsRequest,
            $12.GetGroupStatisticsResponse>(
        'GetGroupStatistics',
        getGroupStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetGroupStatisticsRequest.fromBuffer(value),
        ($12.GetGroupStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetUserContributionStatsRequest,
            $12.GetUserContributionStatsResponse>(
        'GetUserContributionStats',
        getUserContributionStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetUserContributionStatsRequest.fromBuffer(value),
        ($12.GetUserContributionStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetContributionAnalyticsRequest,
            $12.GetContributionAnalyticsResponse>(
        'GetContributionAnalytics',
        getContributionAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetContributionAnalyticsRequest.fromBuffer(value),
        ($12.GetContributionAnalyticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$12.CreateGroupResponse> createGroup_Pre($grpc.ServiceCall call,
      $async.Future<$12.CreateGroupRequest> request) async {
    return createGroup(call, await request);
  }

  $async.Future<$12.GetGroupResponse> getGroup_Pre($grpc.ServiceCall call,
      $async.Future<$12.GetGroupRequest> request) async {
    return getGroup(call, await request);
  }

  $async.Future<$12.ListUserGroupsResponse> listUserGroups_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.ListUserGroupsRequest> request) async {
    return listUserGroups(call, await request);
  }

  $async.Future<$12.UpdateGroupResponse> updateGroup_Pre($grpc.ServiceCall call,
      $async.Future<$12.UpdateGroupRequest> request) async {
    return updateGroup(call, await request);
  }

  $async.Future<$12.DeleteGroupResponse> deleteGroup_Pre($grpc.ServiceCall call,
      $async.Future<$12.DeleteGroupRequest> request) async {
    return deleteGroup(call, await request);
  }

  $async.Future<$12.GetGroupMembersResponse> getGroupMembers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetGroupMembersRequest> request) async {
    return getGroupMembers(call, await request);
  }

  $async.Future<$12.AddMemberResponse> addMember_Pre($grpc.ServiceCall call,
      $async.Future<$12.AddMemberRequest> request) async {
    return addMember(call, await request);
  }

  $async.Future<$12.UpdateMemberRoleResponse> updateMemberRole_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.UpdateMemberRoleRequest> request) async {
    return updateMemberRole(call, await request);
  }

  $async.Future<$12.RemoveMemberResponse> removeMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.RemoveMemberRequest> request) async {
    return removeMember(call, await request);
  }

  $async.Future<$12.SearchUsersResponse> searchUsers_Pre($grpc.ServiceCall call,
      $async.Future<$12.SearchUsersRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$12.CreateContributionResponse> createContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.CreateContributionRequest> request) async {
    return createContribution(call, await request);
  }

  $async.Future<$12.GetContributionResponse> getContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetContributionRequest> request) async {
    return getContribution(call, await request);
  }

  $async.Future<$12.ListGroupContributionsResponse> listGroupContributions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.ListGroupContributionsRequest> request) async {
    return listGroupContributions(call, await request);
  }

  $async.Future<$12.UpdateContributionResponse> updateContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.UpdateContributionRequest> request) async {
    return updateContribution(call, await request);
  }

  $async.Future<$12.DeleteContributionResponse> deleteContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.DeleteContributionRequest> request) async {
    return deleteContribution(call, await request);
  }

  $async.Future<$12.MakePaymentResponse> makePayment_Pre($grpc.ServiceCall call,
      $async.Future<$12.MakePaymentRequest> request) async {
    return makePayment(call, await request);
  }

  $async.Future<$12.GetContributionPaymentsResponse>
      getContributionPayments_Pre($grpc.ServiceCall call,
          $async.Future<$12.GetContributionPaymentsRequest> request) async {
    return getContributionPayments(call, await request);
  }

  $async.Future<$12.UpdatePaymentStatusResponse> updatePaymentStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.UpdatePaymentStatusRequest> request) async {
    return updatePaymentStatus(call, await request);
  }

  $async.Future<$12.ProcessScheduledPaymentsResponse>
      processScheduledPayments_Pre($grpc.ServiceCall call,
          $async.Future<$12.ProcessScheduledPaymentsRequest> request) async {
    return processScheduledPayments(call, await request);
  }

  $async.Future<$12.GetOverdueContributionsResponse>
      getOverdueContributions_Pre($grpc.ServiceCall call,
          $async.Future<$12.GetOverdueContributionsRequest> request) async {
    return getOverdueContributions(call, await request);
  }

  $async.Future<$12.GetPayoutScheduleResponse> getPayoutSchedule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetPayoutScheduleRequest> request) async {
    return getPayoutSchedule(call, await request);
  }

  $async.Future<$12.ProcessPayoutResponse> processPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.ProcessPayoutRequest> request) async {
    return processPayout(call, await request);
  }

  $async.Future<$12.UpdatePayoutStatusResponse> updatePayoutStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.UpdatePayoutStatusRequest> request) async {
    return updatePayoutStatus(call, await request);
  }

  $async.Future<$12.AdvancePayoutRotationResponse> advancePayoutRotation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.AdvancePayoutRotationRequest> request) async {
    return advancePayoutRotation(call, await request);
  }

  $async.Future<$12.GenerateReceiptResponse> generateReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GenerateReceiptRequest> request) async {
    return generateReceipt(call, await request);
  }

  $async.Future<$12.GetUserContributionReceiptsResponse> getUserReceipts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetUserContributionReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$12.GenerateTranscriptResponse> generateTranscript_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GenerateTranscriptRequest> request) async {
    return generateTranscript(call, await request);
  }

  $async.Future<$12.GetGroupStatisticsResponse> getGroupStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetGroupStatisticsRequest> request) async {
    return getGroupStatistics(call, await request);
  }

  $async.Future<$12.GetUserContributionStatsResponse>
      getUserContributionStats_Pre($grpc.ServiceCall call,
          $async.Future<$12.GetUserContributionStatsRequest> request) async {
    return getUserContributionStats(call, await request);
  }

  $async.Future<$12.GetContributionAnalyticsResponse>
      getContributionAnalytics_Pre($grpc.ServiceCall call,
          $async.Future<$12.GetContributionAnalyticsRequest> request) async {
    return getContributionAnalytics(call, await request);
  }

  $async.Future<$12.CreateGroupResponse> createGroup(
      $grpc.ServiceCall call, $12.CreateGroupRequest request);
  $async.Future<$12.GetGroupResponse> getGroup(
      $grpc.ServiceCall call, $12.GetGroupRequest request);
  $async.Future<$12.ListUserGroupsResponse> listUserGroups(
      $grpc.ServiceCall call, $12.ListUserGroupsRequest request);
  $async.Future<$12.UpdateGroupResponse> updateGroup(
      $grpc.ServiceCall call, $12.UpdateGroupRequest request);
  $async.Future<$12.DeleteGroupResponse> deleteGroup(
      $grpc.ServiceCall call, $12.DeleteGroupRequest request);
  $async.Future<$12.GetGroupMembersResponse> getGroupMembers(
      $grpc.ServiceCall call, $12.GetGroupMembersRequest request);
  $async.Future<$12.AddMemberResponse> addMember(
      $grpc.ServiceCall call, $12.AddMemberRequest request);
  $async.Future<$12.UpdateMemberRoleResponse> updateMemberRole(
      $grpc.ServiceCall call, $12.UpdateMemberRoleRequest request);
  $async.Future<$12.RemoveMemberResponse> removeMember(
      $grpc.ServiceCall call, $12.RemoveMemberRequest request);
  $async.Future<$12.SearchUsersResponse> searchUsers(
      $grpc.ServiceCall call, $12.SearchUsersRequest request);
  $async.Future<$12.CreateContributionResponse> createContribution(
      $grpc.ServiceCall call, $12.CreateContributionRequest request);
  $async.Future<$12.GetContributionResponse> getContribution(
      $grpc.ServiceCall call, $12.GetContributionRequest request);
  $async.Future<$12.ListGroupContributionsResponse> listGroupContributions(
      $grpc.ServiceCall call, $12.ListGroupContributionsRequest request);
  $async.Future<$12.UpdateContributionResponse> updateContribution(
      $grpc.ServiceCall call, $12.UpdateContributionRequest request);
  $async.Future<$12.DeleteContributionResponse> deleteContribution(
      $grpc.ServiceCall call, $12.DeleteContributionRequest request);
  $async.Future<$12.MakePaymentResponse> makePayment(
      $grpc.ServiceCall call, $12.MakePaymentRequest request);
  $async.Future<$12.GetContributionPaymentsResponse> getContributionPayments(
      $grpc.ServiceCall call, $12.GetContributionPaymentsRequest request);
  $async.Future<$12.UpdatePaymentStatusResponse> updatePaymentStatus(
      $grpc.ServiceCall call, $12.UpdatePaymentStatusRequest request);
  $async.Future<$12.ProcessScheduledPaymentsResponse> processScheduledPayments(
      $grpc.ServiceCall call, $12.ProcessScheduledPaymentsRequest request);
  $async.Future<$12.GetOverdueContributionsResponse> getOverdueContributions(
      $grpc.ServiceCall call, $12.GetOverdueContributionsRequest request);
  $async.Future<$12.GetPayoutScheduleResponse> getPayoutSchedule(
      $grpc.ServiceCall call, $12.GetPayoutScheduleRequest request);
  $async.Future<$12.ProcessPayoutResponse> processPayout(
      $grpc.ServiceCall call, $12.ProcessPayoutRequest request);
  $async.Future<$12.UpdatePayoutStatusResponse> updatePayoutStatus(
      $grpc.ServiceCall call, $12.UpdatePayoutStatusRequest request);
  $async.Future<$12.AdvancePayoutRotationResponse> advancePayoutRotation(
      $grpc.ServiceCall call, $12.AdvancePayoutRotationRequest request);
  $async.Future<$12.GenerateReceiptResponse> generateReceipt(
      $grpc.ServiceCall call, $12.GenerateReceiptRequest request);
  $async.Future<$12.GetUserContributionReceiptsResponse> getUserReceipts(
      $grpc.ServiceCall call, $12.GetUserContributionReceiptsRequest request);
  $async.Future<$12.GenerateTranscriptResponse> generateTranscript(
      $grpc.ServiceCall call, $12.GenerateTranscriptRequest request);
  $async.Future<$12.GetGroupStatisticsResponse> getGroupStatistics(
      $grpc.ServiceCall call, $12.GetGroupStatisticsRequest request);
  $async.Future<$12.GetUserContributionStatsResponse> getUserContributionStats(
      $grpc.ServiceCall call, $12.GetUserContributionStatsRequest request);
  $async.Future<$12.GetContributionAnalyticsResponse> getContributionAnalytics(
      $grpc.ServiceCall call, $12.GetContributionAnalyticsRequest request);
}
