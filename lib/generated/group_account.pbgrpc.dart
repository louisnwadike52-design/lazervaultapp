// This is a generated file - do not edit.
//
// Generated from group_account.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'group_account.pb.dart' as $0;

export 'group_account.pb.dart';

@$pb.GrpcServiceName('pb.GroupAccountService')
class GroupAccountServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  GroupAccountServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.CreateGroupResponse> createGroup(
    $0.CreateGroupRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupResponse> getGroup(
    $0.GetGroupRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListUserGroupsResponse> listUserGroups(
    $0.ListUserGroupsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listUserGroups, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateGroupResponse> updateGroup(
    $0.UpdateGroupRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteGroupResponse> deleteGroup(
    $0.DeleteGroupRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupMembersResponse> getGroupMembers(
    $0.GetGroupMembersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getGroupMembers, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddMemberResponse> addMember(
    $0.AddMemberRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateMemberRoleResponse> updateMemberRole(
    $0.UpdateMemberRoleRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateMemberRole, request, options: options);
  }

  $grpc.ResponseFuture<$0.RemoveMemberResponse> removeMember(
    $0.RemoveMemberRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$removeMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchUsersResponse> searchUsers(
    $0.SearchUsersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateContributionResponse> createContribution(
    $0.CreateContributionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createContribution, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetContributionResponse> getContribution(
    $0.GetContributionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getContribution, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListGroupContributionsResponse>
      listGroupContributions(
    $0.ListGroupContributionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listGroupContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateContributionResponse> updateContribution(
    $0.UpdateContributionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateContribution, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteContributionResponse> deleteContribution(
    $0.DeleteContributionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteContribution, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddMembersToContributionResponse>
      addMembersToContribution(
    $0.AddMembersToContributionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addMembersToContribution, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.RemoveMemberFromContributionResponse>
      removeMemberFromContribution(
    $0.RemoveMemberFromContributionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$removeMemberFromContribution, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetContributionMembersResponse>
      getContributionMembers(
    $0.GetContributionMembersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getContributionMembers, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.MakePaymentResponse> makePayment(
    $0.MakePaymentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$makePayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetContributionPaymentsResponse>
      getContributionPayments(
    $0.GetContributionPaymentsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getContributionPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdatePaymentStatusResponse> updatePaymentStatus(
    $0.UpdatePaymentStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updatePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProcessScheduledPaymentsResponse>
      processScheduledPayments(
    $0.ProcessScheduledPaymentsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$processScheduledPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetOverdueContributionsResponse>
      getOverdueContributions(
    $0.GetOverdueContributionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOverdueContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetPayoutScheduleResponse> getPayoutSchedule(
    $0.GetPayoutScheduleRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPayoutSchedule, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProcessPayoutResponse> processPayout(
    $0.ProcessPayoutRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$processPayout, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdatePayoutStatusResponse> updatePayoutStatus(
    $0.UpdatePayoutStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updatePayoutStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdvancePayoutRotationResponse> advancePayoutRotation(
    $0.AdvancePayoutRotationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$advancePayoutRotation, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateReceiptResponse> generateReceipt(
    $0.GenerateReceiptRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$generateReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserContributionReceiptsResponse> getUserReceipts(
    $0.GetUserContributionReceiptsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateTranscriptResponse> generateTranscript(
    $0.GenerateTranscriptRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$generateTranscript, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupStatisticsResponse> getGroupStatistics(
    $0.GetGroupStatisticsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getGroupStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserContributionStatsResponse>
      getUserContributionStats(
    $0.GetUserContributionStatsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserContributionStats, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetContributionAnalyticsResponse>
      getContributionAnalytics(
    $0.GetContributionAnalyticsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getContributionAnalytics, request,
        options: options);
  }

  /// Activity Log RPCs
  $grpc.ResponseFuture<$0.GetGroupActivityLogsResponse> getGroupActivityLogs(
    $0.GetGroupActivityLogsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getGroupActivityLogs, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetContributionActivityLogsResponse>
      getContributionActivityLogs(
    $0.GetContributionActivityLogsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getContributionActivityLogs, request,
        options: options);
  }

  // method descriptors

  static final _$createGroup =
      $grpc.ClientMethod<$0.CreateGroupRequest, $0.CreateGroupResponse>(
          '/pb.GroupAccountService/CreateGroup',
          ($0.CreateGroupRequest value) => value.writeToBuffer(),
          $0.CreateGroupResponse.fromBuffer);
  static final _$getGroup =
      $grpc.ClientMethod<$0.GetGroupRequest, $0.GetGroupResponse>(
          '/pb.GroupAccountService/GetGroup',
          ($0.GetGroupRequest value) => value.writeToBuffer(),
          $0.GetGroupResponse.fromBuffer);
  static final _$listUserGroups =
      $grpc.ClientMethod<$0.ListUserGroupsRequest, $0.ListUserGroupsResponse>(
          '/pb.GroupAccountService/ListUserGroups',
          ($0.ListUserGroupsRequest value) => value.writeToBuffer(),
          $0.ListUserGroupsResponse.fromBuffer);
  static final _$updateGroup =
      $grpc.ClientMethod<$0.UpdateGroupRequest, $0.UpdateGroupResponse>(
          '/pb.GroupAccountService/UpdateGroup',
          ($0.UpdateGroupRequest value) => value.writeToBuffer(),
          $0.UpdateGroupResponse.fromBuffer);
  static final _$deleteGroup =
      $grpc.ClientMethod<$0.DeleteGroupRequest, $0.DeleteGroupResponse>(
          '/pb.GroupAccountService/DeleteGroup',
          ($0.DeleteGroupRequest value) => value.writeToBuffer(),
          $0.DeleteGroupResponse.fromBuffer);
  static final _$getGroupMembers =
      $grpc.ClientMethod<$0.GetGroupMembersRequest, $0.GetGroupMembersResponse>(
          '/pb.GroupAccountService/GetGroupMembers',
          ($0.GetGroupMembersRequest value) => value.writeToBuffer(),
          $0.GetGroupMembersResponse.fromBuffer);
  static final _$addMember =
      $grpc.ClientMethod<$0.AddMemberRequest, $0.AddMemberResponse>(
          '/pb.GroupAccountService/AddMember',
          ($0.AddMemberRequest value) => value.writeToBuffer(),
          $0.AddMemberResponse.fromBuffer);
  static final _$updateMemberRole = $grpc.ClientMethod<
          $0.UpdateMemberRoleRequest, $0.UpdateMemberRoleResponse>(
      '/pb.GroupAccountService/UpdateMemberRole',
      ($0.UpdateMemberRoleRequest value) => value.writeToBuffer(),
      $0.UpdateMemberRoleResponse.fromBuffer);
  static final _$removeMember =
      $grpc.ClientMethod<$0.RemoveMemberRequest, $0.RemoveMemberResponse>(
          '/pb.GroupAccountService/RemoveMember',
          ($0.RemoveMemberRequest value) => value.writeToBuffer(),
          $0.RemoveMemberResponse.fromBuffer);
  static final _$searchUsers =
      $grpc.ClientMethod<$0.SearchUsersRequest, $0.SearchUsersResponse>(
          '/pb.GroupAccountService/SearchUsers',
          ($0.SearchUsersRequest value) => value.writeToBuffer(),
          $0.SearchUsersResponse.fromBuffer);
  static final _$createContribution = $grpc.ClientMethod<
          $0.CreateContributionRequest, $0.CreateContributionResponse>(
      '/pb.GroupAccountService/CreateContribution',
      ($0.CreateContributionRequest value) => value.writeToBuffer(),
      $0.CreateContributionResponse.fromBuffer);
  static final _$getContribution =
      $grpc.ClientMethod<$0.GetContributionRequest, $0.GetContributionResponse>(
          '/pb.GroupAccountService/GetContribution',
          ($0.GetContributionRequest value) => value.writeToBuffer(),
          $0.GetContributionResponse.fromBuffer);
  static final _$listGroupContributions = $grpc.ClientMethod<
          $0.ListGroupContributionsRequest, $0.ListGroupContributionsResponse>(
      '/pb.GroupAccountService/ListGroupContributions',
      ($0.ListGroupContributionsRequest value) => value.writeToBuffer(),
      $0.ListGroupContributionsResponse.fromBuffer);
  static final _$updateContribution = $grpc.ClientMethod<
          $0.UpdateContributionRequest, $0.UpdateContributionResponse>(
      '/pb.GroupAccountService/UpdateContribution',
      ($0.UpdateContributionRequest value) => value.writeToBuffer(),
      $0.UpdateContributionResponse.fromBuffer);
  static final _$deleteContribution = $grpc.ClientMethod<
          $0.DeleteContributionRequest, $0.DeleteContributionResponse>(
      '/pb.GroupAccountService/DeleteContribution',
      ($0.DeleteContributionRequest value) => value.writeToBuffer(),
      $0.DeleteContributionResponse.fromBuffer);
  static final _$addMembersToContribution = $grpc.ClientMethod<
          $0.AddMembersToContributionRequest,
          $0.AddMembersToContributionResponse>(
      '/pb.GroupAccountService/AddMembersToContribution',
      ($0.AddMembersToContributionRequest value) => value.writeToBuffer(),
      $0.AddMembersToContributionResponse.fromBuffer);
  static final _$removeMemberFromContribution = $grpc.ClientMethod<
          $0.RemoveMemberFromContributionRequest,
          $0.RemoveMemberFromContributionResponse>(
      '/pb.GroupAccountService/RemoveMemberFromContribution',
      ($0.RemoveMemberFromContributionRequest value) => value.writeToBuffer(),
      $0.RemoveMemberFromContributionResponse.fromBuffer);
  static final _$getContributionMembers = $grpc.ClientMethod<
          $0.GetContributionMembersRequest, $0.GetContributionMembersResponse>(
      '/pb.GroupAccountService/GetContributionMembers',
      ($0.GetContributionMembersRequest value) => value.writeToBuffer(),
      $0.GetContributionMembersResponse.fromBuffer);
  static final _$makePayment =
      $grpc.ClientMethod<$0.MakePaymentRequest, $0.MakePaymentResponse>(
          '/pb.GroupAccountService/MakePayment',
          ($0.MakePaymentRequest value) => value.writeToBuffer(),
          $0.MakePaymentResponse.fromBuffer);
  static final _$getContributionPayments = $grpc.ClientMethod<
          $0.GetContributionPaymentsRequest,
          $0.GetContributionPaymentsResponse>(
      '/pb.GroupAccountService/GetContributionPayments',
      ($0.GetContributionPaymentsRequest value) => value.writeToBuffer(),
      $0.GetContributionPaymentsResponse.fromBuffer);
  static final _$updatePaymentStatus = $grpc.ClientMethod<
          $0.UpdatePaymentStatusRequest, $0.UpdatePaymentStatusResponse>(
      '/pb.GroupAccountService/UpdatePaymentStatus',
      ($0.UpdatePaymentStatusRequest value) => value.writeToBuffer(),
      $0.UpdatePaymentStatusResponse.fromBuffer);
  static final _$processScheduledPayments = $grpc.ClientMethod<
          $0.ProcessScheduledPaymentsRequest,
          $0.ProcessScheduledPaymentsResponse>(
      '/pb.GroupAccountService/ProcessScheduledPayments',
      ($0.ProcessScheduledPaymentsRequest value) => value.writeToBuffer(),
      $0.ProcessScheduledPaymentsResponse.fromBuffer);
  static final _$getOverdueContributions = $grpc.ClientMethod<
          $0.GetOverdueContributionsRequest,
          $0.GetOverdueContributionsResponse>(
      '/pb.GroupAccountService/GetOverdueContributions',
      ($0.GetOverdueContributionsRequest value) => value.writeToBuffer(),
      $0.GetOverdueContributionsResponse.fromBuffer);
  static final _$getPayoutSchedule = $grpc.ClientMethod<
          $0.GetPayoutScheduleRequest, $0.GetPayoutScheduleResponse>(
      '/pb.GroupAccountService/GetPayoutSchedule',
      ($0.GetPayoutScheduleRequest value) => value.writeToBuffer(),
      $0.GetPayoutScheduleResponse.fromBuffer);
  static final _$processPayout =
      $grpc.ClientMethod<$0.ProcessPayoutRequest, $0.ProcessPayoutResponse>(
          '/pb.GroupAccountService/ProcessPayout',
          ($0.ProcessPayoutRequest value) => value.writeToBuffer(),
          $0.ProcessPayoutResponse.fromBuffer);
  static final _$updatePayoutStatus = $grpc.ClientMethod<
          $0.UpdatePayoutStatusRequest, $0.UpdatePayoutStatusResponse>(
      '/pb.GroupAccountService/UpdatePayoutStatus',
      ($0.UpdatePayoutStatusRequest value) => value.writeToBuffer(),
      $0.UpdatePayoutStatusResponse.fromBuffer);
  static final _$advancePayoutRotation = $grpc.ClientMethod<
          $0.AdvancePayoutRotationRequest, $0.AdvancePayoutRotationResponse>(
      '/pb.GroupAccountService/AdvancePayoutRotation',
      ($0.AdvancePayoutRotationRequest value) => value.writeToBuffer(),
      $0.AdvancePayoutRotationResponse.fromBuffer);
  static final _$generateReceipt =
      $grpc.ClientMethod<$0.GenerateReceiptRequest, $0.GenerateReceiptResponse>(
          '/pb.GroupAccountService/GenerateReceipt',
          ($0.GenerateReceiptRequest value) => value.writeToBuffer(),
          $0.GenerateReceiptResponse.fromBuffer);
  static final _$getUserReceipts = $grpc.ClientMethod<
          $0.GetUserContributionReceiptsRequest,
          $0.GetUserContributionReceiptsResponse>(
      '/pb.GroupAccountService/GetUserReceipts',
      ($0.GetUserContributionReceiptsRequest value) => value.writeToBuffer(),
      $0.GetUserContributionReceiptsResponse.fromBuffer);
  static final _$generateTranscript = $grpc.ClientMethod<
          $0.GenerateTranscriptRequest, $0.GenerateTranscriptResponse>(
      '/pb.GroupAccountService/GenerateTranscript',
      ($0.GenerateTranscriptRequest value) => value.writeToBuffer(),
      $0.GenerateTranscriptResponse.fromBuffer);
  static final _$getGroupStatistics = $grpc.ClientMethod<
          $0.GetGroupStatisticsRequest, $0.GetGroupStatisticsResponse>(
      '/pb.GroupAccountService/GetGroupStatistics',
      ($0.GetGroupStatisticsRequest value) => value.writeToBuffer(),
      $0.GetGroupStatisticsResponse.fromBuffer);
  static final _$getUserContributionStats = $grpc.ClientMethod<
          $0.GetUserContributionStatsRequest,
          $0.GetUserContributionStatsResponse>(
      '/pb.GroupAccountService/GetUserContributionStats',
      ($0.GetUserContributionStatsRequest value) => value.writeToBuffer(),
      $0.GetUserContributionStatsResponse.fromBuffer);
  static final _$getContributionAnalytics = $grpc.ClientMethod<
          $0.GetContributionAnalyticsRequest,
          $0.GetContributionAnalyticsResponse>(
      '/pb.GroupAccountService/GetContributionAnalytics',
      ($0.GetContributionAnalyticsRequest value) => value.writeToBuffer(),
      $0.GetContributionAnalyticsResponse.fromBuffer);
  static final _$getGroupActivityLogs = $grpc.ClientMethod<
          $0.GetGroupActivityLogsRequest, $0.GetGroupActivityLogsResponse>(
      '/pb.GroupAccountService/GetGroupActivityLogs',
      ($0.GetGroupActivityLogsRequest value) => value.writeToBuffer(),
      $0.GetGroupActivityLogsResponse.fromBuffer);
  static final _$getContributionActivityLogs = $grpc.ClientMethod<
          $0.GetContributionActivityLogsRequest,
          $0.GetContributionActivityLogsResponse>(
      '/pb.GroupAccountService/GetContributionActivityLogs',
      ($0.GetContributionActivityLogsRequest value) => value.writeToBuffer(),
      $0.GetContributionActivityLogsResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.GroupAccountService')
abstract class GroupAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GroupAccountService';

  GroupAccountServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.CreateGroupRequest, $0.CreateGroupResponse>(
            'CreateGroup',
            createGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateGroupRequest.fromBuffer(value),
            ($0.CreateGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGroupRequest, $0.GetGroupResponse>(
        'GetGroup',
        getGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetGroupRequest.fromBuffer(value),
        ($0.GetGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListUserGroupsRequest,
            $0.ListUserGroupsResponse>(
        'ListUserGroups',
        listUserGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListUserGroupsRequest.fromBuffer(value),
        ($0.ListUserGroupsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.UpdateGroupRequest, $0.UpdateGroupResponse>(
            'UpdateGroup',
            updateGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UpdateGroupRequest.fromBuffer(value),
            ($0.UpdateGroupResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.DeleteGroupRequest, $0.DeleteGroupResponse>(
            'DeleteGroup',
            deleteGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.DeleteGroupRequest.fromBuffer(value),
            ($0.DeleteGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGroupMembersRequest,
            $0.GetGroupMembersResponse>(
        'GetGroupMembers',
        getGroupMembers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetGroupMembersRequest.fromBuffer(value),
        ($0.GetGroupMembersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddMemberRequest, $0.AddMemberResponse>(
        'AddMember',
        addMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddMemberRequest.fromBuffer(value),
        ($0.AddMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateMemberRoleRequest,
            $0.UpdateMemberRoleResponse>(
        'UpdateMemberRole',
        updateMemberRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateMemberRoleRequest.fromBuffer(value),
        ($0.UpdateMemberRoleResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RemoveMemberRequest, $0.RemoveMemberResponse>(
            'RemoveMember',
            removeMember_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RemoveMemberRequest.fromBuffer(value),
            ($0.RemoveMemberResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SearchUsersRequest, $0.SearchUsersResponse>(
            'SearchUsers',
            searchUsers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SearchUsersRequest.fromBuffer(value),
            ($0.SearchUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateContributionRequest,
            $0.CreateContributionResponse>(
        'CreateContribution',
        createContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateContributionRequest.fromBuffer(value),
        ($0.CreateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetContributionRequest,
            $0.GetContributionResponse>(
        'GetContribution',
        getContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetContributionRequest.fromBuffer(value),
        ($0.GetContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListGroupContributionsRequest,
            $0.ListGroupContributionsResponse>(
        'ListGroupContributions',
        listGroupContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListGroupContributionsRequest.fromBuffer(value),
        ($0.ListGroupContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateContributionRequest,
            $0.UpdateContributionResponse>(
        'UpdateContribution',
        updateContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateContributionRequest.fromBuffer(value),
        ($0.UpdateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteContributionRequest,
            $0.DeleteContributionResponse>(
        'DeleteContribution',
        deleteContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteContributionRequest.fromBuffer(value),
        ($0.DeleteContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddMembersToContributionRequest,
            $0.AddMembersToContributionResponse>(
        'AddMembersToContribution',
        addMembersToContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AddMembersToContributionRequest.fromBuffer(value),
        ($0.AddMembersToContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveMemberFromContributionRequest,
            $0.RemoveMemberFromContributionResponse>(
        'RemoveMemberFromContribution',
        removeMemberFromContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RemoveMemberFromContributionRequest.fromBuffer(value),
        ($0.RemoveMemberFromContributionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetContributionMembersRequest,
            $0.GetContributionMembersResponse>(
        'GetContributionMembers',
        getContributionMembers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetContributionMembersRequest.fromBuffer(value),
        ($0.GetContributionMembersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.MakePaymentRequest, $0.MakePaymentResponse>(
            'MakePayment',
            makePayment_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.MakePaymentRequest.fromBuffer(value),
            ($0.MakePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetContributionPaymentsRequest,
            $0.GetContributionPaymentsResponse>(
        'GetContributionPayments',
        getContributionPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetContributionPaymentsRequest.fromBuffer(value),
        ($0.GetContributionPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdatePaymentStatusRequest,
            $0.UpdatePaymentStatusResponse>(
        'UpdatePaymentStatus',
        updatePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdatePaymentStatusRequest.fromBuffer(value),
        ($0.UpdatePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessScheduledPaymentsRequest,
            $0.ProcessScheduledPaymentsResponse>(
        'ProcessScheduledPayments',
        processScheduledPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ProcessScheduledPaymentsRequest.fromBuffer(value),
        ($0.ProcessScheduledPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOverdueContributionsRequest,
            $0.GetOverdueContributionsResponse>(
        'GetOverdueContributions',
        getOverdueContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetOverdueContributionsRequest.fromBuffer(value),
        ($0.GetOverdueContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPayoutScheduleRequest,
            $0.GetPayoutScheduleResponse>(
        'GetPayoutSchedule',
        getPayoutSchedule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPayoutScheduleRequest.fromBuffer(value),
        ($0.GetPayoutScheduleResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ProcessPayoutRequest, $0.ProcessPayoutResponse>(
            'ProcessPayout',
            processPayout_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ProcessPayoutRequest.fromBuffer(value),
            ($0.ProcessPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdatePayoutStatusRequest,
            $0.UpdatePayoutStatusResponse>(
        'UpdatePayoutStatus',
        updatePayoutStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdatePayoutStatusRequest.fromBuffer(value),
        ($0.UpdatePayoutStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdvancePayoutRotationRequest,
            $0.AdvancePayoutRotationResponse>(
        'AdvancePayoutRotation',
        advancePayoutRotation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdvancePayoutRotationRequest.fromBuffer(value),
        ($0.AdvancePayoutRotationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateReceiptRequest,
            $0.GenerateReceiptResponse>(
        'GenerateReceipt',
        generateReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GenerateReceiptRequest.fromBuffer(value),
        ($0.GenerateReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserContributionReceiptsRequest,
            $0.GetUserContributionReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserContributionReceiptsRequest.fromBuffer(value),
        ($0.GetUserContributionReceiptsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateTranscriptRequest,
            $0.GenerateTranscriptResponse>(
        'GenerateTranscript',
        generateTranscript_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GenerateTranscriptRequest.fromBuffer(value),
        ($0.GenerateTranscriptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGroupStatisticsRequest,
            $0.GetGroupStatisticsResponse>(
        'GetGroupStatistics',
        getGroupStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetGroupStatisticsRequest.fromBuffer(value),
        ($0.GetGroupStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserContributionStatsRequest,
            $0.GetUserContributionStatsResponse>(
        'GetUserContributionStats',
        getUserContributionStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserContributionStatsRequest.fromBuffer(value),
        ($0.GetUserContributionStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetContributionAnalyticsRequest,
            $0.GetContributionAnalyticsResponse>(
        'GetContributionAnalytics',
        getContributionAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetContributionAnalyticsRequest.fromBuffer(value),
        ($0.GetContributionAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGroupActivityLogsRequest,
            $0.GetGroupActivityLogsResponse>(
        'GetGroupActivityLogs',
        getGroupActivityLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetGroupActivityLogsRequest.fromBuffer(value),
        ($0.GetGroupActivityLogsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetContributionActivityLogsRequest,
            $0.GetContributionActivityLogsResponse>(
        'GetContributionActivityLogs',
        getContributionActivityLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetContributionActivityLogsRequest.fromBuffer(value),
        ($0.GetContributionActivityLogsResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$0.CreateGroupResponse> createGroup_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateGroupRequest> $request) async {
    return createGroup($call, await $request);
  }

  $async.Future<$0.CreateGroupResponse> createGroup(
      $grpc.ServiceCall call, $0.CreateGroupRequest request);

  $async.Future<$0.GetGroupResponse> getGroup_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetGroupRequest> $request) async {
    return getGroup($call, await $request);
  }

  $async.Future<$0.GetGroupResponse> getGroup(
      $grpc.ServiceCall call, $0.GetGroupRequest request);

  $async.Future<$0.ListUserGroupsResponse> listUserGroups_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListUserGroupsRequest> $request) async {
    return listUserGroups($call, await $request);
  }

  $async.Future<$0.ListUserGroupsResponse> listUserGroups(
      $grpc.ServiceCall call, $0.ListUserGroupsRequest request);

  $async.Future<$0.UpdateGroupResponse> updateGroup_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateGroupRequest> $request) async {
    return updateGroup($call, await $request);
  }

  $async.Future<$0.UpdateGroupResponse> updateGroup(
      $grpc.ServiceCall call, $0.UpdateGroupRequest request);

  $async.Future<$0.DeleteGroupResponse> deleteGroup_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeleteGroupRequest> $request) async {
    return deleteGroup($call, await $request);
  }

  $async.Future<$0.DeleteGroupResponse> deleteGroup(
      $grpc.ServiceCall call, $0.DeleteGroupRequest request);

  $async.Future<$0.GetGroupMembersResponse> getGroupMembers_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetGroupMembersRequest> $request) async {
    return getGroupMembers($call, await $request);
  }

  $async.Future<$0.GetGroupMembersResponse> getGroupMembers(
      $grpc.ServiceCall call, $0.GetGroupMembersRequest request);

  $async.Future<$0.AddMemberResponse> addMember_Pre($grpc.ServiceCall $call,
      $async.Future<$0.AddMemberRequest> $request) async {
    return addMember($call, await $request);
  }

  $async.Future<$0.AddMemberResponse> addMember(
      $grpc.ServiceCall call, $0.AddMemberRequest request);

  $async.Future<$0.UpdateMemberRoleResponse> updateMemberRole_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateMemberRoleRequest> $request) async {
    return updateMemberRole($call, await $request);
  }

  $async.Future<$0.UpdateMemberRoleResponse> updateMemberRole(
      $grpc.ServiceCall call, $0.UpdateMemberRoleRequest request);

  $async.Future<$0.RemoveMemberResponse> removeMember_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RemoveMemberRequest> $request) async {
    return removeMember($call, await $request);
  }

  $async.Future<$0.RemoveMemberResponse> removeMember(
      $grpc.ServiceCall call, $0.RemoveMemberRequest request);

  $async.Future<$0.SearchUsersResponse> searchUsers_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SearchUsersRequest> $request) async {
    return searchUsers($call, await $request);
  }

  $async.Future<$0.SearchUsersResponse> searchUsers(
      $grpc.ServiceCall call, $0.SearchUsersRequest request);

  $async.Future<$0.CreateContributionResponse> createContribution_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateContributionRequest> $request) async {
    return createContribution($call, await $request);
  }

  $async.Future<$0.CreateContributionResponse> createContribution(
      $grpc.ServiceCall call, $0.CreateContributionRequest request);

  $async.Future<$0.GetContributionResponse> getContribution_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetContributionRequest> $request) async {
    return getContribution($call, await $request);
  }

  $async.Future<$0.GetContributionResponse> getContribution(
      $grpc.ServiceCall call, $0.GetContributionRequest request);

  $async.Future<$0.ListGroupContributionsResponse> listGroupContributions_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListGroupContributionsRequest> $request) async {
    return listGroupContributions($call, await $request);
  }

  $async.Future<$0.ListGroupContributionsResponse> listGroupContributions(
      $grpc.ServiceCall call, $0.ListGroupContributionsRequest request);

  $async.Future<$0.UpdateContributionResponse> updateContribution_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateContributionRequest> $request) async {
    return updateContribution($call, await $request);
  }

  $async.Future<$0.UpdateContributionResponse> updateContribution(
      $grpc.ServiceCall call, $0.UpdateContributionRequest request);

  $async.Future<$0.DeleteContributionResponse> deleteContribution_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DeleteContributionRequest> $request) async {
    return deleteContribution($call, await $request);
  }

  $async.Future<$0.DeleteContributionResponse> deleteContribution(
      $grpc.ServiceCall call, $0.DeleteContributionRequest request);

  $async.Future<$0.AddMembersToContributionResponse>
      addMembersToContribution_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AddMembersToContributionRequest> $request) async {
    return addMembersToContribution($call, await $request);
  }

  $async.Future<$0.AddMembersToContributionResponse> addMembersToContribution(
      $grpc.ServiceCall call, $0.AddMembersToContributionRequest request);

  $async.Future<$0.RemoveMemberFromContributionResponse>
      removeMemberFromContribution_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.RemoveMemberFromContributionRequest>
              $request) async {
    return removeMemberFromContribution($call, await $request);
  }

  $async.Future<$0.RemoveMemberFromContributionResponse>
      removeMemberFromContribution($grpc.ServiceCall call,
          $0.RemoveMemberFromContributionRequest request);

  $async.Future<$0.GetContributionMembersResponse> getContributionMembers_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetContributionMembersRequest> $request) async {
    return getContributionMembers($call, await $request);
  }

  $async.Future<$0.GetContributionMembersResponse> getContributionMembers(
      $grpc.ServiceCall call, $0.GetContributionMembersRequest request);

  $async.Future<$0.MakePaymentResponse> makePayment_Pre($grpc.ServiceCall $call,
      $async.Future<$0.MakePaymentRequest> $request) async {
    return makePayment($call, await $request);
  }

  $async.Future<$0.MakePaymentResponse> makePayment(
      $grpc.ServiceCall call, $0.MakePaymentRequest request);

  $async.Future<$0.GetContributionPaymentsResponse> getContributionPayments_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetContributionPaymentsRequest> $request) async {
    return getContributionPayments($call, await $request);
  }

  $async.Future<$0.GetContributionPaymentsResponse> getContributionPayments(
      $grpc.ServiceCall call, $0.GetContributionPaymentsRequest request);

  $async.Future<$0.UpdatePaymentStatusResponse> updatePaymentStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdatePaymentStatusRequest> $request) async {
    return updatePaymentStatus($call, await $request);
  }

  $async.Future<$0.UpdatePaymentStatusResponse> updatePaymentStatus(
      $grpc.ServiceCall call, $0.UpdatePaymentStatusRequest request);

  $async.Future<$0.ProcessScheduledPaymentsResponse>
      processScheduledPayments_Pre($grpc.ServiceCall $call,
          $async.Future<$0.ProcessScheduledPaymentsRequest> $request) async {
    return processScheduledPayments($call, await $request);
  }

  $async.Future<$0.ProcessScheduledPaymentsResponse> processScheduledPayments(
      $grpc.ServiceCall call, $0.ProcessScheduledPaymentsRequest request);

  $async.Future<$0.GetOverdueContributionsResponse> getOverdueContributions_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetOverdueContributionsRequest> $request) async {
    return getOverdueContributions($call, await $request);
  }

  $async.Future<$0.GetOverdueContributionsResponse> getOverdueContributions(
      $grpc.ServiceCall call, $0.GetOverdueContributionsRequest request);

  $async.Future<$0.GetPayoutScheduleResponse> getPayoutSchedule_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetPayoutScheduleRequest> $request) async {
    return getPayoutSchedule($call, await $request);
  }

  $async.Future<$0.GetPayoutScheduleResponse> getPayoutSchedule(
      $grpc.ServiceCall call, $0.GetPayoutScheduleRequest request);

  $async.Future<$0.ProcessPayoutResponse> processPayout_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ProcessPayoutRequest> $request) async {
    return processPayout($call, await $request);
  }

  $async.Future<$0.ProcessPayoutResponse> processPayout(
      $grpc.ServiceCall call, $0.ProcessPayoutRequest request);

  $async.Future<$0.UpdatePayoutStatusResponse> updatePayoutStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdatePayoutStatusRequest> $request) async {
    return updatePayoutStatus($call, await $request);
  }

  $async.Future<$0.UpdatePayoutStatusResponse> updatePayoutStatus(
      $grpc.ServiceCall call, $0.UpdatePayoutStatusRequest request);

  $async.Future<$0.AdvancePayoutRotationResponse> advancePayoutRotation_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdvancePayoutRotationRequest> $request) async {
    return advancePayoutRotation($call, await $request);
  }

  $async.Future<$0.AdvancePayoutRotationResponse> advancePayoutRotation(
      $grpc.ServiceCall call, $0.AdvancePayoutRotationRequest request);

  $async.Future<$0.GenerateReceiptResponse> generateReceipt_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GenerateReceiptRequest> $request) async {
    return generateReceipt($call, await $request);
  }

  $async.Future<$0.GenerateReceiptResponse> generateReceipt(
      $grpc.ServiceCall call, $0.GenerateReceiptRequest request);

  $async.Future<$0.GetUserContributionReceiptsResponse> getUserReceipts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserContributionReceiptsRequest> $request) async {
    return getUserReceipts($call, await $request);
  }

  $async.Future<$0.GetUserContributionReceiptsResponse> getUserReceipts(
      $grpc.ServiceCall call, $0.GetUserContributionReceiptsRequest request);

  $async.Future<$0.GenerateTranscriptResponse> generateTranscript_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GenerateTranscriptRequest> $request) async {
    return generateTranscript($call, await $request);
  }

  $async.Future<$0.GenerateTranscriptResponse> generateTranscript(
      $grpc.ServiceCall call, $0.GenerateTranscriptRequest request);

  $async.Future<$0.GetGroupStatisticsResponse> getGroupStatistics_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetGroupStatisticsRequest> $request) async {
    return getGroupStatistics($call, await $request);
  }

  $async.Future<$0.GetGroupStatisticsResponse> getGroupStatistics(
      $grpc.ServiceCall call, $0.GetGroupStatisticsRequest request);

  $async.Future<$0.GetUserContributionStatsResponse>
      getUserContributionStats_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetUserContributionStatsRequest> $request) async {
    return getUserContributionStats($call, await $request);
  }

  $async.Future<$0.GetUserContributionStatsResponse> getUserContributionStats(
      $grpc.ServiceCall call, $0.GetUserContributionStatsRequest request);

  $async.Future<$0.GetContributionAnalyticsResponse>
      getContributionAnalytics_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetContributionAnalyticsRequest> $request) async {
    return getContributionAnalytics($call, await $request);
  }

  $async.Future<$0.GetContributionAnalyticsResponse> getContributionAnalytics(
      $grpc.ServiceCall call, $0.GetContributionAnalyticsRequest request);

  $async.Future<$0.GetGroupActivityLogsResponse> getGroupActivityLogs_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetGroupActivityLogsRequest> $request) async {
    return getGroupActivityLogs($call, await $request);
  }

  $async.Future<$0.GetGroupActivityLogsResponse> getGroupActivityLogs(
      $grpc.ServiceCall call, $0.GetGroupActivityLogsRequest request);

  $async.Future<$0.GetContributionActivityLogsResponse>
      getContributionActivityLogs_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetContributionActivityLogsRequest> $request) async {
    return getContributionActivityLogs($call, await $request);
  }

  $async.Future<$0.GetContributionActivityLogsResponse>
      getContributionActivityLogs($grpc.ServiceCall call,
          $0.GetContributionActivityLogsRequest request);
}
