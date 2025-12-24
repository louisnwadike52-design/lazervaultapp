///
//  Generated code. Do not modify.
//  source: group_account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'group_account.pb.dart' as $14;
export 'group_account.pb.dart';

class GroupAccountServiceClient extends $grpc.Client {
  static final _$createGroup =
      $grpc.ClientMethod<$14.CreateGroupRequest, $14.CreateGroupResponse>(
          '/pb.GroupAccountService/CreateGroup',
          ($14.CreateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.CreateGroupResponse.fromBuffer(value));
  static final _$getGroup =
      $grpc.ClientMethod<$14.GetGroupRequest, $14.GetGroupResponse>(
          '/pb.GroupAccountService/GetGroup',
          ($14.GetGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.GetGroupResponse.fromBuffer(value));
  static final _$listUserGroups =
      $grpc.ClientMethod<$14.ListUserGroupsRequest, $14.ListUserGroupsResponse>(
          '/pb.GroupAccountService/ListUserGroups',
          ($14.ListUserGroupsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.ListUserGroupsResponse.fromBuffer(value));
  static final _$updateGroup =
      $grpc.ClientMethod<$14.UpdateGroupRequest, $14.UpdateGroupResponse>(
          '/pb.GroupAccountService/UpdateGroup',
          ($14.UpdateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.UpdateGroupResponse.fromBuffer(value));
  static final _$deleteGroup =
      $grpc.ClientMethod<$14.DeleteGroupRequest, $14.DeleteGroupResponse>(
          '/pb.GroupAccountService/DeleteGroup',
          ($14.DeleteGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.DeleteGroupResponse.fromBuffer(value));
  static final _$getGroupMembers = $grpc.ClientMethod<
          $14.GetGroupMembersRequest, $14.GetGroupMembersResponse>(
      '/pb.GroupAccountService/GetGroupMembers',
      ($14.GetGroupMembersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GetGroupMembersResponse.fromBuffer(value));
  static final _$addMember =
      $grpc.ClientMethod<$14.AddMemberRequest, $14.AddMemberResponse>(
          '/pb.GroupAccountService/AddMember',
          ($14.AddMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.AddMemberResponse.fromBuffer(value));
  static final _$updateMemberRole = $grpc.ClientMethod<
          $14.UpdateMemberRoleRequest, $14.UpdateMemberRoleResponse>(
      '/pb.GroupAccountService/UpdateMemberRole',
      ($14.UpdateMemberRoleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.UpdateMemberRoleResponse.fromBuffer(value));
  static final _$removeMember =
      $grpc.ClientMethod<$14.RemoveMemberRequest, $14.RemoveMemberResponse>(
          '/pb.GroupAccountService/RemoveMember',
          ($14.RemoveMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.RemoveMemberResponse.fromBuffer(value));
  static final _$searchUsers =
      $grpc.ClientMethod<$14.SearchUsersRequest, $14.SearchUsersResponse>(
          '/pb.GroupAccountService/SearchUsers',
          ($14.SearchUsersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.SearchUsersResponse.fromBuffer(value));
  static final _$createContribution = $grpc.ClientMethod<
          $14.CreateContributionRequest, $14.CreateContributionResponse>(
      '/pb.GroupAccountService/CreateContribution',
      ($14.CreateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.CreateContributionResponse.fromBuffer(value));
  static final _$getContribution = $grpc.ClientMethod<
          $14.GetContributionRequest, $14.GetContributionResponse>(
      '/pb.GroupAccountService/GetContribution',
      ($14.GetContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GetContributionResponse.fromBuffer(value));
  static final _$listGroupContributions = $grpc.ClientMethod<
          $14.ListGroupContributionsRequest,
          $14.ListGroupContributionsResponse>(
      '/pb.GroupAccountService/ListGroupContributions',
      ($14.ListGroupContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.ListGroupContributionsResponse.fromBuffer(value));
  static final _$updateContribution = $grpc.ClientMethod<
          $14.UpdateContributionRequest, $14.UpdateContributionResponse>(
      '/pb.GroupAccountService/UpdateContribution',
      ($14.UpdateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.UpdateContributionResponse.fromBuffer(value));
  static final _$deleteContribution = $grpc.ClientMethod<
          $14.DeleteContributionRequest, $14.DeleteContributionResponse>(
      '/pb.GroupAccountService/DeleteContribution',
      ($14.DeleteContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.DeleteContributionResponse.fromBuffer(value));
  static final _$makePayment =
      $grpc.ClientMethod<$14.MakePaymentRequest, $14.MakePaymentResponse>(
          '/pb.GroupAccountService/MakePayment',
          ($14.MakePaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.MakePaymentResponse.fromBuffer(value));
  static final _$getContributionPayments = $grpc.ClientMethod<
          $14.GetContributionPaymentsRequest,
          $14.GetContributionPaymentsResponse>(
      '/pb.GroupAccountService/GetContributionPayments',
      ($14.GetContributionPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GetContributionPaymentsResponse.fromBuffer(value));
  static final _$updatePaymentStatus = $grpc.ClientMethod<
          $14.UpdatePaymentStatusRequest, $14.UpdatePaymentStatusResponse>(
      '/pb.GroupAccountService/UpdatePaymentStatus',
      ($14.UpdatePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.UpdatePaymentStatusResponse.fromBuffer(value));
  static final _$processScheduledPayments = $grpc.ClientMethod<
          $14.ProcessScheduledPaymentsRequest,
          $14.ProcessScheduledPaymentsResponse>(
      '/pb.GroupAccountService/ProcessScheduledPayments',
      ($14.ProcessScheduledPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.ProcessScheduledPaymentsResponse.fromBuffer(value));
  static final _$getOverdueContributions = $grpc.ClientMethod<
          $14.GetOverdueContributionsRequest,
          $14.GetOverdueContributionsResponse>(
      '/pb.GroupAccountService/GetOverdueContributions',
      ($14.GetOverdueContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GetOverdueContributionsResponse.fromBuffer(value));
  static final _$getPayoutSchedule = $grpc.ClientMethod<
          $14.GetPayoutScheduleRequest, $14.GetPayoutScheduleResponse>(
      '/pb.GroupAccountService/GetPayoutSchedule',
      ($14.GetPayoutScheduleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GetPayoutScheduleResponse.fromBuffer(value));
  static final _$processPayout =
      $grpc.ClientMethod<$14.ProcessPayoutRequest, $14.ProcessPayoutResponse>(
          '/pb.GroupAccountService/ProcessPayout',
          ($14.ProcessPayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.ProcessPayoutResponse.fromBuffer(value));
  static final _$updatePayoutStatus = $grpc.ClientMethod<
          $14.UpdatePayoutStatusRequest, $14.UpdatePayoutStatusResponse>(
      '/pb.GroupAccountService/UpdatePayoutStatus',
      ($14.UpdatePayoutStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.UpdatePayoutStatusResponse.fromBuffer(value));
  static final _$advancePayoutRotation = $grpc.ClientMethod<
          $14.AdvancePayoutRotationRequest, $14.AdvancePayoutRotationResponse>(
      '/pb.GroupAccountService/AdvancePayoutRotation',
      ($14.AdvancePayoutRotationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.AdvancePayoutRotationResponse.fromBuffer(value));
  static final _$generateReceipt = $grpc.ClientMethod<
          $14.GenerateReceiptRequest, $14.GenerateReceiptResponse>(
      '/pb.GroupAccountService/GenerateReceipt',
      ($14.GenerateReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GenerateReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<
          $14.GetUserContributionReceiptsRequest,
          $14.GetUserContributionReceiptsResponse>(
      '/pb.GroupAccountService/GetUserReceipts',
      ($14.GetUserContributionReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GetUserContributionReceiptsResponse.fromBuffer(value));
  static final _$generateTranscript = $grpc.ClientMethod<
          $14.GenerateTranscriptRequest, $14.GenerateTranscriptResponse>(
      '/pb.GroupAccountService/GenerateTranscript',
      ($14.GenerateTranscriptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GenerateTranscriptResponse.fromBuffer(value));
  static final _$getGroupStatistics = $grpc.ClientMethod<
          $14.GetGroupStatisticsRequest, $14.GetGroupStatisticsResponse>(
      '/pb.GroupAccountService/GetGroupStatistics',
      ($14.GetGroupStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GetGroupStatisticsResponse.fromBuffer(value));
  static final _$getUserContributionStats = $grpc.ClientMethod<
          $14.GetUserContributionStatsRequest,
          $14.GetUserContributionStatsResponse>(
      '/pb.GroupAccountService/GetUserContributionStats',
      ($14.GetUserContributionStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GetUserContributionStatsResponse.fromBuffer(value));
  static final _$getContributionAnalytics = $grpc.ClientMethod<
          $14.GetContributionAnalyticsRequest,
          $14.GetContributionAnalyticsResponse>(
      '/pb.GroupAccountService/GetContributionAnalytics',
      ($14.GetContributionAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GetContributionAnalyticsResponse.fromBuffer(value));

  GroupAccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$14.CreateGroupResponse> createGroup(
      $14.CreateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroup, request, options: options);
  }

  $grpc.ResponseFuture<$14.GetGroupResponse> getGroup(
      $14.GetGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroup, request, options: options);
  }

  $grpc.ResponseFuture<$14.ListUserGroupsResponse> listUserGroups(
      $14.ListUserGroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listUserGroups, request, options: options);
  }

  $grpc.ResponseFuture<$14.UpdateGroupResponse> updateGroup(
      $14.UpdateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateGroup, request, options: options);
  }

  $grpc.ResponseFuture<$14.DeleteGroupResponse> deleteGroup(
      $14.DeleteGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteGroup, request, options: options);
  }

  $grpc.ResponseFuture<$14.GetGroupMembersResponse> getGroupMembers(
      $14.GetGroupMembersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupMembers, request, options: options);
  }

  $grpc.ResponseFuture<$14.AddMemberResponse> addMember(
      $14.AddMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMember, request, options: options);
  }

  $grpc.ResponseFuture<$14.UpdateMemberRoleResponse> updateMemberRole(
      $14.UpdateMemberRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMemberRole, request, options: options);
  }

  $grpc.ResponseFuture<$14.RemoveMemberResponse> removeMember(
      $14.RemoveMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeMember, request, options: options);
  }

  $grpc.ResponseFuture<$14.SearchUsersResponse> searchUsers(
      $14.SearchUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$14.CreateContributionResponse> createContribution(
      $14.CreateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createContribution, request, options: options);
  }

  $grpc.ResponseFuture<$14.GetContributionResponse> getContribution(
      $14.GetContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContribution, request, options: options);
  }

  $grpc.ResponseFuture<$14.ListGroupContributionsResponse>
      listGroupContributions($14.ListGroupContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listGroupContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$14.UpdateContributionResponse> updateContribution(
      $14.UpdateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateContribution, request, options: options);
  }

  $grpc.ResponseFuture<$14.DeleteContributionResponse> deleteContribution(
      $14.DeleteContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteContribution, request, options: options);
  }

  $grpc.ResponseFuture<$14.MakePaymentResponse> makePayment(
      $14.MakePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makePayment, request, options: options);
  }

  $grpc.ResponseFuture<$14.GetContributionPaymentsResponse>
      getContributionPayments($14.GetContributionPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$14.UpdatePaymentStatusResponse> updatePaymentStatus(
      $14.UpdatePaymentStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$14.ProcessScheduledPaymentsResponse>
      processScheduledPayments($14.ProcessScheduledPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processScheduledPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$14.GetOverdueContributionsResponse>
      getOverdueContributions($14.GetOverdueContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$14.GetPayoutScheduleResponse> getPayoutSchedule(
      $14.GetPayoutScheduleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutSchedule, request, options: options);
  }

  $grpc.ResponseFuture<$14.ProcessPayoutResponse> processPayout(
      $14.ProcessPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayout, request, options: options);
  }

  $grpc.ResponseFuture<$14.UpdatePayoutStatusResponse> updatePayoutStatus(
      $14.UpdatePayoutStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePayoutStatus, request, options: options);
  }

  $grpc.ResponseFuture<$14.AdvancePayoutRotationResponse> advancePayoutRotation(
      $14.AdvancePayoutRotationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$advancePayoutRotation, request, options: options);
  }

  $grpc.ResponseFuture<$14.GenerateReceiptResponse> generateReceipt(
      $14.GenerateReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$14.GetUserContributionReceiptsResponse> getUserReceipts(
      $14.GetUserContributionReceiptsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$14.GenerateTranscriptResponse> generateTranscript(
      $14.GenerateTranscriptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateTranscript, request, options: options);
  }

  $grpc.ResponseFuture<$14.GetGroupStatisticsResponse> getGroupStatistics(
      $14.GetGroupStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$14.GetUserContributionStatsResponse>
      getUserContributionStats($14.GetUserContributionStatsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserContributionStats, request,
        options: options);
  }

  $grpc.ResponseFuture<$14.GetContributionAnalyticsResponse>
      getContributionAnalytics($14.GetContributionAnalyticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionAnalytics, request,
        options: options);
  }
}

abstract class GroupAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GroupAccountService';

  GroupAccountServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$14.CreateGroupRequest, $14.CreateGroupResponse>(
            'CreateGroup',
            createGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $14.CreateGroupRequest.fromBuffer(value),
            ($14.CreateGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetGroupRequest, $14.GetGroupResponse>(
        'GetGroup',
        getGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $14.GetGroupRequest.fromBuffer(value),
        ($14.GetGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.ListUserGroupsRequest,
            $14.ListUserGroupsResponse>(
        'ListUserGroups',
        listUserGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.ListUserGroupsRequest.fromBuffer(value),
        ($14.ListUserGroupsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$14.UpdateGroupRequest, $14.UpdateGroupResponse>(
            'UpdateGroup',
            updateGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $14.UpdateGroupRequest.fromBuffer(value),
            ($14.UpdateGroupResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$14.DeleteGroupRequest, $14.DeleteGroupResponse>(
            'DeleteGroup',
            deleteGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $14.DeleteGroupRequest.fromBuffer(value),
            ($14.DeleteGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetGroupMembersRequest,
            $14.GetGroupMembersResponse>(
        'GetGroupMembers',
        getGroupMembers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GetGroupMembersRequest.fromBuffer(value),
        ($14.GetGroupMembersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.AddMemberRequest, $14.AddMemberResponse>(
        'AddMember',
        addMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $14.AddMemberRequest.fromBuffer(value),
        ($14.AddMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.UpdateMemberRoleRequest,
            $14.UpdateMemberRoleResponse>(
        'UpdateMemberRole',
        updateMemberRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.UpdateMemberRoleRequest.fromBuffer(value),
        ($14.UpdateMemberRoleResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$14.RemoveMemberRequest, $14.RemoveMemberResponse>(
            'RemoveMember',
            removeMember_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $14.RemoveMemberRequest.fromBuffer(value),
            ($14.RemoveMemberResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$14.SearchUsersRequest, $14.SearchUsersResponse>(
            'SearchUsers',
            searchUsers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $14.SearchUsersRequest.fromBuffer(value),
            ($14.SearchUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.CreateContributionRequest,
            $14.CreateContributionResponse>(
        'CreateContribution',
        createContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.CreateContributionRequest.fromBuffer(value),
        ($14.CreateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetContributionRequest,
            $14.GetContributionResponse>(
        'GetContribution',
        getContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GetContributionRequest.fromBuffer(value),
        ($14.GetContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.ListGroupContributionsRequest,
            $14.ListGroupContributionsResponse>(
        'ListGroupContributions',
        listGroupContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.ListGroupContributionsRequest.fromBuffer(value),
        ($14.ListGroupContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.UpdateContributionRequest,
            $14.UpdateContributionResponse>(
        'UpdateContribution',
        updateContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.UpdateContributionRequest.fromBuffer(value),
        ($14.UpdateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.DeleteContributionRequest,
            $14.DeleteContributionResponse>(
        'DeleteContribution',
        deleteContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.DeleteContributionRequest.fromBuffer(value),
        ($14.DeleteContributionResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$14.MakePaymentRequest, $14.MakePaymentResponse>(
            'MakePayment',
            makePayment_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $14.MakePaymentRequest.fromBuffer(value),
            ($14.MakePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetContributionPaymentsRequest,
            $14.GetContributionPaymentsResponse>(
        'GetContributionPayments',
        getContributionPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GetContributionPaymentsRequest.fromBuffer(value),
        ($14.GetContributionPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.UpdatePaymentStatusRequest,
            $14.UpdatePaymentStatusResponse>(
        'UpdatePaymentStatus',
        updatePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.UpdatePaymentStatusRequest.fromBuffer(value),
        ($14.UpdatePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.ProcessScheduledPaymentsRequest,
            $14.ProcessScheduledPaymentsResponse>(
        'ProcessScheduledPayments',
        processScheduledPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.ProcessScheduledPaymentsRequest.fromBuffer(value),
        ($14.ProcessScheduledPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetOverdueContributionsRequest,
            $14.GetOverdueContributionsResponse>(
        'GetOverdueContributions',
        getOverdueContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GetOverdueContributionsRequest.fromBuffer(value),
        ($14.GetOverdueContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetPayoutScheduleRequest,
            $14.GetPayoutScheduleResponse>(
        'GetPayoutSchedule',
        getPayoutSchedule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GetPayoutScheduleRequest.fromBuffer(value),
        ($14.GetPayoutScheduleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.ProcessPayoutRequest,
            $14.ProcessPayoutResponse>(
        'ProcessPayout',
        processPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.ProcessPayoutRequest.fromBuffer(value),
        ($14.ProcessPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.UpdatePayoutStatusRequest,
            $14.UpdatePayoutStatusResponse>(
        'UpdatePayoutStatus',
        updatePayoutStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.UpdatePayoutStatusRequest.fromBuffer(value),
        ($14.UpdatePayoutStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.AdvancePayoutRotationRequest,
            $14.AdvancePayoutRotationResponse>(
        'AdvancePayoutRotation',
        advancePayoutRotation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.AdvancePayoutRotationRequest.fromBuffer(value),
        ($14.AdvancePayoutRotationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GenerateReceiptRequest,
            $14.GenerateReceiptResponse>(
        'GenerateReceipt',
        generateReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GenerateReceiptRequest.fromBuffer(value),
        ($14.GenerateReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetUserContributionReceiptsRequest,
            $14.GetUserContributionReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GetUserContributionReceiptsRequest.fromBuffer(value),
        ($14.GetUserContributionReceiptsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GenerateTranscriptRequest,
            $14.GenerateTranscriptResponse>(
        'GenerateTranscript',
        generateTranscript_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GenerateTranscriptRequest.fromBuffer(value),
        ($14.GenerateTranscriptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetGroupStatisticsRequest,
            $14.GetGroupStatisticsResponse>(
        'GetGroupStatistics',
        getGroupStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GetGroupStatisticsRequest.fromBuffer(value),
        ($14.GetGroupStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetUserContributionStatsRequest,
            $14.GetUserContributionStatsResponse>(
        'GetUserContributionStats',
        getUserContributionStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GetUserContributionStatsRequest.fromBuffer(value),
        ($14.GetUserContributionStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetContributionAnalyticsRequest,
            $14.GetContributionAnalyticsResponse>(
        'GetContributionAnalytics',
        getContributionAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GetContributionAnalyticsRequest.fromBuffer(value),
        ($14.GetContributionAnalyticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$14.CreateGroupResponse> createGroup_Pre($grpc.ServiceCall call,
      $async.Future<$14.CreateGroupRequest> request) async {
    return createGroup(call, await request);
  }

  $async.Future<$14.GetGroupResponse> getGroup_Pre($grpc.ServiceCall call,
      $async.Future<$14.GetGroupRequest> request) async {
    return getGroup(call, await request);
  }

  $async.Future<$14.ListUserGroupsResponse> listUserGroups_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.ListUserGroupsRequest> request) async {
    return listUserGroups(call, await request);
  }

  $async.Future<$14.UpdateGroupResponse> updateGroup_Pre($grpc.ServiceCall call,
      $async.Future<$14.UpdateGroupRequest> request) async {
    return updateGroup(call, await request);
  }

  $async.Future<$14.DeleteGroupResponse> deleteGroup_Pre($grpc.ServiceCall call,
      $async.Future<$14.DeleteGroupRequest> request) async {
    return deleteGroup(call, await request);
  }

  $async.Future<$14.GetGroupMembersResponse> getGroupMembers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.GetGroupMembersRequest> request) async {
    return getGroupMembers(call, await request);
  }

  $async.Future<$14.AddMemberResponse> addMember_Pre($grpc.ServiceCall call,
      $async.Future<$14.AddMemberRequest> request) async {
    return addMember(call, await request);
  }

  $async.Future<$14.UpdateMemberRoleResponse> updateMemberRole_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.UpdateMemberRoleRequest> request) async {
    return updateMemberRole(call, await request);
  }

  $async.Future<$14.RemoveMemberResponse> removeMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.RemoveMemberRequest> request) async {
    return removeMember(call, await request);
  }

  $async.Future<$14.SearchUsersResponse> searchUsers_Pre($grpc.ServiceCall call,
      $async.Future<$14.SearchUsersRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$14.CreateContributionResponse> createContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.CreateContributionRequest> request) async {
    return createContribution(call, await request);
  }

  $async.Future<$14.GetContributionResponse> getContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.GetContributionRequest> request) async {
    return getContribution(call, await request);
  }

  $async.Future<$14.ListGroupContributionsResponse> listGroupContributions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.ListGroupContributionsRequest> request) async {
    return listGroupContributions(call, await request);
  }

  $async.Future<$14.UpdateContributionResponse> updateContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.UpdateContributionRequest> request) async {
    return updateContribution(call, await request);
  }

  $async.Future<$14.DeleteContributionResponse> deleteContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.DeleteContributionRequest> request) async {
    return deleteContribution(call, await request);
  }

  $async.Future<$14.MakePaymentResponse> makePayment_Pre($grpc.ServiceCall call,
      $async.Future<$14.MakePaymentRequest> request) async {
    return makePayment(call, await request);
  }

  $async.Future<$14.GetContributionPaymentsResponse>
      getContributionPayments_Pre($grpc.ServiceCall call,
          $async.Future<$14.GetContributionPaymentsRequest> request) async {
    return getContributionPayments(call, await request);
  }

  $async.Future<$14.UpdatePaymentStatusResponse> updatePaymentStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.UpdatePaymentStatusRequest> request) async {
    return updatePaymentStatus(call, await request);
  }

  $async.Future<$14.ProcessScheduledPaymentsResponse>
      processScheduledPayments_Pre($grpc.ServiceCall call,
          $async.Future<$14.ProcessScheduledPaymentsRequest> request) async {
    return processScheduledPayments(call, await request);
  }

  $async.Future<$14.GetOverdueContributionsResponse>
      getOverdueContributions_Pre($grpc.ServiceCall call,
          $async.Future<$14.GetOverdueContributionsRequest> request) async {
    return getOverdueContributions(call, await request);
  }

  $async.Future<$14.GetPayoutScheduleResponse> getPayoutSchedule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.GetPayoutScheduleRequest> request) async {
    return getPayoutSchedule(call, await request);
  }

  $async.Future<$14.ProcessPayoutResponse> processPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.ProcessPayoutRequest> request) async {
    return processPayout(call, await request);
  }

  $async.Future<$14.UpdatePayoutStatusResponse> updatePayoutStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.UpdatePayoutStatusRequest> request) async {
    return updatePayoutStatus(call, await request);
  }

  $async.Future<$14.AdvancePayoutRotationResponse> advancePayoutRotation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.AdvancePayoutRotationRequest> request) async {
    return advancePayoutRotation(call, await request);
  }

  $async.Future<$14.GenerateReceiptResponse> generateReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.GenerateReceiptRequest> request) async {
    return generateReceipt(call, await request);
  }

  $async.Future<$14.GetUserContributionReceiptsResponse> getUserReceipts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.GetUserContributionReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$14.GenerateTranscriptResponse> generateTranscript_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.GenerateTranscriptRequest> request) async {
    return generateTranscript(call, await request);
  }

  $async.Future<$14.GetGroupStatisticsResponse> getGroupStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.GetGroupStatisticsRequest> request) async {
    return getGroupStatistics(call, await request);
  }

  $async.Future<$14.GetUserContributionStatsResponse>
      getUserContributionStats_Pre($grpc.ServiceCall call,
          $async.Future<$14.GetUserContributionStatsRequest> request) async {
    return getUserContributionStats(call, await request);
  }

  $async.Future<$14.GetContributionAnalyticsResponse>
      getContributionAnalytics_Pre($grpc.ServiceCall call,
          $async.Future<$14.GetContributionAnalyticsRequest> request) async {
    return getContributionAnalytics(call, await request);
  }

  $async.Future<$14.CreateGroupResponse> createGroup(
      $grpc.ServiceCall call, $14.CreateGroupRequest request);
  $async.Future<$14.GetGroupResponse> getGroup(
      $grpc.ServiceCall call, $14.GetGroupRequest request);
  $async.Future<$14.ListUserGroupsResponse> listUserGroups(
      $grpc.ServiceCall call, $14.ListUserGroupsRequest request);
  $async.Future<$14.UpdateGroupResponse> updateGroup(
      $grpc.ServiceCall call, $14.UpdateGroupRequest request);
  $async.Future<$14.DeleteGroupResponse> deleteGroup(
      $grpc.ServiceCall call, $14.DeleteGroupRequest request);
  $async.Future<$14.GetGroupMembersResponse> getGroupMembers(
      $grpc.ServiceCall call, $14.GetGroupMembersRequest request);
  $async.Future<$14.AddMemberResponse> addMember(
      $grpc.ServiceCall call, $14.AddMemberRequest request);
  $async.Future<$14.UpdateMemberRoleResponse> updateMemberRole(
      $grpc.ServiceCall call, $14.UpdateMemberRoleRequest request);
  $async.Future<$14.RemoveMemberResponse> removeMember(
      $grpc.ServiceCall call, $14.RemoveMemberRequest request);
  $async.Future<$14.SearchUsersResponse> searchUsers(
      $grpc.ServiceCall call, $14.SearchUsersRequest request);
  $async.Future<$14.CreateContributionResponse> createContribution(
      $grpc.ServiceCall call, $14.CreateContributionRequest request);
  $async.Future<$14.GetContributionResponse> getContribution(
      $grpc.ServiceCall call, $14.GetContributionRequest request);
  $async.Future<$14.ListGroupContributionsResponse> listGroupContributions(
      $grpc.ServiceCall call, $14.ListGroupContributionsRequest request);
  $async.Future<$14.UpdateContributionResponse> updateContribution(
      $grpc.ServiceCall call, $14.UpdateContributionRequest request);
  $async.Future<$14.DeleteContributionResponse> deleteContribution(
      $grpc.ServiceCall call, $14.DeleteContributionRequest request);
  $async.Future<$14.MakePaymentResponse> makePayment(
      $grpc.ServiceCall call, $14.MakePaymentRequest request);
  $async.Future<$14.GetContributionPaymentsResponse> getContributionPayments(
      $grpc.ServiceCall call, $14.GetContributionPaymentsRequest request);
  $async.Future<$14.UpdatePaymentStatusResponse> updatePaymentStatus(
      $grpc.ServiceCall call, $14.UpdatePaymentStatusRequest request);
  $async.Future<$14.ProcessScheduledPaymentsResponse> processScheduledPayments(
      $grpc.ServiceCall call, $14.ProcessScheduledPaymentsRequest request);
  $async.Future<$14.GetOverdueContributionsResponse> getOverdueContributions(
      $grpc.ServiceCall call, $14.GetOverdueContributionsRequest request);
  $async.Future<$14.GetPayoutScheduleResponse> getPayoutSchedule(
      $grpc.ServiceCall call, $14.GetPayoutScheduleRequest request);
  $async.Future<$14.ProcessPayoutResponse> processPayout(
      $grpc.ServiceCall call, $14.ProcessPayoutRequest request);
  $async.Future<$14.UpdatePayoutStatusResponse> updatePayoutStatus(
      $grpc.ServiceCall call, $14.UpdatePayoutStatusRequest request);
  $async.Future<$14.AdvancePayoutRotationResponse> advancePayoutRotation(
      $grpc.ServiceCall call, $14.AdvancePayoutRotationRequest request);
  $async.Future<$14.GenerateReceiptResponse> generateReceipt(
      $grpc.ServiceCall call, $14.GenerateReceiptRequest request);
  $async.Future<$14.GetUserContributionReceiptsResponse> getUserReceipts(
      $grpc.ServiceCall call, $14.GetUserContributionReceiptsRequest request);
  $async.Future<$14.GenerateTranscriptResponse> generateTranscript(
      $grpc.ServiceCall call, $14.GenerateTranscriptRequest request);
  $async.Future<$14.GetGroupStatisticsResponse> getGroupStatistics(
      $grpc.ServiceCall call, $14.GetGroupStatisticsRequest request);
  $async.Future<$14.GetUserContributionStatsResponse> getUserContributionStats(
      $grpc.ServiceCall call, $14.GetUserContributionStatsRequest request);
  $async.Future<$14.GetContributionAnalyticsResponse> getContributionAnalytics(
      $grpc.ServiceCall call, $14.GetContributionAnalyticsRequest request);
}
