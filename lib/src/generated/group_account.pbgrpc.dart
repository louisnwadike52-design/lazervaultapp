///
//  Generated code. Do not modify.
//  source: group_account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'group_account.pb.dart' as $22;
export 'group_account.pb.dart';

class GroupAccountServiceClient extends $grpc.Client {
  static final _$createGroup =
      $grpc.ClientMethod<$22.CreateGroupRequest, $22.CreateGroupResponse>(
          '/group_accounts.GroupAccountService/CreateGroup',
          ($22.CreateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.CreateGroupResponse.fromBuffer(value));
  static final _$getGroup =
      $grpc.ClientMethod<$22.GetGroupRequest, $22.GetGroupResponse>(
          '/group_accounts.GroupAccountService/GetGroup',
          ($22.GetGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.GetGroupResponse.fromBuffer(value));
  static final _$listUserGroups =
      $grpc.ClientMethod<$22.ListUserGroupsRequest, $22.ListUserGroupsResponse>(
          '/group_accounts.GroupAccountService/ListUserGroups',
          ($22.ListUserGroupsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.ListUserGroupsResponse.fromBuffer(value));
  static final _$updateGroup =
      $grpc.ClientMethod<$22.UpdateGroupRequest, $22.UpdateGroupResponse>(
          '/group_accounts.GroupAccountService/UpdateGroup',
          ($22.UpdateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.UpdateGroupResponse.fromBuffer(value));
  static final _$deleteGroup =
      $grpc.ClientMethod<$22.DeleteGroupRequest, $22.DeleteGroupResponse>(
          '/group_accounts.GroupAccountService/DeleteGroup',
          ($22.DeleteGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.DeleteGroupResponse.fromBuffer(value));
  static final _$getGroupMembers = $grpc.ClientMethod<
          $22.GetGroupMembersRequest, $22.GetGroupMembersResponse>(
      '/group_accounts.GroupAccountService/GetGroupMembers',
      ($22.GetGroupMembersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetGroupMembersResponse.fromBuffer(value));
  static final _$addMember =
      $grpc.ClientMethod<$22.AddMemberRequest, $22.AddMemberResponse>(
          '/group_accounts.GroupAccountService/AddMember',
          ($22.AddMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.AddMemberResponse.fromBuffer(value));
  static final _$updateMemberRole = $grpc.ClientMethod<
          $22.UpdateMemberRoleRequest, $22.UpdateMemberRoleResponse>(
      '/group_accounts.GroupAccountService/UpdateMemberRole',
      ($22.UpdateMemberRoleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UpdateMemberRoleResponse.fromBuffer(value));
  static final _$removeMember =
      $grpc.ClientMethod<$22.RemoveMemberRequest, $22.RemoveMemberResponse>(
          '/group_accounts.GroupAccountService/RemoveMember',
          ($22.RemoveMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.RemoveMemberResponse.fromBuffer(value));
  static final _$searchUsers =
      $grpc.ClientMethod<$22.SearchUsersRequest, $22.SearchUsersResponse>(
          '/group_accounts.GroupAccountService/SearchUsers',
          ($22.SearchUsersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.SearchUsersResponse.fromBuffer(value));
  static final _$createContribution = $grpc.ClientMethod<
          $22.CreateContributionRequest, $22.CreateContributionResponse>(
      '/group_accounts.GroupAccountService/CreateContribution',
      ($22.CreateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.CreateContributionResponse.fromBuffer(value));
  static final _$getContribution = $grpc.ClientMethod<
          $22.GetContributionRequest, $22.GetContributionResponse>(
      '/group_accounts.GroupAccountService/GetContribution',
      ($22.GetContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetContributionResponse.fromBuffer(value));
  static final _$listGroupContributions = $grpc.ClientMethod<
          $22.ListGroupContributionsRequest,
          $22.ListGroupContributionsResponse>(
      '/group_accounts.GroupAccountService/ListGroupContributions',
      ($22.ListGroupContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.ListGroupContributionsResponse.fromBuffer(value));
  static final _$updateContribution = $grpc.ClientMethod<
          $22.UpdateContributionRequest, $22.UpdateContributionResponse>(
      '/group_accounts.GroupAccountService/UpdateContribution',
      ($22.UpdateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UpdateContributionResponse.fromBuffer(value));
  static final _$deleteContribution = $grpc.ClientMethod<
          $22.DeleteContributionRequest, $22.DeleteContributionResponse>(
      '/group_accounts.GroupAccountService/DeleteContribution',
      ($22.DeleteContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.DeleteContributionResponse.fromBuffer(value));
  static final _$addMembersToContribution = $grpc.ClientMethod<
          $22.AddMembersToContributionRequest,
          $22.AddMembersToContributionResponse>(
      '/group_accounts.GroupAccountService/AddMembersToContribution',
      ($22.AddMembersToContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.AddMembersToContributionResponse.fromBuffer(value));
  static final _$previewMemberExit = $grpc.ClientMethod<
          $22.PreviewMemberExitRequest, $22.PreviewMemberExitResponse>(
      '/group_accounts.GroupAccountService/PreviewMemberExit',
      ($22.PreviewMemberExitRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.PreviewMemberExitResponse.fromBuffer(value));
  static final _$inviteToGroup =
      $grpc.ClientMethod<$22.InviteToGroupRequest, $22.InviteToGroupResponse>(
          '/group_accounts.GroupAccountService/InviteToGroup',
          ($22.InviteToGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.InviteToGroupResponse.fromBuffer(value));
  static final _$respondToGroupInvite = $grpc.ClientMethod<
          $22.RespondToGroupInviteRequest, $22.RespondToGroupInviteResponse>(
      '/group_accounts.GroupAccountService/RespondToGroupInvite',
      ($22.RespondToGroupInviteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.RespondToGroupInviteResponse.fromBuffer(value));
  static final _$cancelGroupInvite = $grpc.ClientMethod<
          $22.CancelGroupInviteRequest, $22.CancelGroupInviteResponse>(
      '/group_accounts.GroupAccountService/CancelGroupInvite',
      ($22.CancelGroupInviteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.CancelGroupInviteResponse.fromBuffer(value));
  static final _$listMyInvitations = $grpc.ClientMethod<
          $22.ListMyInvitationsRequest, $22.ListMyInvitationsResponse>(
      '/group_accounts.GroupAccountService/ListMyInvitations',
      ($22.ListMyInvitationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.ListMyInvitationsResponse.fromBuffer(value));
  static final _$listGroupInvitations = $grpc.ClientMethod<
          $22.ListGroupInvitationsRequest, $22.ListGroupInvitationsResponse>(
      '/group_accounts.GroupAccountService/ListGroupInvitations',
      ($22.ListGroupInvitationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.ListGroupInvitationsResponse.fromBuffer(value));
  static final _$removeContributionShadow = $grpc.ClientMethod<
          $22.RemoveContributionShadowRequest,
          $22.RemoveContributionShadowResponse>(
      '/group_accounts.GroupAccountService/RemoveContributionShadow',
      ($22.RemoveContributionShadowRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.RemoveContributionShadowResponse.fromBuffer(value));
  static final _$removeMemberFromContribution = $grpc.ClientMethod<
          $22.RemoveMemberFromContributionRequest,
          $22.RemoveMemberFromContributionResponse>(
      '/group_accounts.GroupAccountService/RemoveMemberFromContribution',
      ($22.RemoveMemberFromContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.RemoveMemberFromContributionResponse.fromBuffer(value));
  static final _$getContributionMembers = $grpc.ClientMethod<
          $22.GetContributionMembersRequest,
          $22.GetContributionMembersResponse>(
      '/group_accounts.GroupAccountService/GetContributionMembers',
      ($22.GetContributionMembersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetContributionMembersResponse.fromBuffer(value));
  static final _$makePayment =
      $grpc.ClientMethod<$22.MakePaymentRequest, $22.MakePaymentResponse>(
          '/group_accounts.GroupAccountService/MakePayment',
          ($22.MakePaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.MakePaymentResponse.fromBuffer(value));
  static final _$getContributionPayments = $grpc.ClientMethod<
          $22.GetContributionPaymentsRequest,
          $22.GetContributionPaymentsResponse>(
      '/group_accounts.GroupAccountService/GetContributionPayments',
      ($22.GetContributionPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetContributionPaymentsResponse.fromBuffer(value));
  static final _$updatePaymentStatus = $grpc.ClientMethod<
          $22.UpdatePaymentStatusRequest, $22.UpdatePaymentStatusResponse>(
      '/group_accounts.GroupAccountService/UpdatePaymentStatus',
      ($22.UpdatePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UpdatePaymentStatusResponse.fromBuffer(value));
  static final _$processScheduledPayments = $grpc.ClientMethod<
          $22.ProcessScheduledPaymentsRequest,
          $22.ProcessScheduledPaymentsResponse>(
      '/group_accounts.GroupAccountService/ProcessScheduledPayments',
      ($22.ProcessScheduledPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.ProcessScheduledPaymentsResponse.fromBuffer(value));
  static final _$getPayoutSchedule = $grpc.ClientMethod<
          $22.GetPayoutScheduleRequest, $22.GetPayoutScheduleResponse>(
      '/group_accounts.GroupAccountService/GetPayoutSchedule',
      ($22.GetPayoutScheduleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetPayoutScheduleResponse.fromBuffer(value));
  static final _$processPayout =
      $grpc.ClientMethod<$22.ProcessPayoutRequest, $22.ProcessPayoutResponse>(
          '/group_accounts.GroupAccountService/ProcessPayout',
          ($22.ProcessPayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.ProcessPayoutResponse.fromBuffer(value));
  static final _$updatePayoutStatus = $grpc.ClientMethod<
          $22.UpdatePayoutStatusRequest, $22.UpdatePayoutStatusResponse>(
      '/group_accounts.GroupAccountService/UpdatePayoutStatus',
      ($22.UpdatePayoutStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UpdatePayoutStatusResponse.fromBuffer(value));
  static final _$advancePayoutRotation = $grpc.ClientMethod<
          $22.AdvancePayoutRotationRequest, $22.AdvancePayoutRotationResponse>(
      '/group_accounts.GroupAccountService/AdvancePayoutRotation',
      ($22.AdvancePayoutRotationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.AdvancePayoutRotationResponse.fromBuffer(value));
  static final _$setPayoutReceiver = $grpc.ClientMethod<
          $22.SetPayoutReceiverRequest, $22.SetPayoutReceiverResponse>(
      '/group_accounts.GroupAccountService/SetPayoutReceiver',
      ($22.SetPayoutReceiverRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.SetPayoutReceiverResponse.fromBuffer(value));
  static final _$getPayoutReceiver = $grpc.ClientMethod<
          $22.GetPayoutReceiverRequest, $22.GetPayoutReceiverResponse>(
      '/group_accounts.GroupAccountService/GetPayoutReceiver',
      ($22.GetPayoutReceiverRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetPayoutReceiverResponse.fromBuffer(value));
  static final _$clearPayoutReceiver = $grpc.ClientMethod<
          $22.ClearPayoutReceiverRequest, $22.ClearPayoutReceiverResponse>(
      '/group_accounts.GroupAccountService/ClearPayoutReceiver',
      ($22.ClearPayoutReceiverRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.ClearPayoutReceiverResponse.fromBuffer(value));
  static final _$triggerManualPayout = $grpc.ClientMethod<
          $22.TriggerManualPayoutRequest, $22.TriggerManualPayoutResponse>(
      '/group_accounts.GroupAccountService/TriggerManualPayout',
      ($22.TriggerManualPayoutRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.TriggerManualPayoutResponse.fromBuffer(value));
  static final _$listScheduledPayouts = $grpc.ClientMethod<
          $22.ListScheduledPayoutsRequest, $22.ListScheduledPayoutsResponse>(
      '/group_accounts.GroupAccountService/ListScheduledPayouts',
      ($22.ListScheduledPayoutsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.ListScheduledPayoutsResponse.fromBuffer(value));
  static final _$getScheduledPayout = $grpc.ClientMethod<
          $22.GetScheduledPayoutRequest, $22.GetScheduledPayoutResponse>(
      '/group_accounts.GroupAccountService/GetScheduledPayout',
      ($22.GetScheduledPayoutRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetScheduledPayoutResponse.fromBuffer(value));
  static final _$generateReceipt = $grpc.ClientMethod<
          $22.GenerateReceiptRequest, $22.GenerateReceiptResponse>(
      '/group_accounts.GroupAccountService/GenerateReceipt',
      ($22.GenerateReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GenerateReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<
          $22.GetUserContributionReceiptsRequest,
          $22.GetUserContributionReceiptsResponse>(
      '/group_accounts.GroupAccountService/GetUserReceipts',
      ($22.GetUserContributionReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetUserContributionReceiptsResponse.fromBuffer(value));
  static final _$generateTranscript = $grpc.ClientMethod<
          $22.GenerateTranscriptRequest, $22.GenerateTranscriptResponse>(
      '/group_accounts.GroupAccountService/GenerateTranscript',
      ($22.GenerateTranscriptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GenerateTranscriptResponse.fromBuffer(value));
  static final _$listContributionCycles = $grpc.ClientMethod<
          $22.ListContributionCyclesRequest,
          $22.ListContributionCyclesResponse>(
      '/group_accounts.GroupAccountService/ListContributionCycles',
      ($22.ListContributionCyclesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.ListContributionCyclesResponse.fromBuffer(value));
  static final _$getContributionCycleDetails = $grpc.ClientMethod<
          $22.GetContributionCycleDetailsRequest,
          $22.GetContributionCycleDetailsResponse>(
      '/group_accounts.GroupAccountService/GetContributionCycleDetails',
      ($22.GetContributionCycleDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetContributionCycleDetailsResponse.fromBuffer(value));
  static final _$restartContribution = $grpc.ClientMethod<
          $22.RestartContributionRequest, $22.RestartContributionResponse>(
      '/group_accounts.GroupAccountService/RestartContribution',
      ($22.RestartContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.RestartContributionResponse.fromBuffer(value));
  static final _$sendContributionMessage = $grpc.ClientMethod<
          $22.SendContributionMessageRequest,
          $22.SendContributionMessageResponse>(
      '/group_accounts.GroupAccountService/SendContributionMessage',
      ($22.SendContributionMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.SendContributionMessageResponse.fromBuffer(value));
  static final _$listContributionMessages = $grpc.ClientMethod<
          $22.ListContributionMessagesRequest,
          $22.ListContributionMessagesResponse>(
      '/group_accounts.GroupAccountService/ListContributionMessages',
      ($22.ListContributionMessagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.ListContributionMessagesResponse.fromBuffer(value));
  static final _$getGroupStatistics = $grpc.ClientMethod<
          $22.GetGroupStatisticsRequest, $22.GetGroupStatisticsResponse>(
      '/group_accounts.GroupAccountService/GetGroupStatistics',
      ($22.GetGroupStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetGroupStatisticsResponse.fromBuffer(value));
  static final _$getUserContributionStats = $grpc.ClientMethod<
          $22.GetUserContributionStatsRequest,
          $22.GetUserContributionStatsResponse>(
      '/group_accounts.GroupAccountService/GetUserContributionStats',
      ($22.GetUserContributionStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetUserContributionStatsResponse.fromBuffer(value));
  static final _$getOverdueContributions = $grpc.ClientMethod<
          $22.GetOverdueContributionsRequest,
          $22.GetOverdueContributionsResponse>(
      '/group_accounts.GroupAccountService/GetOverdueContributions',
      ($22.GetOverdueContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetOverdueContributionsResponse.fromBuffer(value));
  static final _$getContributionAnalytics = $grpc.ClientMethod<
          $22.GetContributionAnalyticsRequest,
          $22.GetContributionAnalyticsResponse>(
      '/group_accounts.GroupAccountService/GetContributionAnalytics',
      ($22.GetContributionAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetContributionAnalyticsResponse.fromBuffer(value));
  static final _$getGroupActivityLogs = $grpc.ClientMethod<
          $22.GetGroupActivityLogsRequest, $22.GetGroupActivityLogsResponse>(
      '/group_accounts.GroupAccountService/GetGroupActivityLogs',
      ($22.GetGroupActivityLogsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetGroupActivityLogsResponse.fromBuffer(value));
  static final _$getContributionActivityLogs = $grpc.ClientMethod<
          $22.GetContributionActivityLogsRequest,
          $22.GetContributionActivityLogsResponse>(
      '/group_accounts.GroupAccountService/GetContributionActivityLogs',
      ($22.GetContributionActivityLogsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetContributionActivityLogsResponse.fromBuffer(value));
  static final _$listPublicGroups = $grpc.ClientMethod<
          $22.ListPublicGroupsRequest, $22.ListPublicGroupsResponse>(
      '/group_accounts.GroupAccountService/ListPublicGroups',
      ($22.ListPublicGroupsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.ListPublicGroupsResponse.fromBuffer(value));
  static final _$getPublicGroup =
      $grpc.ClientMethod<$22.GetPublicGroupRequest, $22.GetPublicGroupResponse>(
          '/group_accounts.GroupAccountService/GetPublicGroup',
          ($22.GetPublicGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.GetPublicGroupResponse.fromBuffer(value));
  static final _$joinPublicGroup = $grpc.ClientMethod<
          $22.JoinPublicGroupRequest, $22.JoinPublicGroupResponse>(
      '/group_accounts.GroupAccountService/JoinPublicGroup',
      ($22.JoinPublicGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.JoinPublicGroupResponse.fromBuffer(value));

  GroupAccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$22.CreateGroupResponse> createGroup(
      $22.CreateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroup, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetGroupResponse> getGroup(
      $22.GetGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroup, request, options: options);
  }

  $grpc.ResponseFuture<$22.ListUserGroupsResponse> listUserGroups(
      $22.ListUserGroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listUserGroups, request, options: options);
  }

  $grpc.ResponseFuture<$22.UpdateGroupResponse> updateGroup(
      $22.UpdateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateGroup, request, options: options);
  }

  $grpc.ResponseFuture<$22.DeleteGroupResponse> deleteGroup(
      $22.DeleteGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteGroup, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetGroupMembersResponse> getGroupMembers(
      $22.GetGroupMembersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupMembers, request, options: options);
  }

  $grpc.ResponseFuture<$22.AddMemberResponse> addMember(
      $22.AddMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMember, request, options: options);
  }

  $grpc.ResponseFuture<$22.UpdateMemberRoleResponse> updateMemberRole(
      $22.UpdateMemberRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMemberRole, request, options: options);
  }

  $grpc.ResponseFuture<$22.RemoveMemberResponse> removeMember(
      $22.RemoveMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeMember, request, options: options);
  }

  $grpc.ResponseFuture<$22.SearchUsersResponse> searchUsers(
      $22.SearchUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$22.CreateContributionResponse> createContribution(
      $22.CreateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createContribution, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetContributionResponse> getContribution(
      $22.GetContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContribution, request, options: options);
  }

  $grpc.ResponseFuture<$22.ListGroupContributionsResponse>
      listGroupContributions($22.ListGroupContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listGroupContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.UpdateContributionResponse> updateContribution(
      $22.UpdateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateContribution, request, options: options);
  }

  $grpc.ResponseFuture<$22.DeleteContributionResponse> deleteContribution(
      $22.DeleteContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteContribution, request, options: options);
  }

  $grpc.ResponseFuture<$22.AddMembersToContributionResponse>
      addMembersToContribution($22.AddMembersToContributionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMembersToContribution, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.PreviewMemberExitResponse> previewMemberExit(
      $22.PreviewMemberExitRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$previewMemberExit, request, options: options);
  }

  $grpc.ResponseFuture<$22.InviteToGroupResponse> inviteToGroup(
      $22.InviteToGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$inviteToGroup, request, options: options);
  }

  $grpc.ResponseFuture<$22.RespondToGroupInviteResponse> respondToGroupInvite(
      $22.RespondToGroupInviteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$respondToGroupInvite, request, options: options);
  }

  $grpc.ResponseFuture<$22.CancelGroupInviteResponse> cancelGroupInvite(
      $22.CancelGroupInviteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelGroupInvite, request, options: options);
  }

  $grpc.ResponseFuture<$22.ListMyInvitationsResponse> listMyInvitations(
      $22.ListMyInvitationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listMyInvitations, request, options: options);
  }

  $grpc.ResponseFuture<$22.ListGroupInvitationsResponse> listGroupInvitations(
      $22.ListGroupInvitationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listGroupInvitations, request, options: options);
  }

  $grpc.ResponseFuture<$22.RemoveContributionShadowResponse>
      removeContributionShadow($22.RemoveContributionShadowRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeContributionShadow, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.RemoveMemberFromContributionResponse>
      removeMemberFromContribution(
          $22.RemoveMemberFromContributionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeMemberFromContribution, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetContributionMembersResponse>
      getContributionMembers($22.GetContributionMembersRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionMembers, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.MakePaymentResponse> makePayment(
      $22.MakePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makePayment, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetContributionPaymentsResponse>
      getContributionPayments($22.GetContributionPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.UpdatePaymentStatusResponse> updatePaymentStatus(
      $22.UpdatePaymentStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$22.ProcessScheduledPaymentsResponse>
      processScheduledPayments($22.ProcessScheduledPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processScheduledPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetPayoutScheduleResponse> getPayoutSchedule(
      $22.GetPayoutScheduleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutSchedule, request, options: options);
  }

  $grpc.ResponseFuture<$22.ProcessPayoutResponse> processPayout(
      $22.ProcessPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayout, request, options: options);
  }

  $grpc.ResponseFuture<$22.UpdatePayoutStatusResponse> updatePayoutStatus(
      $22.UpdatePayoutStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePayoutStatus, request, options: options);
  }

  $grpc.ResponseFuture<$22.AdvancePayoutRotationResponse> advancePayoutRotation(
      $22.AdvancePayoutRotationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$advancePayoutRotation, request, options: options);
  }

  $grpc.ResponseFuture<$22.SetPayoutReceiverResponse> setPayoutReceiver(
      $22.SetPayoutReceiverRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPayoutReceiver, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetPayoutReceiverResponse> getPayoutReceiver(
      $22.GetPayoutReceiverRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutReceiver, request, options: options);
  }

  $grpc.ResponseFuture<$22.ClearPayoutReceiverResponse> clearPayoutReceiver(
      $22.ClearPayoutReceiverRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$clearPayoutReceiver, request, options: options);
  }

  $grpc.ResponseFuture<$22.TriggerManualPayoutResponse> triggerManualPayout(
      $22.TriggerManualPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerManualPayout, request, options: options);
  }

  $grpc.ResponseFuture<$22.ListScheduledPayoutsResponse> listScheduledPayouts(
      $22.ListScheduledPayoutsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listScheduledPayouts, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetScheduledPayoutResponse> getScheduledPayout(
      $22.GetScheduledPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getScheduledPayout, request, options: options);
  }

  $grpc.ResponseFuture<$22.GenerateReceiptResponse> generateReceipt(
      $22.GenerateReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetUserContributionReceiptsResponse> getUserReceipts(
      $22.GetUserContributionReceiptsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$22.GenerateTranscriptResponse> generateTranscript(
      $22.GenerateTranscriptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateTranscript, request, options: options);
  }

  $grpc.ResponseFuture<$22.ListContributionCyclesResponse>
      listContributionCycles($22.ListContributionCyclesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listContributionCycles, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetContributionCycleDetailsResponse>
      getContributionCycleDetails(
          $22.GetContributionCycleDetailsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionCycleDetails, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.RestartContributionResponse> restartContribution(
      $22.RestartContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$restartContribution, request, options: options);
  }

  $grpc.ResponseFuture<$22.SendContributionMessageResponse>
      sendContributionMessage($22.SendContributionMessageRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendContributionMessage, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.ListContributionMessagesResponse>
      listContributionMessages($22.ListContributionMessagesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listContributionMessages, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetGroupStatisticsResponse> getGroupStatistics(
      $22.GetGroupStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetUserContributionStatsResponse>
      getUserContributionStats($22.GetUserContributionStatsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserContributionStats, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetOverdueContributionsResponse>
      getOverdueContributions($22.GetOverdueContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetContributionAnalyticsResponse>
      getContributionAnalytics($22.GetContributionAnalyticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionAnalytics, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetGroupActivityLogsResponse> getGroupActivityLogs(
      $22.GetGroupActivityLogsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupActivityLogs, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetContributionActivityLogsResponse>
      getContributionActivityLogs(
          $22.GetContributionActivityLogsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionActivityLogs, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.ListPublicGroupsResponse> listPublicGroups(
      $22.ListPublicGroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPublicGroups, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetPublicGroupResponse> getPublicGroup(
      $22.GetPublicGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPublicGroup, request, options: options);
  }

  $grpc.ResponseFuture<$22.JoinPublicGroupResponse> joinPublicGroup(
      $22.JoinPublicGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$joinPublicGroup, request, options: options);
  }
}

abstract class GroupAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'group_accounts.GroupAccountService';

  GroupAccountServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$22.CreateGroupRequest, $22.CreateGroupResponse>(
            'CreateGroup',
            createGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.CreateGroupRequest.fromBuffer(value),
            ($22.CreateGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetGroupRequest, $22.GetGroupResponse>(
        'GetGroup',
        getGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetGroupRequest.fromBuffer(value),
        ($22.GetGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ListUserGroupsRequest,
            $22.ListUserGroupsResponse>(
        'ListUserGroups',
        listUserGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ListUserGroupsRequest.fromBuffer(value),
        ($22.ListUserGroupsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.UpdateGroupRequest, $22.UpdateGroupResponse>(
            'UpdateGroup',
            updateGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.UpdateGroupRequest.fromBuffer(value),
            ($22.UpdateGroupResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.DeleteGroupRequest, $22.DeleteGroupResponse>(
            'DeleteGroup',
            deleteGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.DeleteGroupRequest.fromBuffer(value),
            ($22.DeleteGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetGroupMembersRequest,
            $22.GetGroupMembersResponse>(
        'GetGroupMembers',
        getGroupMembers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetGroupMembersRequest.fromBuffer(value),
        ($22.GetGroupMembersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.AddMemberRequest, $22.AddMemberResponse>(
        'AddMember',
        addMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.AddMemberRequest.fromBuffer(value),
        ($22.AddMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdateMemberRoleRequest,
            $22.UpdateMemberRoleResponse>(
        'UpdateMemberRole',
        updateMemberRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UpdateMemberRoleRequest.fromBuffer(value),
        ($22.UpdateMemberRoleResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.RemoveMemberRequest, $22.RemoveMemberResponse>(
            'RemoveMember',
            removeMember_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.RemoveMemberRequest.fromBuffer(value),
            ($22.RemoveMemberResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.SearchUsersRequest, $22.SearchUsersResponse>(
            'SearchUsers',
            searchUsers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.SearchUsersRequest.fromBuffer(value),
            ($22.SearchUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.CreateContributionRequest,
            $22.CreateContributionResponse>(
        'CreateContribution',
        createContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.CreateContributionRequest.fromBuffer(value),
        ($22.CreateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetContributionRequest,
            $22.GetContributionResponse>(
        'GetContribution',
        getContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetContributionRequest.fromBuffer(value),
        ($22.GetContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ListGroupContributionsRequest,
            $22.ListGroupContributionsResponse>(
        'ListGroupContributions',
        listGroupContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ListGroupContributionsRequest.fromBuffer(value),
        ($22.ListGroupContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdateContributionRequest,
            $22.UpdateContributionResponse>(
        'UpdateContribution',
        updateContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UpdateContributionRequest.fromBuffer(value),
        ($22.UpdateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.DeleteContributionRequest,
            $22.DeleteContributionResponse>(
        'DeleteContribution',
        deleteContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.DeleteContributionRequest.fromBuffer(value),
        ($22.DeleteContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.AddMembersToContributionRequest,
            $22.AddMembersToContributionResponse>(
        'AddMembersToContribution',
        addMembersToContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.AddMembersToContributionRequest.fromBuffer(value),
        ($22.AddMembersToContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.PreviewMemberExitRequest,
            $22.PreviewMemberExitResponse>(
        'PreviewMemberExit',
        previewMemberExit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.PreviewMemberExitRequest.fromBuffer(value),
        ($22.PreviewMemberExitResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.InviteToGroupRequest,
            $22.InviteToGroupResponse>(
        'InviteToGroup',
        inviteToGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.InviteToGroupRequest.fromBuffer(value),
        ($22.InviteToGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.RespondToGroupInviteRequest,
            $22.RespondToGroupInviteResponse>(
        'RespondToGroupInvite',
        respondToGroupInvite_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.RespondToGroupInviteRequest.fromBuffer(value),
        ($22.RespondToGroupInviteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.CancelGroupInviteRequest,
            $22.CancelGroupInviteResponse>(
        'CancelGroupInvite',
        cancelGroupInvite_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.CancelGroupInviteRequest.fromBuffer(value),
        ($22.CancelGroupInviteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ListMyInvitationsRequest,
            $22.ListMyInvitationsResponse>(
        'ListMyInvitations',
        listMyInvitations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ListMyInvitationsRequest.fromBuffer(value),
        ($22.ListMyInvitationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ListGroupInvitationsRequest,
            $22.ListGroupInvitationsResponse>(
        'ListGroupInvitations',
        listGroupInvitations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ListGroupInvitationsRequest.fromBuffer(value),
        ($22.ListGroupInvitationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.RemoveContributionShadowRequest,
            $22.RemoveContributionShadowResponse>(
        'RemoveContributionShadow',
        removeContributionShadow_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.RemoveContributionShadowRequest.fromBuffer(value),
        ($22.RemoveContributionShadowResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.RemoveMemberFromContributionRequest,
            $22.RemoveMemberFromContributionResponse>(
        'RemoveMemberFromContribution',
        removeMemberFromContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.RemoveMemberFromContributionRequest.fromBuffer(value),
        ($22.RemoveMemberFromContributionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetContributionMembersRequest,
            $22.GetContributionMembersResponse>(
        'GetContributionMembers',
        getContributionMembers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetContributionMembersRequest.fromBuffer(value),
        ($22.GetContributionMembersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.MakePaymentRequest, $22.MakePaymentResponse>(
            'MakePayment',
            makePayment_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.MakePaymentRequest.fromBuffer(value),
            ($22.MakePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetContributionPaymentsRequest,
            $22.GetContributionPaymentsResponse>(
        'GetContributionPayments',
        getContributionPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetContributionPaymentsRequest.fromBuffer(value),
        ($22.GetContributionPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdatePaymentStatusRequest,
            $22.UpdatePaymentStatusResponse>(
        'UpdatePaymentStatus',
        updatePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UpdatePaymentStatusRequest.fromBuffer(value),
        ($22.UpdatePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ProcessScheduledPaymentsRequest,
            $22.ProcessScheduledPaymentsResponse>(
        'ProcessScheduledPayments',
        processScheduledPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ProcessScheduledPaymentsRequest.fromBuffer(value),
        ($22.ProcessScheduledPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetPayoutScheduleRequest,
            $22.GetPayoutScheduleResponse>(
        'GetPayoutSchedule',
        getPayoutSchedule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetPayoutScheduleRequest.fromBuffer(value),
        ($22.GetPayoutScheduleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ProcessPayoutRequest,
            $22.ProcessPayoutResponse>(
        'ProcessPayout',
        processPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ProcessPayoutRequest.fromBuffer(value),
        ($22.ProcessPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdatePayoutStatusRequest,
            $22.UpdatePayoutStatusResponse>(
        'UpdatePayoutStatus',
        updatePayoutStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UpdatePayoutStatusRequest.fromBuffer(value),
        ($22.UpdatePayoutStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.AdvancePayoutRotationRequest,
            $22.AdvancePayoutRotationResponse>(
        'AdvancePayoutRotation',
        advancePayoutRotation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.AdvancePayoutRotationRequest.fromBuffer(value),
        ($22.AdvancePayoutRotationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.SetPayoutReceiverRequest,
            $22.SetPayoutReceiverResponse>(
        'SetPayoutReceiver',
        setPayoutReceiver_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.SetPayoutReceiverRequest.fromBuffer(value),
        ($22.SetPayoutReceiverResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetPayoutReceiverRequest,
            $22.GetPayoutReceiverResponse>(
        'GetPayoutReceiver',
        getPayoutReceiver_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetPayoutReceiverRequest.fromBuffer(value),
        ($22.GetPayoutReceiverResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ClearPayoutReceiverRequest,
            $22.ClearPayoutReceiverResponse>(
        'ClearPayoutReceiver',
        clearPayoutReceiver_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ClearPayoutReceiverRequest.fromBuffer(value),
        ($22.ClearPayoutReceiverResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.TriggerManualPayoutRequest,
            $22.TriggerManualPayoutResponse>(
        'TriggerManualPayout',
        triggerManualPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.TriggerManualPayoutRequest.fromBuffer(value),
        ($22.TriggerManualPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ListScheduledPayoutsRequest,
            $22.ListScheduledPayoutsResponse>(
        'ListScheduledPayouts',
        listScheduledPayouts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ListScheduledPayoutsRequest.fromBuffer(value),
        ($22.ListScheduledPayoutsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetScheduledPayoutRequest,
            $22.GetScheduledPayoutResponse>(
        'GetScheduledPayout',
        getScheduledPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetScheduledPayoutRequest.fromBuffer(value),
        ($22.GetScheduledPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GenerateReceiptRequest,
            $22.GenerateReceiptResponse>(
        'GenerateReceipt',
        generateReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GenerateReceiptRequest.fromBuffer(value),
        ($22.GenerateReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetUserContributionReceiptsRequest,
            $22.GetUserContributionReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetUserContributionReceiptsRequest.fromBuffer(value),
        ($22.GetUserContributionReceiptsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GenerateTranscriptRequest,
            $22.GenerateTranscriptResponse>(
        'GenerateTranscript',
        generateTranscript_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GenerateTranscriptRequest.fromBuffer(value),
        ($22.GenerateTranscriptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ListContributionCyclesRequest,
            $22.ListContributionCyclesResponse>(
        'ListContributionCycles',
        listContributionCycles_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ListContributionCyclesRequest.fromBuffer(value),
        ($22.ListContributionCyclesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetContributionCycleDetailsRequest,
            $22.GetContributionCycleDetailsResponse>(
        'GetContributionCycleDetails',
        getContributionCycleDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetContributionCycleDetailsRequest.fromBuffer(value),
        ($22.GetContributionCycleDetailsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.RestartContributionRequest,
            $22.RestartContributionResponse>(
        'RestartContribution',
        restartContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.RestartContributionRequest.fromBuffer(value),
        ($22.RestartContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.SendContributionMessageRequest,
            $22.SendContributionMessageResponse>(
        'SendContributionMessage',
        sendContributionMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.SendContributionMessageRequest.fromBuffer(value),
        ($22.SendContributionMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ListContributionMessagesRequest,
            $22.ListContributionMessagesResponse>(
        'ListContributionMessages',
        listContributionMessages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ListContributionMessagesRequest.fromBuffer(value),
        ($22.ListContributionMessagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetGroupStatisticsRequest,
            $22.GetGroupStatisticsResponse>(
        'GetGroupStatistics',
        getGroupStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetGroupStatisticsRequest.fromBuffer(value),
        ($22.GetGroupStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetUserContributionStatsRequest,
            $22.GetUserContributionStatsResponse>(
        'GetUserContributionStats',
        getUserContributionStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetUserContributionStatsRequest.fromBuffer(value),
        ($22.GetUserContributionStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetOverdueContributionsRequest,
            $22.GetOverdueContributionsResponse>(
        'GetOverdueContributions',
        getOverdueContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetOverdueContributionsRequest.fromBuffer(value),
        ($22.GetOverdueContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetContributionAnalyticsRequest,
            $22.GetContributionAnalyticsResponse>(
        'GetContributionAnalytics',
        getContributionAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetContributionAnalyticsRequest.fromBuffer(value),
        ($22.GetContributionAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetGroupActivityLogsRequest,
            $22.GetGroupActivityLogsResponse>(
        'GetGroupActivityLogs',
        getGroupActivityLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetGroupActivityLogsRequest.fromBuffer(value),
        ($22.GetGroupActivityLogsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetContributionActivityLogsRequest,
            $22.GetContributionActivityLogsResponse>(
        'GetContributionActivityLogs',
        getContributionActivityLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetContributionActivityLogsRequest.fromBuffer(value),
        ($22.GetContributionActivityLogsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ListPublicGroupsRequest,
            $22.ListPublicGroupsResponse>(
        'ListPublicGroups',
        listPublicGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.ListPublicGroupsRequest.fromBuffer(value),
        ($22.ListPublicGroupsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetPublicGroupRequest,
            $22.GetPublicGroupResponse>(
        'GetPublicGroup',
        getPublicGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetPublicGroupRequest.fromBuffer(value),
        ($22.GetPublicGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.JoinPublicGroupRequest,
            $22.JoinPublicGroupResponse>(
        'JoinPublicGroup',
        joinPublicGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.JoinPublicGroupRequest.fromBuffer(value),
        ($22.JoinPublicGroupResponse value) => value.writeToBuffer()));
  }

  $async.Future<$22.CreateGroupResponse> createGroup_Pre($grpc.ServiceCall call,
      $async.Future<$22.CreateGroupRequest> request) async {
    return createGroup(call, await request);
  }

  $async.Future<$22.GetGroupResponse> getGroup_Pre($grpc.ServiceCall call,
      $async.Future<$22.GetGroupRequest> request) async {
    return getGroup(call, await request);
  }

  $async.Future<$22.ListUserGroupsResponse> listUserGroups_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.ListUserGroupsRequest> request) async {
    return listUserGroups(call, await request);
  }

  $async.Future<$22.UpdateGroupResponse> updateGroup_Pre($grpc.ServiceCall call,
      $async.Future<$22.UpdateGroupRequest> request) async {
    return updateGroup(call, await request);
  }

  $async.Future<$22.DeleteGroupResponse> deleteGroup_Pre($grpc.ServiceCall call,
      $async.Future<$22.DeleteGroupRequest> request) async {
    return deleteGroup(call, await request);
  }

  $async.Future<$22.GetGroupMembersResponse> getGroupMembers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetGroupMembersRequest> request) async {
    return getGroupMembers(call, await request);
  }

  $async.Future<$22.AddMemberResponse> addMember_Pre($grpc.ServiceCall call,
      $async.Future<$22.AddMemberRequest> request) async {
    return addMember(call, await request);
  }

  $async.Future<$22.UpdateMemberRoleResponse> updateMemberRole_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UpdateMemberRoleRequest> request) async {
    return updateMemberRole(call, await request);
  }

  $async.Future<$22.RemoveMemberResponse> removeMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.RemoveMemberRequest> request) async {
    return removeMember(call, await request);
  }

  $async.Future<$22.SearchUsersResponse> searchUsers_Pre($grpc.ServiceCall call,
      $async.Future<$22.SearchUsersRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$22.CreateContributionResponse> createContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.CreateContributionRequest> request) async {
    return createContribution(call, await request);
  }

  $async.Future<$22.GetContributionResponse> getContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetContributionRequest> request) async {
    return getContribution(call, await request);
  }

  $async.Future<$22.ListGroupContributionsResponse> listGroupContributions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.ListGroupContributionsRequest> request) async {
    return listGroupContributions(call, await request);
  }

  $async.Future<$22.UpdateContributionResponse> updateContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UpdateContributionRequest> request) async {
    return updateContribution(call, await request);
  }

  $async.Future<$22.DeleteContributionResponse> deleteContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.DeleteContributionRequest> request) async {
    return deleteContribution(call, await request);
  }

  $async.Future<$22.AddMembersToContributionResponse>
      addMembersToContribution_Pre($grpc.ServiceCall call,
          $async.Future<$22.AddMembersToContributionRequest> request) async {
    return addMembersToContribution(call, await request);
  }

  $async.Future<$22.PreviewMemberExitResponse> previewMemberExit_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.PreviewMemberExitRequest> request) async {
    return previewMemberExit(call, await request);
  }

  $async.Future<$22.InviteToGroupResponse> inviteToGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.InviteToGroupRequest> request) async {
    return inviteToGroup(call, await request);
  }

  $async.Future<$22.RespondToGroupInviteResponse> respondToGroupInvite_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.RespondToGroupInviteRequest> request) async {
    return respondToGroupInvite(call, await request);
  }

  $async.Future<$22.CancelGroupInviteResponse> cancelGroupInvite_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.CancelGroupInviteRequest> request) async {
    return cancelGroupInvite(call, await request);
  }

  $async.Future<$22.ListMyInvitationsResponse> listMyInvitations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.ListMyInvitationsRequest> request) async {
    return listMyInvitations(call, await request);
  }

  $async.Future<$22.ListGroupInvitationsResponse> listGroupInvitations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.ListGroupInvitationsRequest> request) async {
    return listGroupInvitations(call, await request);
  }

  $async.Future<$22.RemoveContributionShadowResponse>
      removeContributionShadow_Pre($grpc.ServiceCall call,
          $async.Future<$22.RemoveContributionShadowRequest> request) async {
    return removeContributionShadow(call, await request);
  }

  $async.Future<$22.RemoveMemberFromContributionResponse>
      removeMemberFromContribution_Pre(
          $grpc.ServiceCall call,
          $async.Future<$22.RemoveMemberFromContributionRequest>
              request) async {
    return removeMemberFromContribution(call, await request);
  }

  $async.Future<$22.GetContributionMembersResponse> getContributionMembers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetContributionMembersRequest> request) async {
    return getContributionMembers(call, await request);
  }

  $async.Future<$22.MakePaymentResponse> makePayment_Pre($grpc.ServiceCall call,
      $async.Future<$22.MakePaymentRequest> request) async {
    return makePayment(call, await request);
  }

  $async.Future<$22.GetContributionPaymentsResponse>
      getContributionPayments_Pre($grpc.ServiceCall call,
          $async.Future<$22.GetContributionPaymentsRequest> request) async {
    return getContributionPayments(call, await request);
  }

  $async.Future<$22.UpdatePaymentStatusResponse> updatePaymentStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UpdatePaymentStatusRequest> request) async {
    return updatePaymentStatus(call, await request);
  }

  $async.Future<$22.ProcessScheduledPaymentsResponse>
      processScheduledPayments_Pre($grpc.ServiceCall call,
          $async.Future<$22.ProcessScheduledPaymentsRequest> request) async {
    return processScheduledPayments(call, await request);
  }

  $async.Future<$22.GetPayoutScheduleResponse> getPayoutSchedule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetPayoutScheduleRequest> request) async {
    return getPayoutSchedule(call, await request);
  }

  $async.Future<$22.ProcessPayoutResponse> processPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.ProcessPayoutRequest> request) async {
    return processPayout(call, await request);
  }

  $async.Future<$22.UpdatePayoutStatusResponse> updatePayoutStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UpdatePayoutStatusRequest> request) async {
    return updatePayoutStatus(call, await request);
  }

  $async.Future<$22.AdvancePayoutRotationResponse> advancePayoutRotation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.AdvancePayoutRotationRequest> request) async {
    return advancePayoutRotation(call, await request);
  }

  $async.Future<$22.SetPayoutReceiverResponse> setPayoutReceiver_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.SetPayoutReceiverRequest> request) async {
    return setPayoutReceiver(call, await request);
  }

  $async.Future<$22.GetPayoutReceiverResponse> getPayoutReceiver_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetPayoutReceiverRequest> request) async {
    return getPayoutReceiver(call, await request);
  }

  $async.Future<$22.ClearPayoutReceiverResponse> clearPayoutReceiver_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.ClearPayoutReceiverRequest> request) async {
    return clearPayoutReceiver(call, await request);
  }

  $async.Future<$22.TriggerManualPayoutResponse> triggerManualPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.TriggerManualPayoutRequest> request) async {
    return triggerManualPayout(call, await request);
  }

  $async.Future<$22.ListScheduledPayoutsResponse> listScheduledPayouts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.ListScheduledPayoutsRequest> request) async {
    return listScheduledPayouts(call, await request);
  }

  $async.Future<$22.GetScheduledPayoutResponse> getScheduledPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetScheduledPayoutRequest> request) async {
    return getScheduledPayout(call, await request);
  }

  $async.Future<$22.GenerateReceiptResponse> generateReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GenerateReceiptRequest> request) async {
    return generateReceipt(call, await request);
  }

  $async.Future<$22.GetUserContributionReceiptsResponse> getUserReceipts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetUserContributionReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$22.GenerateTranscriptResponse> generateTranscript_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GenerateTranscriptRequest> request) async {
    return generateTranscript(call, await request);
  }

  $async.Future<$22.ListContributionCyclesResponse> listContributionCycles_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.ListContributionCyclesRequest> request) async {
    return listContributionCycles(call, await request);
  }

  $async.Future<$22.GetContributionCycleDetailsResponse>
      getContributionCycleDetails_Pre($grpc.ServiceCall call,
          $async.Future<$22.GetContributionCycleDetailsRequest> request) async {
    return getContributionCycleDetails(call, await request);
  }

  $async.Future<$22.RestartContributionResponse> restartContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.RestartContributionRequest> request) async {
    return restartContribution(call, await request);
  }

  $async.Future<$22.SendContributionMessageResponse>
      sendContributionMessage_Pre($grpc.ServiceCall call,
          $async.Future<$22.SendContributionMessageRequest> request) async {
    return sendContributionMessage(call, await request);
  }

  $async.Future<$22.ListContributionMessagesResponse>
      listContributionMessages_Pre($grpc.ServiceCall call,
          $async.Future<$22.ListContributionMessagesRequest> request) async {
    return listContributionMessages(call, await request);
  }

  $async.Future<$22.GetGroupStatisticsResponse> getGroupStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetGroupStatisticsRequest> request) async {
    return getGroupStatistics(call, await request);
  }

  $async.Future<$22.GetUserContributionStatsResponse>
      getUserContributionStats_Pre($grpc.ServiceCall call,
          $async.Future<$22.GetUserContributionStatsRequest> request) async {
    return getUserContributionStats(call, await request);
  }

  $async.Future<$22.GetOverdueContributionsResponse>
      getOverdueContributions_Pre($grpc.ServiceCall call,
          $async.Future<$22.GetOverdueContributionsRequest> request) async {
    return getOverdueContributions(call, await request);
  }

  $async.Future<$22.GetContributionAnalyticsResponse>
      getContributionAnalytics_Pre($grpc.ServiceCall call,
          $async.Future<$22.GetContributionAnalyticsRequest> request) async {
    return getContributionAnalytics(call, await request);
  }

  $async.Future<$22.GetGroupActivityLogsResponse> getGroupActivityLogs_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetGroupActivityLogsRequest> request) async {
    return getGroupActivityLogs(call, await request);
  }

  $async.Future<$22.GetContributionActivityLogsResponse>
      getContributionActivityLogs_Pre($grpc.ServiceCall call,
          $async.Future<$22.GetContributionActivityLogsRequest> request) async {
    return getContributionActivityLogs(call, await request);
  }

  $async.Future<$22.ListPublicGroupsResponse> listPublicGroups_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.ListPublicGroupsRequest> request) async {
    return listPublicGroups(call, await request);
  }

  $async.Future<$22.GetPublicGroupResponse> getPublicGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetPublicGroupRequest> request) async {
    return getPublicGroup(call, await request);
  }

  $async.Future<$22.JoinPublicGroupResponse> joinPublicGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.JoinPublicGroupRequest> request) async {
    return joinPublicGroup(call, await request);
  }

  $async.Future<$22.CreateGroupResponse> createGroup(
      $grpc.ServiceCall call, $22.CreateGroupRequest request);
  $async.Future<$22.GetGroupResponse> getGroup(
      $grpc.ServiceCall call, $22.GetGroupRequest request);
  $async.Future<$22.ListUserGroupsResponse> listUserGroups(
      $grpc.ServiceCall call, $22.ListUserGroupsRequest request);
  $async.Future<$22.UpdateGroupResponse> updateGroup(
      $grpc.ServiceCall call, $22.UpdateGroupRequest request);
  $async.Future<$22.DeleteGroupResponse> deleteGroup(
      $grpc.ServiceCall call, $22.DeleteGroupRequest request);
  $async.Future<$22.GetGroupMembersResponse> getGroupMembers(
      $grpc.ServiceCall call, $22.GetGroupMembersRequest request);
  $async.Future<$22.AddMemberResponse> addMember(
      $grpc.ServiceCall call, $22.AddMemberRequest request);
  $async.Future<$22.UpdateMemberRoleResponse> updateMemberRole(
      $grpc.ServiceCall call, $22.UpdateMemberRoleRequest request);
  $async.Future<$22.RemoveMemberResponse> removeMember(
      $grpc.ServiceCall call, $22.RemoveMemberRequest request);
  $async.Future<$22.SearchUsersResponse> searchUsers(
      $grpc.ServiceCall call, $22.SearchUsersRequest request);
  $async.Future<$22.CreateContributionResponse> createContribution(
      $grpc.ServiceCall call, $22.CreateContributionRequest request);
  $async.Future<$22.GetContributionResponse> getContribution(
      $grpc.ServiceCall call, $22.GetContributionRequest request);
  $async.Future<$22.ListGroupContributionsResponse> listGroupContributions(
      $grpc.ServiceCall call, $22.ListGroupContributionsRequest request);
  $async.Future<$22.UpdateContributionResponse> updateContribution(
      $grpc.ServiceCall call, $22.UpdateContributionRequest request);
  $async.Future<$22.DeleteContributionResponse> deleteContribution(
      $grpc.ServiceCall call, $22.DeleteContributionRequest request);
  $async.Future<$22.AddMembersToContributionResponse> addMembersToContribution(
      $grpc.ServiceCall call, $22.AddMembersToContributionRequest request);
  $async.Future<$22.PreviewMemberExitResponse> previewMemberExit(
      $grpc.ServiceCall call, $22.PreviewMemberExitRequest request);
  $async.Future<$22.InviteToGroupResponse> inviteToGroup(
      $grpc.ServiceCall call, $22.InviteToGroupRequest request);
  $async.Future<$22.RespondToGroupInviteResponse> respondToGroupInvite(
      $grpc.ServiceCall call, $22.RespondToGroupInviteRequest request);
  $async.Future<$22.CancelGroupInviteResponse> cancelGroupInvite(
      $grpc.ServiceCall call, $22.CancelGroupInviteRequest request);
  $async.Future<$22.ListMyInvitationsResponse> listMyInvitations(
      $grpc.ServiceCall call, $22.ListMyInvitationsRequest request);
  $async.Future<$22.ListGroupInvitationsResponse> listGroupInvitations(
      $grpc.ServiceCall call, $22.ListGroupInvitationsRequest request);
  $async.Future<$22.RemoveContributionShadowResponse> removeContributionShadow(
      $grpc.ServiceCall call, $22.RemoveContributionShadowRequest request);
  $async.Future<$22.RemoveMemberFromContributionResponse>
      removeMemberFromContribution($grpc.ServiceCall call,
          $22.RemoveMemberFromContributionRequest request);
  $async.Future<$22.GetContributionMembersResponse> getContributionMembers(
      $grpc.ServiceCall call, $22.GetContributionMembersRequest request);
  $async.Future<$22.MakePaymentResponse> makePayment(
      $grpc.ServiceCall call, $22.MakePaymentRequest request);
  $async.Future<$22.GetContributionPaymentsResponse> getContributionPayments(
      $grpc.ServiceCall call, $22.GetContributionPaymentsRequest request);
  $async.Future<$22.UpdatePaymentStatusResponse> updatePaymentStatus(
      $grpc.ServiceCall call, $22.UpdatePaymentStatusRequest request);
  $async.Future<$22.ProcessScheduledPaymentsResponse> processScheduledPayments(
      $grpc.ServiceCall call, $22.ProcessScheduledPaymentsRequest request);
  $async.Future<$22.GetPayoutScheduleResponse> getPayoutSchedule(
      $grpc.ServiceCall call, $22.GetPayoutScheduleRequest request);
  $async.Future<$22.ProcessPayoutResponse> processPayout(
      $grpc.ServiceCall call, $22.ProcessPayoutRequest request);
  $async.Future<$22.UpdatePayoutStatusResponse> updatePayoutStatus(
      $grpc.ServiceCall call, $22.UpdatePayoutStatusRequest request);
  $async.Future<$22.AdvancePayoutRotationResponse> advancePayoutRotation(
      $grpc.ServiceCall call, $22.AdvancePayoutRotationRequest request);
  $async.Future<$22.SetPayoutReceiverResponse> setPayoutReceiver(
      $grpc.ServiceCall call, $22.SetPayoutReceiverRequest request);
  $async.Future<$22.GetPayoutReceiverResponse> getPayoutReceiver(
      $grpc.ServiceCall call, $22.GetPayoutReceiverRequest request);
  $async.Future<$22.ClearPayoutReceiverResponse> clearPayoutReceiver(
      $grpc.ServiceCall call, $22.ClearPayoutReceiverRequest request);
  $async.Future<$22.TriggerManualPayoutResponse> triggerManualPayout(
      $grpc.ServiceCall call, $22.TriggerManualPayoutRequest request);
  $async.Future<$22.ListScheduledPayoutsResponse> listScheduledPayouts(
      $grpc.ServiceCall call, $22.ListScheduledPayoutsRequest request);
  $async.Future<$22.GetScheduledPayoutResponse> getScheduledPayout(
      $grpc.ServiceCall call, $22.GetScheduledPayoutRequest request);
  $async.Future<$22.GenerateReceiptResponse> generateReceipt(
      $grpc.ServiceCall call, $22.GenerateReceiptRequest request);
  $async.Future<$22.GetUserContributionReceiptsResponse> getUserReceipts(
      $grpc.ServiceCall call, $22.GetUserContributionReceiptsRequest request);
  $async.Future<$22.GenerateTranscriptResponse> generateTranscript(
      $grpc.ServiceCall call, $22.GenerateTranscriptRequest request);
  $async.Future<$22.ListContributionCyclesResponse> listContributionCycles(
      $grpc.ServiceCall call, $22.ListContributionCyclesRequest request);
  $async.Future<$22.GetContributionCycleDetailsResponse>
      getContributionCycleDetails($grpc.ServiceCall call,
          $22.GetContributionCycleDetailsRequest request);
  $async.Future<$22.RestartContributionResponse> restartContribution(
      $grpc.ServiceCall call, $22.RestartContributionRequest request);
  $async.Future<$22.SendContributionMessageResponse> sendContributionMessage(
      $grpc.ServiceCall call, $22.SendContributionMessageRequest request);
  $async.Future<$22.ListContributionMessagesResponse> listContributionMessages(
      $grpc.ServiceCall call, $22.ListContributionMessagesRequest request);
  $async.Future<$22.GetGroupStatisticsResponse> getGroupStatistics(
      $grpc.ServiceCall call, $22.GetGroupStatisticsRequest request);
  $async.Future<$22.GetUserContributionStatsResponse> getUserContributionStats(
      $grpc.ServiceCall call, $22.GetUserContributionStatsRequest request);
  $async.Future<$22.GetOverdueContributionsResponse> getOverdueContributions(
      $grpc.ServiceCall call, $22.GetOverdueContributionsRequest request);
  $async.Future<$22.GetContributionAnalyticsResponse> getContributionAnalytics(
      $grpc.ServiceCall call, $22.GetContributionAnalyticsRequest request);
  $async.Future<$22.GetGroupActivityLogsResponse> getGroupActivityLogs(
      $grpc.ServiceCall call, $22.GetGroupActivityLogsRequest request);
  $async.Future<$22.GetContributionActivityLogsResponse>
      getContributionActivityLogs($grpc.ServiceCall call,
          $22.GetContributionActivityLogsRequest request);
  $async.Future<$22.ListPublicGroupsResponse> listPublicGroups(
      $grpc.ServiceCall call, $22.ListPublicGroupsRequest request);
  $async.Future<$22.GetPublicGroupResponse> getPublicGroup(
      $grpc.ServiceCall call, $22.GetPublicGroupRequest request);
  $async.Future<$22.JoinPublicGroupResponse> joinPublicGroup(
      $grpc.ServiceCall call, $22.JoinPublicGroupRequest request);
}
