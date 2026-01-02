///
//  Generated code. Do not modify.
//  source: group_account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'group_account.pb.dart' as $17;
export 'group_account.pb.dart';

class GroupAccountServiceClient extends $grpc.Client {
  static final _$createGroup =
      $grpc.ClientMethod<$17.CreateGroupRequest, $17.CreateGroupResponse>(
          '/pb.GroupAccountService/CreateGroup',
          ($17.CreateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.CreateGroupResponse.fromBuffer(value));
  static final _$getGroup =
      $grpc.ClientMethod<$17.GetGroupRequest, $17.GetGroupResponse>(
          '/pb.GroupAccountService/GetGroup',
          ($17.GetGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.GetGroupResponse.fromBuffer(value));
  static final _$listUserGroups =
      $grpc.ClientMethod<$17.ListUserGroupsRequest, $17.ListUserGroupsResponse>(
          '/pb.GroupAccountService/ListUserGroups',
          ($17.ListUserGroupsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.ListUserGroupsResponse.fromBuffer(value));
  static final _$updateGroup =
      $grpc.ClientMethod<$17.UpdateGroupRequest, $17.UpdateGroupResponse>(
          '/pb.GroupAccountService/UpdateGroup',
          ($17.UpdateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.UpdateGroupResponse.fromBuffer(value));
  static final _$deleteGroup =
      $grpc.ClientMethod<$17.DeleteGroupRequest, $17.DeleteGroupResponse>(
          '/pb.GroupAccountService/DeleteGroup',
          ($17.DeleteGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.DeleteGroupResponse.fromBuffer(value));
  static final _$getGroupMembers = $grpc.ClientMethod<
          $17.GetGroupMembersRequest, $17.GetGroupMembersResponse>(
      '/pb.GroupAccountService/GetGroupMembers',
      ($17.GetGroupMembersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetGroupMembersResponse.fromBuffer(value));
  static final _$addMember =
      $grpc.ClientMethod<$17.AddMemberRequest, $17.AddMemberResponse>(
          '/pb.GroupAccountService/AddMember',
          ($17.AddMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.AddMemberResponse.fromBuffer(value));
  static final _$updateMemberRole = $grpc.ClientMethod<
          $17.UpdateMemberRoleRequest, $17.UpdateMemberRoleResponse>(
      '/pb.GroupAccountService/UpdateMemberRole',
      ($17.UpdateMemberRoleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.UpdateMemberRoleResponse.fromBuffer(value));
  static final _$removeMember =
      $grpc.ClientMethod<$17.RemoveMemberRequest, $17.RemoveMemberResponse>(
          '/pb.GroupAccountService/RemoveMember',
          ($17.RemoveMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.RemoveMemberResponse.fromBuffer(value));
  static final _$searchUsers =
      $grpc.ClientMethod<$17.SearchUsersRequest, $17.SearchUsersResponse>(
          '/pb.GroupAccountService/SearchUsers',
          ($17.SearchUsersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.SearchUsersResponse.fromBuffer(value));
  static final _$createContribution = $grpc.ClientMethod<
          $17.CreateContributionRequest, $17.CreateContributionResponse>(
      '/pb.GroupAccountService/CreateContribution',
      ($17.CreateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.CreateContributionResponse.fromBuffer(value));
  static final _$getContribution = $grpc.ClientMethod<
          $17.GetContributionRequest, $17.GetContributionResponse>(
      '/pb.GroupAccountService/GetContribution',
      ($17.GetContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetContributionResponse.fromBuffer(value));
  static final _$listGroupContributions = $grpc.ClientMethod<
          $17.ListGroupContributionsRequest,
          $17.ListGroupContributionsResponse>(
      '/pb.GroupAccountService/ListGroupContributions',
      ($17.ListGroupContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.ListGroupContributionsResponse.fromBuffer(value));
  static final _$updateContribution = $grpc.ClientMethod<
          $17.UpdateContributionRequest, $17.UpdateContributionResponse>(
      '/pb.GroupAccountService/UpdateContribution',
      ($17.UpdateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.UpdateContributionResponse.fromBuffer(value));
  static final _$deleteContribution = $grpc.ClientMethod<
          $17.DeleteContributionRequest, $17.DeleteContributionResponse>(
      '/pb.GroupAccountService/DeleteContribution',
      ($17.DeleteContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.DeleteContributionResponse.fromBuffer(value));
  static final _$makePayment =
      $grpc.ClientMethod<$17.MakePaymentRequest, $17.MakePaymentResponse>(
          '/pb.GroupAccountService/MakePayment',
          ($17.MakePaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.MakePaymentResponse.fromBuffer(value));
  static final _$getContributionPayments = $grpc.ClientMethod<
          $17.GetContributionPaymentsRequest,
          $17.GetContributionPaymentsResponse>(
      '/pb.GroupAccountService/GetContributionPayments',
      ($17.GetContributionPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetContributionPaymentsResponse.fromBuffer(value));
  static final _$updatePaymentStatus = $grpc.ClientMethod<
          $17.UpdatePaymentStatusRequest, $17.UpdatePaymentStatusResponse>(
      '/pb.GroupAccountService/UpdatePaymentStatus',
      ($17.UpdatePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.UpdatePaymentStatusResponse.fromBuffer(value));
  static final _$processScheduledPayments = $grpc.ClientMethod<
          $17.ProcessScheduledPaymentsRequest,
          $17.ProcessScheduledPaymentsResponse>(
      '/pb.GroupAccountService/ProcessScheduledPayments',
      ($17.ProcessScheduledPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.ProcessScheduledPaymentsResponse.fromBuffer(value));
  static final _$getOverdueContributions = $grpc.ClientMethod<
          $17.GetOverdueContributionsRequest,
          $17.GetOverdueContributionsResponse>(
      '/pb.GroupAccountService/GetOverdueContributions',
      ($17.GetOverdueContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetOverdueContributionsResponse.fromBuffer(value));
  static final _$getPayoutSchedule = $grpc.ClientMethod<
          $17.GetPayoutScheduleRequest, $17.GetPayoutScheduleResponse>(
      '/pb.GroupAccountService/GetPayoutSchedule',
      ($17.GetPayoutScheduleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetPayoutScheduleResponse.fromBuffer(value));
  static final _$processPayout =
      $grpc.ClientMethod<$17.ProcessPayoutRequest, $17.ProcessPayoutResponse>(
          '/pb.GroupAccountService/ProcessPayout',
          ($17.ProcessPayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.ProcessPayoutResponse.fromBuffer(value));
  static final _$updatePayoutStatus = $grpc.ClientMethod<
          $17.UpdatePayoutStatusRequest, $17.UpdatePayoutStatusResponse>(
      '/pb.GroupAccountService/UpdatePayoutStatus',
      ($17.UpdatePayoutStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.UpdatePayoutStatusResponse.fromBuffer(value));
  static final _$advancePayoutRotation = $grpc.ClientMethod<
          $17.AdvancePayoutRotationRequest, $17.AdvancePayoutRotationResponse>(
      '/pb.GroupAccountService/AdvancePayoutRotation',
      ($17.AdvancePayoutRotationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.AdvancePayoutRotationResponse.fromBuffer(value));
  static final _$generateReceipt = $grpc.ClientMethod<
          $17.GenerateReceiptRequest, $17.GenerateReceiptResponse>(
      '/pb.GroupAccountService/GenerateReceipt',
      ($17.GenerateReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GenerateReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<
          $17.GetUserContributionReceiptsRequest,
          $17.GetUserContributionReceiptsResponse>(
      '/pb.GroupAccountService/GetUserReceipts',
      ($17.GetUserContributionReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetUserContributionReceiptsResponse.fromBuffer(value));
  static final _$generateTranscript = $grpc.ClientMethod<
          $17.GenerateTranscriptRequest, $17.GenerateTranscriptResponse>(
      '/pb.GroupAccountService/GenerateTranscript',
      ($17.GenerateTranscriptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GenerateTranscriptResponse.fromBuffer(value));
  static final _$getGroupStatistics = $grpc.ClientMethod<
          $17.GetGroupStatisticsRequest, $17.GetGroupStatisticsResponse>(
      '/pb.GroupAccountService/GetGroupStatistics',
      ($17.GetGroupStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetGroupStatisticsResponse.fromBuffer(value));
  static final _$getUserContributionStats = $grpc.ClientMethod<
          $17.GetUserContributionStatsRequest,
          $17.GetUserContributionStatsResponse>(
      '/pb.GroupAccountService/GetUserContributionStats',
      ($17.GetUserContributionStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetUserContributionStatsResponse.fromBuffer(value));
  static final _$getContributionAnalytics = $grpc.ClientMethod<
          $17.GetContributionAnalyticsRequest,
          $17.GetContributionAnalyticsResponse>(
      '/pb.GroupAccountService/GetContributionAnalytics',
      ($17.GetContributionAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetContributionAnalyticsResponse.fromBuffer(value));

  GroupAccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$17.CreateGroupResponse> createGroup(
      $17.CreateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroup, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetGroupResponse> getGroup(
      $17.GetGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroup, request, options: options);
  }

  $grpc.ResponseFuture<$17.ListUserGroupsResponse> listUserGroups(
      $17.ListUserGroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listUserGroups, request, options: options);
  }

  $grpc.ResponseFuture<$17.UpdateGroupResponse> updateGroup(
      $17.UpdateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateGroup, request, options: options);
  }

  $grpc.ResponseFuture<$17.DeleteGroupResponse> deleteGroup(
      $17.DeleteGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteGroup, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetGroupMembersResponse> getGroupMembers(
      $17.GetGroupMembersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupMembers, request, options: options);
  }

  $grpc.ResponseFuture<$17.AddMemberResponse> addMember(
      $17.AddMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMember, request, options: options);
  }

  $grpc.ResponseFuture<$17.UpdateMemberRoleResponse> updateMemberRole(
      $17.UpdateMemberRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMemberRole, request, options: options);
  }

  $grpc.ResponseFuture<$17.RemoveMemberResponse> removeMember(
      $17.RemoveMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeMember, request, options: options);
  }

  $grpc.ResponseFuture<$17.SearchUsersResponse> searchUsers(
      $17.SearchUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$17.CreateContributionResponse> createContribution(
      $17.CreateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createContribution, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetContributionResponse> getContribution(
      $17.GetContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContribution, request, options: options);
  }

  $grpc.ResponseFuture<$17.ListGroupContributionsResponse>
      listGroupContributions($17.ListGroupContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listGroupContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$17.UpdateContributionResponse> updateContribution(
      $17.UpdateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateContribution, request, options: options);
  }

  $grpc.ResponseFuture<$17.DeleteContributionResponse> deleteContribution(
      $17.DeleteContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteContribution, request, options: options);
  }

  $grpc.ResponseFuture<$17.MakePaymentResponse> makePayment(
      $17.MakePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makePayment, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetContributionPaymentsResponse>
      getContributionPayments($17.GetContributionPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$17.UpdatePaymentStatusResponse> updatePaymentStatus(
      $17.UpdatePaymentStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$17.ProcessScheduledPaymentsResponse>
      processScheduledPayments($17.ProcessScheduledPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processScheduledPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$17.GetOverdueContributionsResponse>
      getOverdueContributions($17.GetOverdueContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$17.GetPayoutScheduleResponse> getPayoutSchedule(
      $17.GetPayoutScheduleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutSchedule, request, options: options);
  }

  $grpc.ResponseFuture<$17.ProcessPayoutResponse> processPayout(
      $17.ProcessPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayout, request, options: options);
  }

  $grpc.ResponseFuture<$17.UpdatePayoutStatusResponse> updatePayoutStatus(
      $17.UpdatePayoutStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePayoutStatus, request, options: options);
  }

  $grpc.ResponseFuture<$17.AdvancePayoutRotationResponse> advancePayoutRotation(
      $17.AdvancePayoutRotationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$advancePayoutRotation, request, options: options);
  }

  $grpc.ResponseFuture<$17.GenerateReceiptResponse> generateReceipt(
      $17.GenerateReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetUserContributionReceiptsResponse> getUserReceipts(
      $17.GetUserContributionReceiptsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$17.GenerateTranscriptResponse> generateTranscript(
      $17.GenerateTranscriptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateTranscript, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetGroupStatisticsResponse> getGroupStatistics(
      $17.GetGroupStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetUserContributionStatsResponse>
      getUserContributionStats($17.GetUserContributionStatsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserContributionStats, request,
        options: options);
  }

  $grpc.ResponseFuture<$17.GetContributionAnalyticsResponse>
      getContributionAnalytics($17.GetContributionAnalyticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionAnalytics, request,
        options: options);
  }
}

abstract class GroupAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GroupAccountService';

  GroupAccountServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$17.CreateGroupRequest, $17.CreateGroupResponse>(
            'CreateGroup',
            createGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.CreateGroupRequest.fromBuffer(value),
            ($17.CreateGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetGroupRequest, $17.GetGroupResponse>(
        'GetGroup',
        getGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $17.GetGroupRequest.fromBuffer(value),
        ($17.GetGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.ListUserGroupsRequest,
            $17.ListUserGroupsResponse>(
        'ListUserGroups',
        listUserGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.ListUserGroupsRequest.fromBuffer(value),
        ($17.ListUserGroupsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.UpdateGroupRequest, $17.UpdateGroupResponse>(
            'UpdateGroup',
            updateGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.UpdateGroupRequest.fromBuffer(value),
            ($17.UpdateGroupResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.DeleteGroupRequest, $17.DeleteGroupResponse>(
            'DeleteGroup',
            deleteGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.DeleteGroupRequest.fromBuffer(value),
            ($17.DeleteGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetGroupMembersRequest,
            $17.GetGroupMembersResponse>(
        'GetGroupMembers',
        getGroupMembers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetGroupMembersRequest.fromBuffer(value),
        ($17.GetGroupMembersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.AddMemberRequest, $17.AddMemberResponse>(
        'AddMember',
        addMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $17.AddMemberRequest.fromBuffer(value),
        ($17.AddMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.UpdateMemberRoleRequest,
            $17.UpdateMemberRoleResponse>(
        'UpdateMemberRole',
        updateMemberRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.UpdateMemberRoleRequest.fromBuffer(value),
        ($17.UpdateMemberRoleResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.RemoveMemberRequest, $17.RemoveMemberResponse>(
            'RemoveMember',
            removeMember_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.RemoveMemberRequest.fromBuffer(value),
            ($17.RemoveMemberResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.SearchUsersRequest, $17.SearchUsersResponse>(
            'SearchUsers',
            searchUsers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.SearchUsersRequest.fromBuffer(value),
            ($17.SearchUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.CreateContributionRequest,
            $17.CreateContributionResponse>(
        'CreateContribution',
        createContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.CreateContributionRequest.fromBuffer(value),
        ($17.CreateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetContributionRequest,
            $17.GetContributionResponse>(
        'GetContribution',
        getContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetContributionRequest.fromBuffer(value),
        ($17.GetContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.ListGroupContributionsRequest,
            $17.ListGroupContributionsResponse>(
        'ListGroupContributions',
        listGroupContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.ListGroupContributionsRequest.fromBuffer(value),
        ($17.ListGroupContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.UpdateContributionRequest,
            $17.UpdateContributionResponse>(
        'UpdateContribution',
        updateContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.UpdateContributionRequest.fromBuffer(value),
        ($17.UpdateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.DeleteContributionRequest,
            $17.DeleteContributionResponse>(
        'DeleteContribution',
        deleteContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.DeleteContributionRequest.fromBuffer(value),
        ($17.DeleteContributionResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.MakePaymentRequest, $17.MakePaymentResponse>(
            'MakePayment',
            makePayment_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.MakePaymentRequest.fromBuffer(value),
            ($17.MakePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetContributionPaymentsRequest,
            $17.GetContributionPaymentsResponse>(
        'GetContributionPayments',
        getContributionPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetContributionPaymentsRequest.fromBuffer(value),
        ($17.GetContributionPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.UpdatePaymentStatusRequest,
            $17.UpdatePaymentStatusResponse>(
        'UpdatePaymentStatus',
        updatePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.UpdatePaymentStatusRequest.fromBuffer(value),
        ($17.UpdatePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.ProcessScheduledPaymentsRequest,
            $17.ProcessScheduledPaymentsResponse>(
        'ProcessScheduledPayments',
        processScheduledPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.ProcessScheduledPaymentsRequest.fromBuffer(value),
        ($17.ProcessScheduledPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetOverdueContributionsRequest,
            $17.GetOverdueContributionsResponse>(
        'GetOverdueContributions',
        getOverdueContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetOverdueContributionsRequest.fromBuffer(value),
        ($17.GetOverdueContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetPayoutScheduleRequest,
            $17.GetPayoutScheduleResponse>(
        'GetPayoutSchedule',
        getPayoutSchedule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetPayoutScheduleRequest.fromBuffer(value),
        ($17.GetPayoutScheduleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.ProcessPayoutRequest,
            $17.ProcessPayoutResponse>(
        'ProcessPayout',
        processPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.ProcessPayoutRequest.fromBuffer(value),
        ($17.ProcessPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.UpdatePayoutStatusRequest,
            $17.UpdatePayoutStatusResponse>(
        'UpdatePayoutStatus',
        updatePayoutStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.UpdatePayoutStatusRequest.fromBuffer(value),
        ($17.UpdatePayoutStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.AdvancePayoutRotationRequest,
            $17.AdvancePayoutRotationResponse>(
        'AdvancePayoutRotation',
        advancePayoutRotation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.AdvancePayoutRotationRequest.fromBuffer(value),
        ($17.AdvancePayoutRotationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GenerateReceiptRequest,
            $17.GenerateReceiptResponse>(
        'GenerateReceipt',
        generateReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GenerateReceiptRequest.fromBuffer(value),
        ($17.GenerateReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetUserContributionReceiptsRequest,
            $17.GetUserContributionReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetUserContributionReceiptsRequest.fromBuffer(value),
        ($17.GetUserContributionReceiptsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GenerateTranscriptRequest,
            $17.GenerateTranscriptResponse>(
        'GenerateTranscript',
        generateTranscript_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GenerateTranscriptRequest.fromBuffer(value),
        ($17.GenerateTranscriptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetGroupStatisticsRequest,
            $17.GetGroupStatisticsResponse>(
        'GetGroupStatistics',
        getGroupStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetGroupStatisticsRequest.fromBuffer(value),
        ($17.GetGroupStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetUserContributionStatsRequest,
            $17.GetUserContributionStatsResponse>(
        'GetUserContributionStats',
        getUserContributionStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetUserContributionStatsRequest.fromBuffer(value),
        ($17.GetUserContributionStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetContributionAnalyticsRequest,
            $17.GetContributionAnalyticsResponse>(
        'GetContributionAnalytics',
        getContributionAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetContributionAnalyticsRequest.fromBuffer(value),
        ($17.GetContributionAnalyticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$17.CreateGroupResponse> createGroup_Pre($grpc.ServiceCall call,
      $async.Future<$17.CreateGroupRequest> request) async {
    return createGroup(call, await request);
  }

  $async.Future<$17.GetGroupResponse> getGroup_Pre($grpc.ServiceCall call,
      $async.Future<$17.GetGroupRequest> request) async {
    return getGroup(call, await request);
  }

  $async.Future<$17.ListUserGroupsResponse> listUserGroups_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.ListUserGroupsRequest> request) async {
    return listUserGroups(call, await request);
  }

  $async.Future<$17.UpdateGroupResponse> updateGroup_Pre($grpc.ServiceCall call,
      $async.Future<$17.UpdateGroupRequest> request) async {
    return updateGroup(call, await request);
  }

  $async.Future<$17.DeleteGroupResponse> deleteGroup_Pre($grpc.ServiceCall call,
      $async.Future<$17.DeleteGroupRequest> request) async {
    return deleteGroup(call, await request);
  }

  $async.Future<$17.GetGroupMembersResponse> getGroupMembers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetGroupMembersRequest> request) async {
    return getGroupMembers(call, await request);
  }

  $async.Future<$17.AddMemberResponse> addMember_Pre($grpc.ServiceCall call,
      $async.Future<$17.AddMemberRequest> request) async {
    return addMember(call, await request);
  }

  $async.Future<$17.UpdateMemberRoleResponse> updateMemberRole_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.UpdateMemberRoleRequest> request) async {
    return updateMemberRole(call, await request);
  }

  $async.Future<$17.RemoveMemberResponse> removeMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.RemoveMemberRequest> request) async {
    return removeMember(call, await request);
  }

  $async.Future<$17.SearchUsersResponse> searchUsers_Pre($grpc.ServiceCall call,
      $async.Future<$17.SearchUsersRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$17.CreateContributionResponse> createContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.CreateContributionRequest> request) async {
    return createContribution(call, await request);
  }

  $async.Future<$17.GetContributionResponse> getContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetContributionRequest> request) async {
    return getContribution(call, await request);
  }

  $async.Future<$17.ListGroupContributionsResponse> listGroupContributions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.ListGroupContributionsRequest> request) async {
    return listGroupContributions(call, await request);
  }

  $async.Future<$17.UpdateContributionResponse> updateContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.UpdateContributionRequest> request) async {
    return updateContribution(call, await request);
  }

  $async.Future<$17.DeleteContributionResponse> deleteContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.DeleteContributionRequest> request) async {
    return deleteContribution(call, await request);
  }

  $async.Future<$17.MakePaymentResponse> makePayment_Pre($grpc.ServiceCall call,
      $async.Future<$17.MakePaymentRequest> request) async {
    return makePayment(call, await request);
  }

  $async.Future<$17.GetContributionPaymentsResponse>
      getContributionPayments_Pre($grpc.ServiceCall call,
          $async.Future<$17.GetContributionPaymentsRequest> request) async {
    return getContributionPayments(call, await request);
  }

  $async.Future<$17.UpdatePaymentStatusResponse> updatePaymentStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.UpdatePaymentStatusRequest> request) async {
    return updatePaymentStatus(call, await request);
  }

  $async.Future<$17.ProcessScheduledPaymentsResponse>
      processScheduledPayments_Pre($grpc.ServiceCall call,
          $async.Future<$17.ProcessScheduledPaymentsRequest> request) async {
    return processScheduledPayments(call, await request);
  }

  $async.Future<$17.GetOverdueContributionsResponse>
      getOverdueContributions_Pre($grpc.ServiceCall call,
          $async.Future<$17.GetOverdueContributionsRequest> request) async {
    return getOverdueContributions(call, await request);
  }

  $async.Future<$17.GetPayoutScheduleResponse> getPayoutSchedule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetPayoutScheduleRequest> request) async {
    return getPayoutSchedule(call, await request);
  }

  $async.Future<$17.ProcessPayoutResponse> processPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.ProcessPayoutRequest> request) async {
    return processPayout(call, await request);
  }

  $async.Future<$17.UpdatePayoutStatusResponse> updatePayoutStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.UpdatePayoutStatusRequest> request) async {
    return updatePayoutStatus(call, await request);
  }

  $async.Future<$17.AdvancePayoutRotationResponse> advancePayoutRotation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.AdvancePayoutRotationRequest> request) async {
    return advancePayoutRotation(call, await request);
  }

  $async.Future<$17.GenerateReceiptResponse> generateReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GenerateReceiptRequest> request) async {
    return generateReceipt(call, await request);
  }

  $async.Future<$17.GetUserContributionReceiptsResponse> getUserReceipts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetUserContributionReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$17.GenerateTranscriptResponse> generateTranscript_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GenerateTranscriptRequest> request) async {
    return generateTranscript(call, await request);
  }

  $async.Future<$17.GetGroupStatisticsResponse> getGroupStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetGroupStatisticsRequest> request) async {
    return getGroupStatistics(call, await request);
  }

  $async.Future<$17.GetUserContributionStatsResponse>
      getUserContributionStats_Pre($grpc.ServiceCall call,
          $async.Future<$17.GetUserContributionStatsRequest> request) async {
    return getUserContributionStats(call, await request);
  }

  $async.Future<$17.GetContributionAnalyticsResponse>
      getContributionAnalytics_Pre($grpc.ServiceCall call,
          $async.Future<$17.GetContributionAnalyticsRequest> request) async {
    return getContributionAnalytics(call, await request);
  }

  $async.Future<$17.CreateGroupResponse> createGroup(
      $grpc.ServiceCall call, $17.CreateGroupRequest request);
  $async.Future<$17.GetGroupResponse> getGroup(
      $grpc.ServiceCall call, $17.GetGroupRequest request);
  $async.Future<$17.ListUserGroupsResponse> listUserGroups(
      $grpc.ServiceCall call, $17.ListUserGroupsRequest request);
  $async.Future<$17.UpdateGroupResponse> updateGroup(
      $grpc.ServiceCall call, $17.UpdateGroupRequest request);
  $async.Future<$17.DeleteGroupResponse> deleteGroup(
      $grpc.ServiceCall call, $17.DeleteGroupRequest request);
  $async.Future<$17.GetGroupMembersResponse> getGroupMembers(
      $grpc.ServiceCall call, $17.GetGroupMembersRequest request);
  $async.Future<$17.AddMemberResponse> addMember(
      $grpc.ServiceCall call, $17.AddMemberRequest request);
  $async.Future<$17.UpdateMemberRoleResponse> updateMemberRole(
      $grpc.ServiceCall call, $17.UpdateMemberRoleRequest request);
  $async.Future<$17.RemoveMemberResponse> removeMember(
      $grpc.ServiceCall call, $17.RemoveMemberRequest request);
  $async.Future<$17.SearchUsersResponse> searchUsers(
      $grpc.ServiceCall call, $17.SearchUsersRequest request);
  $async.Future<$17.CreateContributionResponse> createContribution(
      $grpc.ServiceCall call, $17.CreateContributionRequest request);
  $async.Future<$17.GetContributionResponse> getContribution(
      $grpc.ServiceCall call, $17.GetContributionRequest request);
  $async.Future<$17.ListGroupContributionsResponse> listGroupContributions(
      $grpc.ServiceCall call, $17.ListGroupContributionsRequest request);
  $async.Future<$17.UpdateContributionResponse> updateContribution(
      $grpc.ServiceCall call, $17.UpdateContributionRequest request);
  $async.Future<$17.DeleteContributionResponse> deleteContribution(
      $grpc.ServiceCall call, $17.DeleteContributionRequest request);
  $async.Future<$17.MakePaymentResponse> makePayment(
      $grpc.ServiceCall call, $17.MakePaymentRequest request);
  $async.Future<$17.GetContributionPaymentsResponse> getContributionPayments(
      $grpc.ServiceCall call, $17.GetContributionPaymentsRequest request);
  $async.Future<$17.UpdatePaymentStatusResponse> updatePaymentStatus(
      $grpc.ServiceCall call, $17.UpdatePaymentStatusRequest request);
  $async.Future<$17.ProcessScheduledPaymentsResponse> processScheduledPayments(
      $grpc.ServiceCall call, $17.ProcessScheduledPaymentsRequest request);
  $async.Future<$17.GetOverdueContributionsResponse> getOverdueContributions(
      $grpc.ServiceCall call, $17.GetOverdueContributionsRequest request);
  $async.Future<$17.GetPayoutScheduleResponse> getPayoutSchedule(
      $grpc.ServiceCall call, $17.GetPayoutScheduleRequest request);
  $async.Future<$17.ProcessPayoutResponse> processPayout(
      $grpc.ServiceCall call, $17.ProcessPayoutRequest request);
  $async.Future<$17.UpdatePayoutStatusResponse> updatePayoutStatus(
      $grpc.ServiceCall call, $17.UpdatePayoutStatusRequest request);
  $async.Future<$17.AdvancePayoutRotationResponse> advancePayoutRotation(
      $grpc.ServiceCall call, $17.AdvancePayoutRotationRequest request);
  $async.Future<$17.GenerateReceiptResponse> generateReceipt(
      $grpc.ServiceCall call, $17.GenerateReceiptRequest request);
  $async.Future<$17.GetUserContributionReceiptsResponse> getUserReceipts(
      $grpc.ServiceCall call, $17.GetUserContributionReceiptsRequest request);
  $async.Future<$17.GenerateTranscriptResponse> generateTranscript(
      $grpc.ServiceCall call, $17.GenerateTranscriptRequest request);
  $async.Future<$17.GetGroupStatisticsResponse> getGroupStatistics(
      $grpc.ServiceCall call, $17.GetGroupStatisticsRequest request);
  $async.Future<$17.GetUserContributionStatsResponse> getUserContributionStats(
      $grpc.ServiceCall call, $17.GetUserContributionStatsRequest request);
  $async.Future<$17.GetContributionAnalyticsResponse> getContributionAnalytics(
      $grpc.ServiceCall call, $17.GetContributionAnalyticsRequest request);
}
