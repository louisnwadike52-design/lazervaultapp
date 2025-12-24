///
//  Generated code. Do not modify.
//  source: group_account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'group_account.pb.dart' as $13;
export 'group_account.pb.dart';

class GroupAccountServiceClient extends $grpc.Client {
  static final _$createGroup =
      $grpc.ClientMethod<$13.CreateGroupRequest, $13.CreateGroupResponse>(
          '/pb.GroupAccountService/CreateGroup',
          ($13.CreateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.CreateGroupResponse.fromBuffer(value));
  static final _$getGroup =
      $grpc.ClientMethod<$13.GetGroupRequest, $13.GetGroupResponse>(
          '/pb.GroupAccountService/GetGroup',
          ($13.GetGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.GetGroupResponse.fromBuffer(value));
  static final _$listUserGroups =
      $grpc.ClientMethod<$13.ListUserGroupsRequest, $13.ListUserGroupsResponse>(
          '/pb.GroupAccountService/ListUserGroups',
          ($13.ListUserGroupsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.ListUserGroupsResponse.fromBuffer(value));
  static final _$updateGroup =
      $grpc.ClientMethod<$13.UpdateGroupRequest, $13.UpdateGroupResponse>(
          '/pb.GroupAccountService/UpdateGroup',
          ($13.UpdateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.UpdateGroupResponse.fromBuffer(value));
  static final _$deleteGroup =
      $grpc.ClientMethod<$13.DeleteGroupRequest, $13.DeleteGroupResponse>(
          '/pb.GroupAccountService/DeleteGroup',
          ($13.DeleteGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.DeleteGroupResponse.fromBuffer(value));
  static final _$getGroupMembers = $grpc.ClientMethod<
          $13.GetGroupMembersRequest, $13.GetGroupMembersResponse>(
      '/pb.GroupAccountService/GetGroupMembers',
      ($13.GetGroupMembersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetGroupMembersResponse.fromBuffer(value));
  static final _$addMember =
      $grpc.ClientMethod<$13.AddMemberRequest, $13.AddMemberResponse>(
          '/pb.GroupAccountService/AddMember',
          ($13.AddMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.AddMemberResponse.fromBuffer(value));
  static final _$updateMemberRole = $grpc.ClientMethod<
          $13.UpdateMemberRoleRequest, $13.UpdateMemberRoleResponse>(
      '/pb.GroupAccountService/UpdateMemberRole',
      ($13.UpdateMemberRoleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.UpdateMemberRoleResponse.fromBuffer(value));
  static final _$removeMember =
      $grpc.ClientMethod<$13.RemoveMemberRequest, $13.RemoveMemberResponse>(
          '/pb.GroupAccountService/RemoveMember',
          ($13.RemoveMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.RemoveMemberResponse.fromBuffer(value));
  static final _$searchUsers =
      $grpc.ClientMethod<$13.SearchUsersRequest, $13.SearchUsersResponse>(
          '/pb.GroupAccountService/SearchUsers',
          ($13.SearchUsersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.SearchUsersResponse.fromBuffer(value));
  static final _$createContribution = $grpc.ClientMethod<
          $13.CreateContributionRequest, $13.CreateContributionResponse>(
      '/pb.GroupAccountService/CreateContribution',
      ($13.CreateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.CreateContributionResponse.fromBuffer(value));
  static final _$getContribution = $grpc.ClientMethod<
          $13.GetContributionRequest, $13.GetContributionResponse>(
      '/pb.GroupAccountService/GetContribution',
      ($13.GetContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetContributionResponse.fromBuffer(value));
  static final _$listGroupContributions = $grpc.ClientMethod<
          $13.ListGroupContributionsRequest,
          $13.ListGroupContributionsResponse>(
      '/pb.GroupAccountService/ListGroupContributions',
      ($13.ListGroupContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.ListGroupContributionsResponse.fromBuffer(value));
  static final _$updateContribution = $grpc.ClientMethod<
          $13.UpdateContributionRequest, $13.UpdateContributionResponse>(
      '/pb.GroupAccountService/UpdateContribution',
      ($13.UpdateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.UpdateContributionResponse.fromBuffer(value));
  static final _$deleteContribution = $grpc.ClientMethod<
          $13.DeleteContributionRequest, $13.DeleteContributionResponse>(
      '/pb.GroupAccountService/DeleteContribution',
      ($13.DeleteContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.DeleteContributionResponse.fromBuffer(value));
  static final _$makePayment =
      $grpc.ClientMethod<$13.MakePaymentRequest, $13.MakePaymentResponse>(
          '/pb.GroupAccountService/MakePayment',
          ($13.MakePaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.MakePaymentResponse.fromBuffer(value));
  static final _$getContributionPayments = $grpc.ClientMethod<
          $13.GetContributionPaymentsRequest,
          $13.GetContributionPaymentsResponse>(
      '/pb.GroupAccountService/GetContributionPayments',
      ($13.GetContributionPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetContributionPaymentsResponse.fromBuffer(value));
  static final _$updatePaymentStatus = $grpc.ClientMethod<
          $13.UpdatePaymentStatusRequest, $13.UpdatePaymentStatusResponse>(
      '/pb.GroupAccountService/UpdatePaymentStatus',
      ($13.UpdatePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.UpdatePaymentStatusResponse.fromBuffer(value));
  static final _$processScheduledPayments = $grpc.ClientMethod<
          $13.ProcessScheduledPaymentsRequest,
          $13.ProcessScheduledPaymentsResponse>(
      '/pb.GroupAccountService/ProcessScheduledPayments',
      ($13.ProcessScheduledPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.ProcessScheduledPaymentsResponse.fromBuffer(value));
  static final _$getOverdueContributions = $grpc.ClientMethod<
          $13.GetOverdueContributionsRequest,
          $13.GetOverdueContributionsResponse>(
      '/pb.GroupAccountService/GetOverdueContributions',
      ($13.GetOverdueContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetOverdueContributionsResponse.fromBuffer(value));
  static final _$getPayoutSchedule = $grpc.ClientMethod<
          $13.GetPayoutScheduleRequest, $13.GetPayoutScheduleResponse>(
      '/pb.GroupAccountService/GetPayoutSchedule',
      ($13.GetPayoutScheduleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetPayoutScheduleResponse.fromBuffer(value));
  static final _$processPayout =
      $grpc.ClientMethod<$13.ProcessPayoutRequest, $13.ProcessPayoutResponse>(
          '/pb.GroupAccountService/ProcessPayout',
          ($13.ProcessPayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $13.ProcessPayoutResponse.fromBuffer(value));
  static final _$updatePayoutStatus = $grpc.ClientMethod<
          $13.UpdatePayoutStatusRequest, $13.UpdatePayoutStatusResponse>(
      '/pb.GroupAccountService/UpdatePayoutStatus',
      ($13.UpdatePayoutStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.UpdatePayoutStatusResponse.fromBuffer(value));
  static final _$advancePayoutRotation = $grpc.ClientMethod<
          $13.AdvancePayoutRotationRequest, $13.AdvancePayoutRotationResponse>(
      '/pb.GroupAccountService/AdvancePayoutRotation',
      ($13.AdvancePayoutRotationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.AdvancePayoutRotationResponse.fromBuffer(value));
  static final _$generateReceipt = $grpc.ClientMethod<
          $13.GenerateReceiptRequest, $13.GenerateReceiptResponse>(
      '/pb.GroupAccountService/GenerateReceipt',
      ($13.GenerateReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GenerateReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<
          $13.GetUserContributionReceiptsRequest,
          $13.GetUserContributionReceiptsResponse>(
      '/pb.GroupAccountService/GetUserReceipts',
      ($13.GetUserContributionReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetUserContributionReceiptsResponse.fromBuffer(value));
  static final _$generateTranscript = $grpc.ClientMethod<
          $13.GenerateTranscriptRequest, $13.GenerateTranscriptResponse>(
      '/pb.GroupAccountService/GenerateTranscript',
      ($13.GenerateTranscriptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GenerateTranscriptResponse.fromBuffer(value));
  static final _$getGroupStatistics = $grpc.ClientMethod<
          $13.GetGroupStatisticsRequest, $13.GetGroupStatisticsResponse>(
      '/pb.GroupAccountService/GetGroupStatistics',
      ($13.GetGroupStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetGroupStatisticsResponse.fromBuffer(value));
  static final _$getUserContributionStats = $grpc.ClientMethod<
          $13.GetUserContributionStatsRequest,
          $13.GetUserContributionStatsResponse>(
      '/pb.GroupAccountService/GetUserContributionStats',
      ($13.GetUserContributionStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetUserContributionStatsResponse.fromBuffer(value));
  static final _$getContributionAnalytics = $grpc.ClientMethod<
          $13.GetContributionAnalyticsRequest,
          $13.GetContributionAnalyticsResponse>(
      '/pb.GroupAccountService/GetContributionAnalytics',
      ($13.GetContributionAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetContributionAnalyticsResponse.fromBuffer(value));

  GroupAccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$13.CreateGroupResponse> createGroup(
      $13.CreateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroup, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetGroupResponse> getGroup(
      $13.GetGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroup, request, options: options);
  }

  $grpc.ResponseFuture<$13.ListUserGroupsResponse> listUserGroups(
      $13.ListUserGroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listUserGroups, request, options: options);
  }

  $grpc.ResponseFuture<$13.UpdateGroupResponse> updateGroup(
      $13.UpdateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateGroup, request, options: options);
  }

  $grpc.ResponseFuture<$13.DeleteGroupResponse> deleteGroup(
      $13.DeleteGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteGroup, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetGroupMembersResponse> getGroupMembers(
      $13.GetGroupMembersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupMembers, request, options: options);
  }

  $grpc.ResponseFuture<$13.AddMemberResponse> addMember(
      $13.AddMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMember, request, options: options);
  }

  $grpc.ResponseFuture<$13.UpdateMemberRoleResponse> updateMemberRole(
      $13.UpdateMemberRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMemberRole, request, options: options);
  }

  $grpc.ResponseFuture<$13.RemoveMemberResponse> removeMember(
      $13.RemoveMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeMember, request, options: options);
  }

  $grpc.ResponseFuture<$13.SearchUsersResponse> searchUsers(
      $13.SearchUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$13.CreateContributionResponse> createContribution(
      $13.CreateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createContribution, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetContributionResponse> getContribution(
      $13.GetContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContribution, request, options: options);
  }

  $grpc.ResponseFuture<$13.ListGroupContributionsResponse>
      listGroupContributions($13.ListGroupContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listGroupContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$13.UpdateContributionResponse> updateContribution(
      $13.UpdateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateContribution, request, options: options);
  }

  $grpc.ResponseFuture<$13.DeleteContributionResponse> deleteContribution(
      $13.DeleteContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteContribution, request, options: options);
  }

  $grpc.ResponseFuture<$13.MakePaymentResponse> makePayment(
      $13.MakePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makePayment, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetContributionPaymentsResponse>
      getContributionPayments($13.GetContributionPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$13.UpdatePaymentStatusResponse> updatePaymentStatus(
      $13.UpdatePaymentStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$13.ProcessScheduledPaymentsResponse>
      processScheduledPayments($13.ProcessScheduledPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processScheduledPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$13.GetOverdueContributionsResponse>
      getOverdueContributions($13.GetOverdueContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$13.GetPayoutScheduleResponse> getPayoutSchedule(
      $13.GetPayoutScheduleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutSchedule, request, options: options);
  }

  $grpc.ResponseFuture<$13.ProcessPayoutResponse> processPayout(
      $13.ProcessPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayout, request, options: options);
  }

  $grpc.ResponseFuture<$13.UpdatePayoutStatusResponse> updatePayoutStatus(
      $13.UpdatePayoutStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePayoutStatus, request, options: options);
  }

  $grpc.ResponseFuture<$13.AdvancePayoutRotationResponse> advancePayoutRotation(
      $13.AdvancePayoutRotationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$advancePayoutRotation, request, options: options);
  }

  $grpc.ResponseFuture<$13.GenerateReceiptResponse> generateReceipt(
      $13.GenerateReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetUserContributionReceiptsResponse> getUserReceipts(
      $13.GetUserContributionReceiptsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$13.GenerateTranscriptResponse> generateTranscript(
      $13.GenerateTranscriptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateTranscript, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetGroupStatisticsResponse> getGroupStatistics(
      $13.GetGroupStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetUserContributionStatsResponse>
      getUserContributionStats($13.GetUserContributionStatsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserContributionStats, request,
        options: options);
  }

  $grpc.ResponseFuture<$13.GetContributionAnalyticsResponse>
      getContributionAnalytics($13.GetContributionAnalyticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionAnalytics, request,
        options: options);
  }
}

abstract class GroupAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GroupAccountService';

  GroupAccountServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$13.CreateGroupRequest, $13.CreateGroupResponse>(
            'CreateGroup',
            createGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $13.CreateGroupRequest.fromBuffer(value),
            ($13.CreateGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetGroupRequest, $13.GetGroupResponse>(
        'GetGroup',
        getGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.GetGroupRequest.fromBuffer(value),
        ($13.GetGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.ListUserGroupsRequest,
            $13.ListUserGroupsResponse>(
        'ListUserGroups',
        listUserGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.ListUserGroupsRequest.fromBuffer(value),
        ($13.ListUserGroupsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$13.UpdateGroupRequest, $13.UpdateGroupResponse>(
            'UpdateGroup',
            updateGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $13.UpdateGroupRequest.fromBuffer(value),
            ($13.UpdateGroupResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$13.DeleteGroupRequest, $13.DeleteGroupResponse>(
            'DeleteGroup',
            deleteGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $13.DeleteGroupRequest.fromBuffer(value),
            ($13.DeleteGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetGroupMembersRequest,
            $13.GetGroupMembersResponse>(
        'GetGroupMembers',
        getGroupMembers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetGroupMembersRequest.fromBuffer(value),
        ($13.GetGroupMembersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.AddMemberRequest, $13.AddMemberResponse>(
        'AddMember',
        addMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.AddMemberRequest.fromBuffer(value),
        ($13.AddMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.UpdateMemberRoleRequest,
            $13.UpdateMemberRoleResponse>(
        'UpdateMemberRole',
        updateMemberRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.UpdateMemberRoleRequest.fromBuffer(value),
        ($13.UpdateMemberRoleResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$13.RemoveMemberRequest, $13.RemoveMemberResponse>(
            'RemoveMember',
            removeMember_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $13.RemoveMemberRequest.fromBuffer(value),
            ($13.RemoveMemberResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$13.SearchUsersRequest, $13.SearchUsersResponse>(
            'SearchUsers',
            searchUsers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $13.SearchUsersRequest.fromBuffer(value),
            ($13.SearchUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.CreateContributionRequest,
            $13.CreateContributionResponse>(
        'CreateContribution',
        createContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.CreateContributionRequest.fromBuffer(value),
        ($13.CreateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetContributionRequest,
            $13.GetContributionResponse>(
        'GetContribution',
        getContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetContributionRequest.fromBuffer(value),
        ($13.GetContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.ListGroupContributionsRequest,
            $13.ListGroupContributionsResponse>(
        'ListGroupContributions',
        listGroupContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.ListGroupContributionsRequest.fromBuffer(value),
        ($13.ListGroupContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.UpdateContributionRequest,
            $13.UpdateContributionResponse>(
        'UpdateContribution',
        updateContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.UpdateContributionRequest.fromBuffer(value),
        ($13.UpdateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.DeleteContributionRequest,
            $13.DeleteContributionResponse>(
        'DeleteContribution',
        deleteContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.DeleteContributionRequest.fromBuffer(value),
        ($13.DeleteContributionResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$13.MakePaymentRequest, $13.MakePaymentResponse>(
            'MakePayment',
            makePayment_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $13.MakePaymentRequest.fromBuffer(value),
            ($13.MakePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetContributionPaymentsRequest,
            $13.GetContributionPaymentsResponse>(
        'GetContributionPayments',
        getContributionPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetContributionPaymentsRequest.fromBuffer(value),
        ($13.GetContributionPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.UpdatePaymentStatusRequest,
            $13.UpdatePaymentStatusResponse>(
        'UpdatePaymentStatus',
        updatePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.UpdatePaymentStatusRequest.fromBuffer(value),
        ($13.UpdatePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.ProcessScheduledPaymentsRequest,
            $13.ProcessScheduledPaymentsResponse>(
        'ProcessScheduledPayments',
        processScheduledPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.ProcessScheduledPaymentsRequest.fromBuffer(value),
        ($13.ProcessScheduledPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetOverdueContributionsRequest,
            $13.GetOverdueContributionsResponse>(
        'GetOverdueContributions',
        getOverdueContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetOverdueContributionsRequest.fromBuffer(value),
        ($13.GetOverdueContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetPayoutScheduleRequest,
            $13.GetPayoutScheduleResponse>(
        'GetPayoutSchedule',
        getPayoutSchedule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetPayoutScheduleRequest.fromBuffer(value),
        ($13.GetPayoutScheduleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.ProcessPayoutRequest,
            $13.ProcessPayoutResponse>(
        'ProcessPayout',
        processPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.ProcessPayoutRequest.fromBuffer(value),
        ($13.ProcessPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.UpdatePayoutStatusRequest,
            $13.UpdatePayoutStatusResponse>(
        'UpdatePayoutStatus',
        updatePayoutStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.UpdatePayoutStatusRequest.fromBuffer(value),
        ($13.UpdatePayoutStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.AdvancePayoutRotationRequest,
            $13.AdvancePayoutRotationResponse>(
        'AdvancePayoutRotation',
        advancePayoutRotation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.AdvancePayoutRotationRequest.fromBuffer(value),
        ($13.AdvancePayoutRotationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GenerateReceiptRequest,
            $13.GenerateReceiptResponse>(
        'GenerateReceipt',
        generateReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GenerateReceiptRequest.fromBuffer(value),
        ($13.GenerateReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetUserContributionReceiptsRequest,
            $13.GetUserContributionReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetUserContributionReceiptsRequest.fromBuffer(value),
        ($13.GetUserContributionReceiptsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GenerateTranscriptRequest,
            $13.GenerateTranscriptResponse>(
        'GenerateTranscript',
        generateTranscript_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GenerateTranscriptRequest.fromBuffer(value),
        ($13.GenerateTranscriptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetGroupStatisticsRequest,
            $13.GetGroupStatisticsResponse>(
        'GetGroupStatistics',
        getGroupStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetGroupStatisticsRequest.fromBuffer(value),
        ($13.GetGroupStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetUserContributionStatsRequest,
            $13.GetUserContributionStatsResponse>(
        'GetUserContributionStats',
        getUserContributionStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetUserContributionStatsRequest.fromBuffer(value),
        ($13.GetUserContributionStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetContributionAnalyticsRequest,
            $13.GetContributionAnalyticsResponse>(
        'GetContributionAnalytics',
        getContributionAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetContributionAnalyticsRequest.fromBuffer(value),
        ($13.GetContributionAnalyticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$13.CreateGroupResponse> createGroup_Pre($grpc.ServiceCall call,
      $async.Future<$13.CreateGroupRequest> request) async {
    return createGroup(call, await request);
  }

  $async.Future<$13.GetGroupResponse> getGroup_Pre($grpc.ServiceCall call,
      $async.Future<$13.GetGroupRequest> request) async {
    return getGroup(call, await request);
  }

  $async.Future<$13.ListUserGroupsResponse> listUserGroups_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.ListUserGroupsRequest> request) async {
    return listUserGroups(call, await request);
  }

  $async.Future<$13.UpdateGroupResponse> updateGroup_Pre($grpc.ServiceCall call,
      $async.Future<$13.UpdateGroupRequest> request) async {
    return updateGroup(call, await request);
  }

  $async.Future<$13.DeleteGroupResponse> deleteGroup_Pre($grpc.ServiceCall call,
      $async.Future<$13.DeleteGroupRequest> request) async {
    return deleteGroup(call, await request);
  }

  $async.Future<$13.GetGroupMembersResponse> getGroupMembers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.GetGroupMembersRequest> request) async {
    return getGroupMembers(call, await request);
  }

  $async.Future<$13.AddMemberResponse> addMember_Pre($grpc.ServiceCall call,
      $async.Future<$13.AddMemberRequest> request) async {
    return addMember(call, await request);
  }

  $async.Future<$13.UpdateMemberRoleResponse> updateMemberRole_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.UpdateMemberRoleRequest> request) async {
    return updateMemberRole(call, await request);
  }

  $async.Future<$13.RemoveMemberResponse> removeMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.RemoveMemberRequest> request) async {
    return removeMember(call, await request);
  }

  $async.Future<$13.SearchUsersResponse> searchUsers_Pre($grpc.ServiceCall call,
      $async.Future<$13.SearchUsersRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$13.CreateContributionResponse> createContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.CreateContributionRequest> request) async {
    return createContribution(call, await request);
  }

  $async.Future<$13.GetContributionResponse> getContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.GetContributionRequest> request) async {
    return getContribution(call, await request);
  }

  $async.Future<$13.ListGroupContributionsResponse> listGroupContributions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.ListGroupContributionsRequest> request) async {
    return listGroupContributions(call, await request);
  }

  $async.Future<$13.UpdateContributionResponse> updateContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.UpdateContributionRequest> request) async {
    return updateContribution(call, await request);
  }

  $async.Future<$13.DeleteContributionResponse> deleteContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.DeleteContributionRequest> request) async {
    return deleteContribution(call, await request);
  }

  $async.Future<$13.MakePaymentResponse> makePayment_Pre($grpc.ServiceCall call,
      $async.Future<$13.MakePaymentRequest> request) async {
    return makePayment(call, await request);
  }

  $async.Future<$13.GetContributionPaymentsResponse>
      getContributionPayments_Pre($grpc.ServiceCall call,
          $async.Future<$13.GetContributionPaymentsRequest> request) async {
    return getContributionPayments(call, await request);
  }

  $async.Future<$13.UpdatePaymentStatusResponse> updatePaymentStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.UpdatePaymentStatusRequest> request) async {
    return updatePaymentStatus(call, await request);
  }

  $async.Future<$13.ProcessScheduledPaymentsResponse>
      processScheduledPayments_Pre($grpc.ServiceCall call,
          $async.Future<$13.ProcessScheduledPaymentsRequest> request) async {
    return processScheduledPayments(call, await request);
  }

  $async.Future<$13.GetOverdueContributionsResponse>
      getOverdueContributions_Pre($grpc.ServiceCall call,
          $async.Future<$13.GetOverdueContributionsRequest> request) async {
    return getOverdueContributions(call, await request);
  }

  $async.Future<$13.GetPayoutScheduleResponse> getPayoutSchedule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.GetPayoutScheduleRequest> request) async {
    return getPayoutSchedule(call, await request);
  }

  $async.Future<$13.ProcessPayoutResponse> processPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.ProcessPayoutRequest> request) async {
    return processPayout(call, await request);
  }

  $async.Future<$13.UpdatePayoutStatusResponse> updatePayoutStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.UpdatePayoutStatusRequest> request) async {
    return updatePayoutStatus(call, await request);
  }

  $async.Future<$13.AdvancePayoutRotationResponse> advancePayoutRotation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.AdvancePayoutRotationRequest> request) async {
    return advancePayoutRotation(call, await request);
  }

  $async.Future<$13.GenerateReceiptResponse> generateReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.GenerateReceiptRequest> request) async {
    return generateReceipt(call, await request);
  }

  $async.Future<$13.GetUserContributionReceiptsResponse> getUserReceipts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.GetUserContributionReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$13.GenerateTranscriptResponse> generateTranscript_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.GenerateTranscriptRequest> request) async {
    return generateTranscript(call, await request);
  }

  $async.Future<$13.GetGroupStatisticsResponse> getGroupStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.GetGroupStatisticsRequest> request) async {
    return getGroupStatistics(call, await request);
  }

  $async.Future<$13.GetUserContributionStatsResponse>
      getUserContributionStats_Pre($grpc.ServiceCall call,
          $async.Future<$13.GetUserContributionStatsRequest> request) async {
    return getUserContributionStats(call, await request);
  }

  $async.Future<$13.GetContributionAnalyticsResponse>
      getContributionAnalytics_Pre($grpc.ServiceCall call,
          $async.Future<$13.GetContributionAnalyticsRequest> request) async {
    return getContributionAnalytics(call, await request);
  }

  $async.Future<$13.CreateGroupResponse> createGroup(
      $grpc.ServiceCall call, $13.CreateGroupRequest request);
  $async.Future<$13.GetGroupResponse> getGroup(
      $grpc.ServiceCall call, $13.GetGroupRequest request);
  $async.Future<$13.ListUserGroupsResponse> listUserGroups(
      $grpc.ServiceCall call, $13.ListUserGroupsRequest request);
  $async.Future<$13.UpdateGroupResponse> updateGroup(
      $grpc.ServiceCall call, $13.UpdateGroupRequest request);
  $async.Future<$13.DeleteGroupResponse> deleteGroup(
      $grpc.ServiceCall call, $13.DeleteGroupRequest request);
  $async.Future<$13.GetGroupMembersResponse> getGroupMembers(
      $grpc.ServiceCall call, $13.GetGroupMembersRequest request);
  $async.Future<$13.AddMemberResponse> addMember(
      $grpc.ServiceCall call, $13.AddMemberRequest request);
  $async.Future<$13.UpdateMemberRoleResponse> updateMemberRole(
      $grpc.ServiceCall call, $13.UpdateMemberRoleRequest request);
  $async.Future<$13.RemoveMemberResponse> removeMember(
      $grpc.ServiceCall call, $13.RemoveMemberRequest request);
  $async.Future<$13.SearchUsersResponse> searchUsers(
      $grpc.ServiceCall call, $13.SearchUsersRequest request);
  $async.Future<$13.CreateContributionResponse> createContribution(
      $grpc.ServiceCall call, $13.CreateContributionRequest request);
  $async.Future<$13.GetContributionResponse> getContribution(
      $grpc.ServiceCall call, $13.GetContributionRequest request);
  $async.Future<$13.ListGroupContributionsResponse> listGroupContributions(
      $grpc.ServiceCall call, $13.ListGroupContributionsRequest request);
  $async.Future<$13.UpdateContributionResponse> updateContribution(
      $grpc.ServiceCall call, $13.UpdateContributionRequest request);
  $async.Future<$13.DeleteContributionResponse> deleteContribution(
      $grpc.ServiceCall call, $13.DeleteContributionRequest request);
  $async.Future<$13.MakePaymentResponse> makePayment(
      $grpc.ServiceCall call, $13.MakePaymentRequest request);
  $async.Future<$13.GetContributionPaymentsResponse> getContributionPayments(
      $grpc.ServiceCall call, $13.GetContributionPaymentsRequest request);
  $async.Future<$13.UpdatePaymentStatusResponse> updatePaymentStatus(
      $grpc.ServiceCall call, $13.UpdatePaymentStatusRequest request);
  $async.Future<$13.ProcessScheduledPaymentsResponse> processScheduledPayments(
      $grpc.ServiceCall call, $13.ProcessScheduledPaymentsRequest request);
  $async.Future<$13.GetOverdueContributionsResponse> getOverdueContributions(
      $grpc.ServiceCall call, $13.GetOverdueContributionsRequest request);
  $async.Future<$13.GetPayoutScheduleResponse> getPayoutSchedule(
      $grpc.ServiceCall call, $13.GetPayoutScheduleRequest request);
  $async.Future<$13.ProcessPayoutResponse> processPayout(
      $grpc.ServiceCall call, $13.ProcessPayoutRequest request);
  $async.Future<$13.UpdatePayoutStatusResponse> updatePayoutStatus(
      $grpc.ServiceCall call, $13.UpdatePayoutStatusRequest request);
  $async.Future<$13.AdvancePayoutRotationResponse> advancePayoutRotation(
      $grpc.ServiceCall call, $13.AdvancePayoutRotationRequest request);
  $async.Future<$13.GenerateReceiptResponse> generateReceipt(
      $grpc.ServiceCall call, $13.GenerateReceiptRequest request);
  $async.Future<$13.GetUserContributionReceiptsResponse> getUserReceipts(
      $grpc.ServiceCall call, $13.GetUserContributionReceiptsRequest request);
  $async.Future<$13.GenerateTranscriptResponse> generateTranscript(
      $grpc.ServiceCall call, $13.GenerateTranscriptRequest request);
  $async.Future<$13.GetGroupStatisticsResponse> getGroupStatistics(
      $grpc.ServiceCall call, $13.GetGroupStatisticsRequest request);
  $async.Future<$13.GetUserContributionStatsResponse> getUserContributionStats(
      $grpc.ServiceCall call, $13.GetUserContributionStatsRequest request);
  $async.Future<$13.GetContributionAnalyticsResponse> getContributionAnalytics(
      $grpc.ServiceCall call, $13.GetContributionAnalyticsRequest request);
}
