///
//  Generated code. Do not modify.
//  source: group_account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'group_account.pb.dart' as $0;
export 'group_account.pb.dart';

class GroupAccountServiceClient extends $grpc.Client {
  static final _$createGroup =
      $grpc.ClientMethod<$0.CreateGroupRequest, $0.CreateGroupResponse>(
          '/group_accounts.GroupAccountService/CreateGroup',
          ($0.CreateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateGroupResponse.fromBuffer(value));
  static final _$getGroup =
      $grpc.ClientMethod<$0.GetGroupRequest, $0.GetGroupResponse>(
          '/group_accounts.GroupAccountService/GetGroup',
          ($0.GetGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetGroupResponse.fromBuffer(value));
  static final _$listUserGroups =
      $grpc.ClientMethod<$0.ListUserGroupsRequest, $0.ListUserGroupsResponse>(
          '/group_accounts.GroupAccountService/ListUserGroups',
          ($0.ListUserGroupsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListUserGroupsResponse.fromBuffer(value));
  static final _$updateGroup =
      $grpc.ClientMethod<$0.UpdateGroupRequest, $0.UpdateGroupResponse>(
          '/group_accounts.GroupAccountService/UpdateGroup',
          ($0.UpdateGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UpdateGroupResponse.fromBuffer(value));
  static final _$deleteGroup =
      $grpc.ClientMethod<$0.DeleteGroupRequest, $0.DeleteGroupResponse>(
          '/group_accounts.GroupAccountService/DeleteGroup',
          ($0.DeleteGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteGroupResponse.fromBuffer(value));
  static final _$getGroupMembers =
      $grpc.ClientMethod<$0.GetGroupMembersRequest, $0.GetGroupMembersResponse>(
          '/group_accounts.GroupAccountService/GetGroupMembers',
          ($0.GetGroupMembersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetGroupMembersResponse.fromBuffer(value));
  static final _$addMember =
      $grpc.ClientMethod<$0.AddMemberRequest, $0.AddMemberResponse>(
          '/group_accounts.GroupAccountService/AddMember',
          ($0.AddMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AddMemberResponse.fromBuffer(value));
  static final _$updateMemberRole = $grpc.ClientMethod<
          $0.UpdateMemberRoleRequest, $0.UpdateMemberRoleResponse>(
      '/group_accounts.GroupAccountService/UpdateMemberRole',
      ($0.UpdateMemberRoleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateMemberRoleResponse.fromBuffer(value));
  static final _$removeMember =
      $grpc.ClientMethod<$0.RemoveMemberRequest, $0.RemoveMemberResponse>(
          '/group_accounts.GroupAccountService/RemoveMember',
          ($0.RemoveMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RemoveMemberResponse.fromBuffer(value));
  static final _$searchUsers =
      $grpc.ClientMethod<$0.SearchUsersRequest, $0.SearchUsersResponse>(
          '/group_accounts.GroupAccountService/SearchUsers',
          ($0.SearchUsersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SearchUsersResponse.fromBuffer(value));
  static final _$createContribution = $grpc.ClientMethod<
          $0.CreateContributionRequest, $0.CreateContributionResponse>(
      '/group_accounts.GroupAccountService/CreateContribution',
      ($0.CreateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateContributionResponse.fromBuffer(value));
  static final _$getContribution =
      $grpc.ClientMethod<$0.GetContributionRequest, $0.GetContributionResponse>(
          '/group_accounts.GroupAccountService/GetContribution',
          ($0.GetContributionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetContributionResponse.fromBuffer(value));
  static final _$listGroupContributions = $grpc.ClientMethod<
          $0.ListGroupContributionsRequest, $0.ListGroupContributionsResponse>(
      '/group_accounts.GroupAccountService/ListGroupContributions',
      ($0.ListGroupContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListGroupContributionsResponse.fromBuffer(value));
  static final _$updateContribution = $grpc.ClientMethod<
          $0.UpdateContributionRequest, $0.UpdateContributionResponse>(
      '/group_accounts.GroupAccountService/UpdateContribution',
      ($0.UpdateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateContributionResponse.fromBuffer(value));
  static final _$deleteContribution = $grpc.ClientMethod<
          $0.DeleteContributionRequest, $0.DeleteContributionResponse>(
      '/group_accounts.GroupAccountService/DeleteContribution',
      ($0.DeleteContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteContributionResponse.fromBuffer(value));
  static final _$addMembersToContribution = $grpc.ClientMethod<
          $0.AddMembersToContributionRequest,
          $0.AddMembersToContributionResponse>(
      '/group_accounts.GroupAccountService/AddMembersToContribution',
      ($0.AddMembersToContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AddMembersToContributionResponse.fromBuffer(value));
  static final _$previewMemberExit = $grpc.ClientMethod<
          $0.PreviewMemberExitRequest, $0.PreviewMemberExitResponse>(
      '/group_accounts.GroupAccountService/PreviewMemberExit',
      ($0.PreviewMemberExitRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PreviewMemberExitResponse.fromBuffer(value));
  static final _$inviteToGroup =
      $grpc.ClientMethod<$0.InviteToGroupRequest, $0.InviteToGroupResponse>(
          '/group_accounts.GroupAccountService/InviteToGroup',
          ($0.InviteToGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.InviteToGroupResponse.fromBuffer(value));
  static final _$respondToGroupInvite = $grpc.ClientMethod<
          $0.RespondToGroupInviteRequest, $0.RespondToGroupInviteResponse>(
      '/group_accounts.GroupAccountService/RespondToGroupInvite',
      ($0.RespondToGroupInviteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RespondToGroupInviteResponse.fromBuffer(value));
  static final _$cancelGroupInvite = $grpc.ClientMethod<
          $0.CancelGroupInviteRequest, $0.CancelGroupInviteResponse>(
      '/group_accounts.GroupAccountService/CancelGroupInvite',
      ($0.CancelGroupInviteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CancelGroupInviteResponse.fromBuffer(value));
  static final _$listMyInvitations = $grpc.ClientMethod<
          $0.ListMyInvitationsRequest, $0.ListMyInvitationsResponse>(
      '/group_accounts.GroupAccountService/ListMyInvitations',
      ($0.ListMyInvitationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListMyInvitationsResponse.fromBuffer(value));
  static final _$listGroupInvitations = $grpc.ClientMethod<
          $0.ListGroupInvitationsRequest, $0.ListGroupInvitationsResponse>(
      '/group_accounts.GroupAccountService/ListGroupInvitations',
      ($0.ListGroupInvitationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListGroupInvitationsResponse.fromBuffer(value));
  static final _$removeContributionShadow = $grpc.ClientMethod<
          $0.RemoveContributionShadowRequest,
          $0.RemoveContributionShadowResponse>(
      '/group_accounts.GroupAccountService/RemoveContributionShadow',
      ($0.RemoveContributionShadowRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RemoveContributionShadowResponse.fromBuffer(value));
  static final _$removeMemberFromContribution = $grpc.ClientMethod<
          $0.RemoveMemberFromContributionRequest,
          $0.RemoveMemberFromContributionResponse>(
      '/group_accounts.GroupAccountService/RemoveMemberFromContribution',
      ($0.RemoveMemberFromContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RemoveMemberFromContributionResponse.fromBuffer(value));
  static final _$getContributionMembers = $grpc.ClientMethod<
          $0.GetContributionMembersRequest, $0.GetContributionMembersResponse>(
      '/group_accounts.GroupAccountService/GetContributionMembers',
      ($0.GetContributionMembersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetContributionMembersResponse.fromBuffer(value));
  static final _$makePayment =
      $grpc.ClientMethod<$0.MakePaymentRequest, $0.MakePaymentResponse>(
          '/group_accounts.GroupAccountService/MakePayment',
          ($0.MakePaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MakePaymentResponse.fromBuffer(value));
  static final _$getContributionPayments = $grpc.ClientMethod<
          $0.GetContributionPaymentsRequest,
          $0.GetContributionPaymentsResponse>(
      '/group_accounts.GroupAccountService/GetContributionPayments',
      ($0.GetContributionPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetContributionPaymentsResponse.fromBuffer(value));
  static final _$updatePaymentStatus = $grpc.ClientMethod<
          $0.UpdatePaymentStatusRequest, $0.UpdatePaymentStatusResponse>(
      '/group_accounts.GroupAccountService/UpdatePaymentStatus',
      ($0.UpdatePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdatePaymentStatusResponse.fromBuffer(value));
  static final _$processScheduledPayments = $grpc.ClientMethod<
          $0.ProcessScheduledPaymentsRequest,
          $0.ProcessScheduledPaymentsResponse>(
      '/group_accounts.GroupAccountService/ProcessScheduledPayments',
      ($0.ProcessScheduledPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ProcessScheduledPaymentsResponse.fromBuffer(value));
  static final _$getPayoutSchedule = $grpc.ClientMethod<
          $0.GetPayoutScheduleRequest, $0.GetPayoutScheduleResponse>(
      '/group_accounts.GroupAccountService/GetPayoutSchedule',
      ($0.GetPayoutScheduleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetPayoutScheduleResponse.fromBuffer(value));
  static final _$processPayout =
      $grpc.ClientMethod<$0.ProcessPayoutRequest, $0.ProcessPayoutResponse>(
          '/group_accounts.GroupAccountService/ProcessPayout',
          ($0.ProcessPayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ProcessPayoutResponse.fromBuffer(value));
  static final _$updatePayoutStatus = $grpc.ClientMethod<
          $0.UpdatePayoutStatusRequest, $0.UpdatePayoutStatusResponse>(
      '/group_accounts.GroupAccountService/UpdatePayoutStatus',
      ($0.UpdatePayoutStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdatePayoutStatusResponse.fromBuffer(value));
  static final _$advancePayoutRotation = $grpc.ClientMethod<
          $0.AdvancePayoutRotationRequest, $0.AdvancePayoutRotationResponse>(
      '/group_accounts.GroupAccountService/AdvancePayoutRotation',
      ($0.AdvancePayoutRotationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdvancePayoutRotationResponse.fromBuffer(value));
  static final _$setPayoutReceiver = $grpc.ClientMethod<
          $0.SetPayoutReceiverRequest, $0.SetPayoutReceiverResponse>(
      '/group_accounts.GroupAccountService/SetPayoutReceiver',
      ($0.SetPayoutReceiverRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SetPayoutReceiverResponse.fromBuffer(value));
  static final _$getPayoutReceiver = $grpc.ClientMethod<
          $0.GetPayoutReceiverRequest, $0.GetPayoutReceiverResponse>(
      '/group_accounts.GroupAccountService/GetPayoutReceiver',
      ($0.GetPayoutReceiverRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetPayoutReceiverResponse.fromBuffer(value));
  static final _$clearPayoutReceiver = $grpc.ClientMethod<
          $0.ClearPayoutReceiverRequest, $0.ClearPayoutReceiverResponse>(
      '/group_accounts.GroupAccountService/ClearPayoutReceiver',
      ($0.ClearPayoutReceiverRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ClearPayoutReceiverResponse.fromBuffer(value));
  static final _$triggerManualPayout = $grpc.ClientMethod<
          $0.TriggerManualPayoutRequest, $0.TriggerManualPayoutResponse>(
      '/group_accounts.GroupAccountService/TriggerManualPayout',
      ($0.TriggerManualPayoutRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.TriggerManualPayoutResponse.fromBuffer(value));
  static final _$listScheduledPayouts = $grpc.ClientMethod<
          $0.ListScheduledPayoutsRequest, $0.ListScheduledPayoutsResponse>(
      '/group_accounts.GroupAccountService/ListScheduledPayouts',
      ($0.ListScheduledPayoutsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListScheduledPayoutsResponse.fromBuffer(value));
  static final _$getScheduledPayout = $grpc.ClientMethod<
          $0.GetScheduledPayoutRequest, $0.GetScheduledPayoutResponse>(
      '/group_accounts.GroupAccountService/GetScheduledPayout',
      ($0.GetScheduledPayoutRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetScheduledPayoutResponse.fromBuffer(value));
  static final _$generateReceipt =
      $grpc.ClientMethod<$0.GenerateReceiptRequest, $0.GenerateReceiptResponse>(
          '/group_accounts.GroupAccountService/GenerateReceipt',
          ($0.GenerateReceiptRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GenerateReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<
          $0.GetUserContributionReceiptsRequest,
          $0.GetUserContributionReceiptsResponse>(
      '/group_accounts.GroupAccountService/GetUserReceipts',
      ($0.GetUserContributionReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserContributionReceiptsResponse.fromBuffer(value));
  static final _$generateTranscript = $grpc.ClientMethod<
          $0.GenerateTranscriptRequest, $0.GenerateTranscriptResponse>(
      '/group_accounts.GroupAccountService/GenerateTranscript',
      ($0.GenerateTranscriptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GenerateTranscriptResponse.fromBuffer(value));
  static final _$listContributionCycles = $grpc.ClientMethod<
          $0.ListContributionCyclesRequest, $0.ListContributionCyclesResponse>(
      '/group_accounts.GroupAccountService/ListContributionCycles',
      ($0.ListContributionCyclesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListContributionCyclesResponse.fromBuffer(value));
  static final _$getContributionCycleDetails = $grpc.ClientMethod<
          $0.GetContributionCycleDetailsRequest,
          $0.GetContributionCycleDetailsResponse>(
      '/group_accounts.GroupAccountService/GetContributionCycleDetails',
      ($0.GetContributionCycleDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetContributionCycleDetailsResponse.fromBuffer(value));
  static final _$restartContribution = $grpc.ClientMethod<
          $0.RestartContributionRequest, $0.RestartContributionResponse>(
      '/group_accounts.GroupAccountService/RestartContribution',
      ($0.RestartContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RestartContributionResponse.fromBuffer(value));
  static final _$sendContributionMessage = $grpc.ClientMethod<
          $0.SendContributionMessageRequest,
          $0.SendContributionMessageResponse>(
      '/group_accounts.GroupAccountService/SendContributionMessage',
      ($0.SendContributionMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SendContributionMessageResponse.fromBuffer(value));
  static final _$listContributionMessages = $grpc.ClientMethod<
          $0.ListContributionMessagesRequest,
          $0.ListContributionMessagesResponse>(
      '/group_accounts.GroupAccountService/ListContributionMessages',
      ($0.ListContributionMessagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListContributionMessagesResponse.fromBuffer(value));
  static final _$getGroupStatistics = $grpc.ClientMethod<
          $0.GetGroupStatisticsRequest, $0.GetGroupStatisticsResponse>(
      '/group_accounts.GroupAccountService/GetGroupStatistics',
      ($0.GetGroupStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetGroupStatisticsResponse.fromBuffer(value));
  static final _$getUserContributionStats = $grpc.ClientMethod<
          $0.GetUserContributionStatsRequest,
          $0.GetUserContributionStatsResponse>(
      '/group_accounts.GroupAccountService/GetUserContributionStats',
      ($0.GetUserContributionStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserContributionStatsResponse.fromBuffer(value));
  static final _$getOverdueContributions = $grpc.ClientMethod<
          $0.GetOverdueContributionsRequest,
          $0.GetOverdueContributionsResponse>(
      '/group_accounts.GroupAccountService/GetOverdueContributions',
      ($0.GetOverdueContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetOverdueContributionsResponse.fromBuffer(value));
  static final _$getContributionAnalytics = $grpc.ClientMethod<
          $0.GetContributionAnalyticsRequest,
          $0.GetContributionAnalyticsResponse>(
      '/group_accounts.GroupAccountService/GetContributionAnalytics',
      ($0.GetContributionAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetContributionAnalyticsResponse.fromBuffer(value));
  static final _$getGroupActivityLogs = $grpc.ClientMethod<
          $0.GetGroupActivityLogsRequest, $0.GetGroupActivityLogsResponse>(
      '/group_accounts.GroupAccountService/GetGroupActivityLogs',
      ($0.GetGroupActivityLogsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetGroupActivityLogsResponse.fromBuffer(value));
  static final _$getContributionActivityLogs = $grpc.ClientMethod<
          $0.GetContributionActivityLogsRequest,
          $0.GetContributionActivityLogsResponse>(
      '/group_accounts.GroupAccountService/GetContributionActivityLogs',
      ($0.GetContributionActivityLogsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetContributionActivityLogsResponse.fromBuffer(value));
  static final _$listPublicGroups = $grpc.ClientMethod<
          $0.ListPublicGroupsRequest, $0.ListPublicGroupsResponse>(
      '/group_accounts.GroupAccountService/ListPublicGroups',
      ($0.ListPublicGroupsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListPublicGroupsResponse.fromBuffer(value));
  static final _$getPublicGroup =
      $grpc.ClientMethod<$0.GetPublicGroupRequest, $0.GetPublicGroupResponse>(
          '/group_accounts.GroupAccountService/GetPublicGroup',
          ($0.GetPublicGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetPublicGroupResponse.fromBuffer(value));
  static final _$joinPublicGroup =
      $grpc.ClientMethod<$0.JoinPublicGroupRequest, $0.JoinPublicGroupResponse>(
          '/group_accounts.GroupAccountService/JoinPublicGroup',
          ($0.JoinPublicGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.JoinPublicGroupResponse.fromBuffer(value));

  GroupAccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateGroupResponse> createGroup(
      $0.CreateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupResponse> getGroup($0.GetGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListUserGroupsResponse> listUserGroups(
      $0.ListUserGroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listUserGroups, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateGroupResponse> updateGroup(
      $0.UpdateGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteGroupResponse> deleteGroup(
      $0.DeleteGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupMembersResponse> getGroupMembers(
      $0.GetGroupMembersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupMembers, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddMemberResponse> addMember(
      $0.AddMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateMemberRoleResponse> updateMemberRole(
      $0.UpdateMemberRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMemberRole, request, options: options);
  }

  $grpc.ResponseFuture<$0.RemoveMemberResponse> removeMember(
      $0.RemoveMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchUsersResponse> searchUsers(
      $0.SearchUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateContributionResponse> createContribution(
      $0.CreateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createContribution, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetContributionResponse> getContribution(
      $0.GetContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContribution, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListGroupContributionsResponse>
      listGroupContributions($0.ListGroupContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listGroupContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateContributionResponse> updateContribution(
      $0.UpdateContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateContribution, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteContributionResponse> deleteContribution(
      $0.DeleteContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteContribution, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddMembersToContributionResponse>
      addMembersToContribution($0.AddMembersToContributionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMembersToContribution, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.PreviewMemberExitResponse> previewMemberExit(
      $0.PreviewMemberExitRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$previewMemberExit, request, options: options);
  }

  $grpc.ResponseFuture<$0.InviteToGroupResponse> inviteToGroup(
      $0.InviteToGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$inviteToGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.RespondToGroupInviteResponse> respondToGroupInvite(
      $0.RespondToGroupInviteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$respondToGroupInvite, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelGroupInviteResponse> cancelGroupInvite(
      $0.CancelGroupInviteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelGroupInvite, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListMyInvitationsResponse> listMyInvitations(
      $0.ListMyInvitationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listMyInvitations, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListGroupInvitationsResponse> listGroupInvitations(
      $0.ListGroupInvitationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listGroupInvitations, request, options: options);
  }

  $grpc.ResponseFuture<$0.RemoveContributionShadowResponse>
      removeContributionShadow($0.RemoveContributionShadowRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeContributionShadow, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.RemoveMemberFromContributionResponse>
      removeMemberFromContribution(
          $0.RemoveMemberFromContributionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeMemberFromContribution, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetContributionMembersResponse>
      getContributionMembers($0.GetContributionMembersRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionMembers, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.MakePaymentResponse> makePayment(
      $0.MakePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makePayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetContributionPaymentsResponse>
      getContributionPayments($0.GetContributionPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdatePaymentStatusResponse> updatePaymentStatus(
      $0.UpdatePaymentStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProcessScheduledPaymentsResponse>
      processScheduledPayments($0.ProcessScheduledPaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processScheduledPayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetPayoutScheduleResponse> getPayoutSchedule(
      $0.GetPayoutScheduleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutSchedule, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProcessPayoutResponse> processPayout(
      $0.ProcessPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayout, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdatePayoutStatusResponse> updatePayoutStatus(
      $0.UpdatePayoutStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePayoutStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdvancePayoutRotationResponse> advancePayoutRotation(
      $0.AdvancePayoutRotationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$advancePayoutRotation, request, options: options);
  }

  $grpc.ResponseFuture<$0.SetPayoutReceiverResponse> setPayoutReceiver(
      $0.SetPayoutReceiverRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPayoutReceiver, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPayoutReceiverResponse> getPayoutReceiver(
      $0.GetPayoutReceiverRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutReceiver, request, options: options);
  }

  $grpc.ResponseFuture<$0.ClearPayoutReceiverResponse> clearPayoutReceiver(
      $0.ClearPayoutReceiverRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$clearPayoutReceiver, request, options: options);
  }

  $grpc.ResponseFuture<$0.TriggerManualPayoutResponse> triggerManualPayout(
      $0.TriggerManualPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerManualPayout, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListScheduledPayoutsResponse> listScheduledPayouts(
      $0.ListScheduledPayoutsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listScheduledPayouts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetScheduledPayoutResponse> getScheduledPayout(
      $0.GetScheduledPayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getScheduledPayout, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateReceiptResponse> generateReceipt(
      $0.GenerateReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserContributionReceiptsResponse> getUserReceipts(
      $0.GetUserContributionReceiptsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateTranscriptResponse> generateTranscript(
      $0.GenerateTranscriptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateTranscript, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListContributionCyclesResponse>
      listContributionCycles($0.ListContributionCyclesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listContributionCycles, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetContributionCycleDetailsResponse>
      getContributionCycleDetails($0.GetContributionCycleDetailsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionCycleDetails, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.RestartContributionResponse> restartContribution(
      $0.RestartContributionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$restartContribution, request, options: options);
  }

  $grpc.ResponseFuture<$0.SendContributionMessageResponse>
      sendContributionMessage($0.SendContributionMessageRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendContributionMessage, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ListContributionMessagesResponse>
      listContributionMessages($0.ListContributionMessagesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listContributionMessages, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupStatisticsResponse> getGroupStatistics(
      $0.GetGroupStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserContributionStatsResponse>
      getUserContributionStats($0.GetUserContributionStatsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserContributionStats, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetOverdueContributionsResponse>
      getOverdueContributions($0.GetOverdueContributionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueContributions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetContributionAnalyticsResponse>
      getContributionAnalytics($0.GetContributionAnalyticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionAnalytics, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupActivityLogsResponse> getGroupActivityLogs(
      $0.GetGroupActivityLogsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupActivityLogs, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetContributionActivityLogsResponse>
      getContributionActivityLogs($0.GetContributionActivityLogsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionActivityLogs, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ListPublicGroupsResponse> listPublicGroups(
      $0.ListPublicGroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPublicGroups, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPublicGroupResponse> getPublicGroup(
      $0.GetPublicGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPublicGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.JoinPublicGroupResponse> joinPublicGroup(
      $0.JoinPublicGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$joinPublicGroup, request, options: options);
  }
}

abstract class GroupAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'group_accounts.GroupAccountService';

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
    $addMethod($grpc.ServiceMethod<$0.PreviewMemberExitRequest,
            $0.PreviewMemberExitResponse>(
        'PreviewMemberExit',
        previewMemberExit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PreviewMemberExitRequest.fromBuffer(value),
        ($0.PreviewMemberExitResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.InviteToGroupRequest, $0.InviteToGroupResponse>(
            'InviteToGroup',
            inviteToGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.InviteToGroupRequest.fromBuffer(value),
            ($0.InviteToGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RespondToGroupInviteRequest,
            $0.RespondToGroupInviteResponse>(
        'RespondToGroupInvite',
        respondToGroupInvite_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RespondToGroupInviteRequest.fromBuffer(value),
        ($0.RespondToGroupInviteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelGroupInviteRequest,
            $0.CancelGroupInviteResponse>(
        'CancelGroupInvite',
        cancelGroupInvite_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelGroupInviteRequest.fromBuffer(value),
        ($0.CancelGroupInviteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListMyInvitationsRequest,
            $0.ListMyInvitationsResponse>(
        'ListMyInvitations',
        listMyInvitations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListMyInvitationsRequest.fromBuffer(value),
        ($0.ListMyInvitationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListGroupInvitationsRequest,
            $0.ListGroupInvitationsResponse>(
        'ListGroupInvitations',
        listGroupInvitations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListGroupInvitationsRequest.fromBuffer(value),
        ($0.ListGroupInvitationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveContributionShadowRequest,
            $0.RemoveContributionShadowResponse>(
        'RemoveContributionShadow',
        removeContributionShadow_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RemoveContributionShadowRequest.fromBuffer(value),
        ($0.RemoveContributionShadowResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$0.SetPayoutReceiverRequest,
            $0.SetPayoutReceiverResponse>(
        'SetPayoutReceiver',
        setPayoutReceiver_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetPayoutReceiverRequest.fromBuffer(value),
        ($0.SetPayoutReceiverResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPayoutReceiverRequest,
            $0.GetPayoutReceiverResponse>(
        'GetPayoutReceiver',
        getPayoutReceiver_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPayoutReceiverRequest.fromBuffer(value),
        ($0.GetPayoutReceiverResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ClearPayoutReceiverRequest,
            $0.ClearPayoutReceiverResponse>(
        'ClearPayoutReceiver',
        clearPayoutReceiver_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ClearPayoutReceiverRequest.fromBuffer(value),
        ($0.ClearPayoutReceiverResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TriggerManualPayoutRequest,
            $0.TriggerManualPayoutResponse>(
        'TriggerManualPayout',
        triggerManualPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TriggerManualPayoutRequest.fromBuffer(value),
        ($0.TriggerManualPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListScheduledPayoutsRequest,
            $0.ListScheduledPayoutsResponse>(
        'ListScheduledPayouts',
        listScheduledPayouts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListScheduledPayoutsRequest.fromBuffer(value),
        ($0.ListScheduledPayoutsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetScheduledPayoutRequest,
            $0.GetScheduledPayoutResponse>(
        'GetScheduledPayout',
        getScheduledPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetScheduledPayoutRequest.fromBuffer(value),
        ($0.GetScheduledPayoutResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$0.ListContributionCyclesRequest,
            $0.ListContributionCyclesResponse>(
        'ListContributionCycles',
        listContributionCycles_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListContributionCyclesRequest.fromBuffer(value),
        ($0.ListContributionCyclesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetContributionCycleDetailsRequest,
            $0.GetContributionCycleDetailsResponse>(
        'GetContributionCycleDetails',
        getContributionCycleDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetContributionCycleDetailsRequest.fromBuffer(value),
        ($0.GetContributionCycleDetailsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RestartContributionRequest,
            $0.RestartContributionResponse>(
        'RestartContribution',
        restartContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RestartContributionRequest.fromBuffer(value),
        ($0.RestartContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendContributionMessageRequest,
            $0.SendContributionMessageResponse>(
        'SendContributionMessage',
        sendContributionMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SendContributionMessageRequest.fromBuffer(value),
        ($0.SendContributionMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListContributionMessagesRequest,
            $0.ListContributionMessagesResponse>(
        'ListContributionMessages',
        listContributionMessages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListContributionMessagesRequest.fromBuffer(value),
        ($0.ListContributionMessagesResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$0.GetOverdueContributionsRequest,
            $0.GetOverdueContributionsResponse>(
        'GetOverdueContributions',
        getOverdueContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetOverdueContributionsRequest.fromBuffer(value),
        ($0.GetOverdueContributionsResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$0.ListPublicGroupsRequest,
            $0.ListPublicGroupsResponse>(
        'ListPublicGroups',
        listPublicGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListPublicGroupsRequest.fromBuffer(value),
        ($0.ListPublicGroupsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPublicGroupRequest,
            $0.GetPublicGroupResponse>(
        'GetPublicGroup',
        getPublicGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPublicGroupRequest.fromBuffer(value),
        ($0.GetPublicGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JoinPublicGroupRequest,
            $0.JoinPublicGroupResponse>(
        'JoinPublicGroup',
        joinPublicGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.JoinPublicGroupRequest.fromBuffer(value),
        ($0.JoinPublicGroupResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateGroupResponse> createGroup_Pre($grpc.ServiceCall call,
      $async.Future<$0.CreateGroupRequest> request) async {
    return createGroup(call, await request);
  }

  $async.Future<$0.GetGroupResponse> getGroup_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetGroupRequest> request) async {
    return getGroup(call, await request);
  }

  $async.Future<$0.ListUserGroupsResponse> listUserGroups_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListUserGroupsRequest> request) async {
    return listUserGroups(call, await request);
  }

  $async.Future<$0.UpdateGroupResponse> updateGroup_Pre($grpc.ServiceCall call,
      $async.Future<$0.UpdateGroupRequest> request) async {
    return updateGroup(call, await request);
  }

  $async.Future<$0.DeleteGroupResponse> deleteGroup_Pre($grpc.ServiceCall call,
      $async.Future<$0.DeleteGroupRequest> request) async {
    return deleteGroup(call, await request);
  }

  $async.Future<$0.GetGroupMembersResponse> getGroupMembers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetGroupMembersRequest> request) async {
    return getGroupMembers(call, await request);
  }

  $async.Future<$0.AddMemberResponse> addMember_Pre($grpc.ServiceCall call,
      $async.Future<$0.AddMemberRequest> request) async {
    return addMember(call, await request);
  }

  $async.Future<$0.UpdateMemberRoleResponse> updateMemberRole_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateMemberRoleRequest> request) async {
    return updateMemberRole(call, await request);
  }

  $async.Future<$0.RemoveMemberResponse> removeMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RemoveMemberRequest> request) async {
    return removeMember(call, await request);
  }

  $async.Future<$0.SearchUsersResponse> searchUsers_Pre($grpc.ServiceCall call,
      $async.Future<$0.SearchUsersRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$0.CreateContributionResponse> createContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateContributionRequest> request) async {
    return createContribution(call, await request);
  }

  $async.Future<$0.GetContributionResponse> getContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetContributionRequest> request) async {
    return getContribution(call, await request);
  }

  $async.Future<$0.ListGroupContributionsResponse> listGroupContributions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListGroupContributionsRequest> request) async {
    return listGroupContributions(call, await request);
  }

  $async.Future<$0.UpdateContributionResponse> updateContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateContributionRequest> request) async {
    return updateContribution(call, await request);
  }

  $async.Future<$0.DeleteContributionResponse> deleteContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteContributionRequest> request) async {
    return deleteContribution(call, await request);
  }

  $async.Future<$0.AddMembersToContributionResponse>
      addMembersToContribution_Pre($grpc.ServiceCall call,
          $async.Future<$0.AddMembersToContributionRequest> request) async {
    return addMembersToContribution(call, await request);
  }

  $async.Future<$0.PreviewMemberExitResponse> previewMemberExit_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PreviewMemberExitRequest> request) async {
    return previewMemberExit(call, await request);
  }

  $async.Future<$0.InviteToGroupResponse> inviteToGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.InviteToGroupRequest> request) async {
    return inviteToGroup(call, await request);
  }

  $async.Future<$0.RespondToGroupInviteResponse> respondToGroupInvite_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RespondToGroupInviteRequest> request) async {
    return respondToGroupInvite(call, await request);
  }

  $async.Future<$0.CancelGroupInviteResponse> cancelGroupInvite_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CancelGroupInviteRequest> request) async {
    return cancelGroupInvite(call, await request);
  }

  $async.Future<$0.ListMyInvitationsResponse> listMyInvitations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListMyInvitationsRequest> request) async {
    return listMyInvitations(call, await request);
  }

  $async.Future<$0.ListGroupInvitationsResponse> listGroupInvitations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListGroupInvitationsRequest> request) async {
    return listGroupInvitations(call, await request);
  }

  $async.Future<$0.RemoveContributionShadowResponse>
      removeContributionShadow_Pre($grpc.ServiceCall call,
          $async.Future<$0.RemoveContributionShadowRequest> request) async {
    return removeContributionShadow(call, await request);
  }

  $async.Future<$0.RemoveMemberFromContributionResponse>
      removeMemberFromContribution_Pre($grpc.ServiceCall call,
          $async.Future<$0.RemoveMemberFromContributionRequest> request) async {
    return removeMemberFromContribution(call, await request);
  }

  $async.Future<$0.GetContributionMembersResponse> getContributionMembers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetContributionMembersRequest> request) async {
    return getContributionMembers(call, await request);
  }

  $async.Future<$0.MakePaymentResponse> makePayment_Pre($grpc.ServiceCall call,
      $async.Future<$0.MakePaymentRequest> request) async {
    return makePayment(call, await request);
  }

  $async.Future<$0.GetContributionPaymentsResponse> getContributionPayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetContributionPaymentsRequest> request) async {
    return getContributionPayments(call, await request);
  }

  $async.Future<$0.UpdatePaymentStatusResponse> updatePaymentStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdatePaymentStatusRequest> request) async {
    return updatePaymentStatus(call, await request);
  }

  $async.Future<$0.ProcessScheduledPaymentsResponse>
      processScheduledPayments_Pre($grpc.ServiceCall call,
          $async.Future<$0.ProcessScheduledPaymentsRequest> request) async {
    return processScheduledPayments(call, await request);
  }

  $async.Future<$0.GetPayoutScheduleResponse> getPayoutSchedule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetPayoutScheduleRequest> request) async {
    return getPayoutSchedule(call, await request);
  }

  $async.Future<$0.ProcessPayoutResponse> processPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ProcessPayoutRequest> request) async {
    return processPayout(call, await request);
  }

  $async.Future<$0.UpdatePayoutStatusResponse> updatePayoutStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdatePayoutStatusRequest> request) async {
    return updatePayoutStatus(call, await request);
  }

  $async.Future<$0.AdvancePayoutRotationResponse> advancePayoutRotation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdvancePayoutRotationRequest> request) async {
    return advancePayoutRotation(call, await request);
  }

  $async.Future<$0.SetPayoutReceiverResponse> setPayoutReceiver_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SetPayoutReceiverRequest> request) async {
    return setPayoutReceiver(call, await request);
  }

  $async.Future<$0.GetPayoutReceiverResponse> getPayoutReceiver_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetPayoutReceiverRequest> request) async {
    return getPayoutReceiver(call, await request);
  }

  $async.Future<$0.ClearPayoutReceiverResponse> clearPayoutReceiver_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ClearPayoutReceiverRequest> request) async {
    return clearPayoutReceiver(call, await request);
  }

  $async.Future<$0.TriggerManualPayoutResponse> triggerManualPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.TriggerManualPayoutRequest> request) async {
    return triggerManualPayout(call, await request);
  }

  $async.Future<$0.ListScheduledPayoutsResponse> listScheduledPayouts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListScheduledPayoutsRequest> request) async {
    return listScheduledPayouts(call, await request);
  }

  $async.Future<$0.GetScheduledPayoutResponse> getScheduledPayout_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetScheduledPayoutRequest> request) async {
    return getScheduledPayout(call, await request);
  }

  $async.Future<$0.GenerateReceiptResponse> generateReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GenerateReceiptRequest> request) async {
    return generateReceipt(call, await request);
  }

  $async.Future<$0.GetUserContributionReceiptsResponse> getUserReceipts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserContributionReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$0.GenerateTranscriptResponse> generateTranscript_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GenerateTranscriptRequest> request) async {
    return generateTranscript(call, await request);
  }

  $async.Future<$0.ListContributionCyclesResponse> listContributionCycles_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListContributionCyclesRequest> request) async {
    return listContributionCycles(call, await request);
  }

  $async.Future<$0.GetContributionCycleDetailsResponse>
      getContributionCycleDetails_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetContributionCycleDetailsRequest> request) async {
    return getContributionCycleDetails(call, await request);
  }

  $async.Future<$0.RestartContributionResponse> restartContribution_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RestartContributionRequest> request) async {
    return restartContribution(call, await request);
  }

  $async.Future<$0.SendContributionMessageResponse> sendContributionMessage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SendContributionMessageRequest> request) async {
    return sendContributionMessage(call, await request);
  }

  $async.Future<$0.ListContributionMessagesResponse>
      listContributionMessages_Pre($grpc.ServiceCall call,
          $async.Future<$0.ListContributionMessagesRequest> request) async {
    return listContributionMessages(call, await request);
  }

  $async.Future<$0.GetGroupStatisticsResponse> getGroupStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetGroupStatisticsRequest> request) async {
    return getGroupStatistics(call, await request);
  }

  $async.Future<$0.GetUserContributionStatsResponse>
      getUserContributionStats_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetUserContributionStatsRequest> request) async {
    return getUserContributionStats(call, await request);
  }

  $async.Future<$0.GetOverdueContributionsResponse> getOverdueContributions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetOverdueContributionsRequest> request) async {
    return getOverdueContributions(call, await request);
  }

  $async.Future<$0.GetContributionAnalyticsResponse>
      getContributionAnalytics_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetContributionAnalyticsRequest> request) async {
    return getContributionAnalytics(call, await request);
  }

  $async.Future<$0.GetGroupActivityLogsResponse> getGroupActivityLogs_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetGroupActivityLogsRequest> request) async {
    return getGroupActivityLogs(call, await request);
  }

  $async.Future<$0.GetContributionActivityLogsResponse>
      getContributionActivityLogs_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetContributionActivityLogsRequest> request) async {
    return getContributionActivityLogs(call, await request);
  }

  $async.Future<$0.ListPublicGroupsResponse> listPublicGroups_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListPublicGroupsRequest> request) async {
    return listPublicGroups(call, await request);
  }

  $async.Future<$0.GetPublicGroupResponse> getPublicGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetPublicGroupRequest> request) async {
    return getPublicGroup(call, await request);
  }

  $async.Future<$0.JoinPublicGroupResponse> joinPublicGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.JoinPublicGroupRequest> request) async {
    return joinPublicGroup(call, await request);
  }

  $async.Future<$0.CreateGroupResponse> createGroup(
      $grpc.ServiceCall call, $0.CreateGroupRequest request);
  $async.Future<$0.GetGroupResponse> getGroup(
      $grpc.ServiceCall call, $0.GetGroupRequest request);
  $async.Future<$0.ListUserGroupsResponse> listUserGroups(
      $grpc.ServiceCall call, $0.ListUserGroupsRequest request);
  $async.Future<$0.UpdateGroupResponse> updateGroup(
      $grpc.ServiceCall call, $0.UpdateGroupRequest request);
  $async.Future<$0.DeleteGroupResponse> deleteGroup(
      $grpc.ServiceCall call, $0.DeleteGroupRequest request);
  $async.Future<$0.GetGroupMembersResponse> getGroupMembers(
      $grpc.ServiceCall call, $0.GetGroupMembersRequest request);
  $async.Future<$0.AddMemberResponse> addMember(
      $grpc.ServiceCall call, $0.AddMemberRequest request);
  $async.Future<$0.UpdateMemberRoleResponse> updateMemberRole(
      $grpc.ServiceCall call, $0.UpdateMemberRoleRequest request);
  $async.Future<$0.RemoveMemberResponse> removeMember(
      $grpc.ServiceCall call, $0.RemoveMemberRequest request);
  $async.Future<$0.SearchUsersResponse> searchUsers(
      $grpc.ServiceCall call, $0.SearchUsersRequest request);
  $async.Future<$0.CreateContributionResponse> createContribution(
      $grpc.ServiceCall call, $0.CreateContributionRequest request);
  $async.Future<$0.GetContributionResponse> getContribution(
      $grpc.ServiceCall call, $0.GetContributionRequest request);
  $async.Future<$0.ListGroupContributionsResponse> listGroupContributions(
      $grpc.ServiceCall call, $0.ListGroupContributionsRequest request);
  $async.Future<$0.UpdateContributionResponse> updateContribution(
      $grpc.ServiceCall call, $0.UpdateContributionRequest request);
  $async.Future<$0.DeleteContributionResponse> deleteContribution(
      $grpc.ServiceCall call, $0.DeleteContributionRequest request);
  $async.Future<$0.AddMembersToContributionResponse> addMembersToContribution(
      $grpc.ServiceCall call, $0.AddMembersToContributionRequest request);
  $async.Future<$0.PreviewMemberExitResponse> previewMemberExit(
      $grpc.ServiceCall call, $0.PreviewMemberExitRequest request);
  $async.Future<$0.InviteToGroupResponse> inviteToGroup(
      $grpc.ServiceCall call, $0.InviteToGroupRequest request);
  $async.Future<$0.RespondToGroupInviteResponse> respondToGroupInvite(
      $grpc.ServiceCall call, $0.RespondToGroupInviteRequest request);
  $async.Future<$0.CancelGroupInviteResponse> cancelGroupInvite(
      $grpc.ServiceCall call, $0.CancelGroupInviteRequest request);
  $async.Future<$0.ListMyInvitationsResponse> listMyInvitations(
      $grpc.ServiceCall call, $0.ListMyInvitationsRequest request);
  $async.Future<$0.ListGroupInvitationsResponse> listGroupInvitations(
      $grpc.ServiceCall call, $0.ListGroupInvitationsRequest request);
  $async.Future<$0.RemoveContributionShadowResponse> removeContributionShadow(
      $grpc.ServiceCall call, $0.RemoveContributionShadowRequest request);
  $async.Future<$0.RemoveMemberFromContributionResponse>
      removeMemberFromContribution($grpc.ServiceCall call,
          $0.RemoveMemberFromContributionRequest request);
  $async.Future<$0.GetContributionMembersResponse> getContributionMembers(
      $grpc.ServiceCall call, $0.GetContributionMembersRequest request);
  $async.Future<$0.MakePaymentResponse> makePayment(
      $grpc.ServiceCall call, $0.MakePaymentRequest request);
  $async.Future<$0.GetContributionPaymentsResponse> getContributionPayments(
      $grpc.ServiceCall call, $0.GetContributionPaymentsRequest request);
  $async.Future<$0.UpdatePaymentStatusResponse> updatePaymentStatus(
      $grpc.ServiceCall call, $0.UpdatePaymentStatusRequest request);
  $async.Future<$0.ProcessScheduledPaymentsResponse> processScheduledPayments(
      $grpc.ServiceCall call, $0.ProcessScheduledPaymentsRequest request);
  $async.Future<$0.GetPayoutScheduleResponse> getPayoutSchedule(
      $grpc.ServiceCall call, $0.GetPayoutScheduleRequest request);
  $async.Future<$0.ProcessPayoutResponse> processPayout(
      $grpc.ServiceCall call, $0.ProcessPayoutRequest request);
  $async.Future<$0.UpdatePayoutStatusResponse> updatePayoutStatus(
      $grpc.ServiceCall call, $0.UpdatePayoutStatusRequest request);
  $async.Future<$0.AdvancePayoutRotationResponse> advancePayoutRotation(
      $grpc.ServiceCall call, $0.AdvancePayoutRotationRequest request);
  $async.Future<$0.SetPayoutReceiverResponse> setPayoutReceiver(
      $grpc.ServiceCall call, $0.SetPayoutReceiverRequest request);
  $async.Future<$0.GetPayoutReceiverResponse> getPayoutReceiver(
      $grpc.ServiceCall call, $0.GetPayoutReceiverRequest request);
  $async.Future<$0.ClearPayoutReceiverResponse> clearPayoutReceiver(
      $grpc.ServiceCall call, $0.ClearPayoutReceiverRequest request);
  $async.Future<$0.TriggerManualPayoutResponse> triggerManualPayout(
      $grpc.ServiceCall call, $0.TriggerManualPayoutRequest request);
  $async.Future<$0.ListScheduledPayoutsResponse> listScheduledPayouts(
      $grpc.ServiceCall call, $0.ListScheduledPayoutsRequest request);
  $async.Future<$0.GetScheduledPayoutResponse> getScheduledPayout(
      $grpc.ServiceCall call, $0.GetScheduledPayoutRequest request);
  $async.Future<$0.GenerateReceiptResponse> generateReceipt(
      $grpc.ServiceCall call, $0.GenerateReceiptRequest request);
  $async.Future<$0.GetUserContributionReceiptsResponse> getUserReceipts(
      $grpc.ServiceCall call, $0.GetUserContributionReceiptsRequest request);
  $async.Future<$0.GenerateTranscriptResponse> generateTranscript(
      $grpc.ServiceCall call, $0.GenerateTranscriptRequest request);
  $async.Future<$0.ListContributionCyclesResponse> listContributionCycles(
      $grpc.ServiceCall call, $0.ListContributionCyclesRequest request);
  $async.Future<$0.GetContributionCycleDetailsResponse>
      getContributionCycleDetails($grpc.ServiceCall call,
          $0.GetContributionCycleDetailsRequest request);
  $async.Future<$0.RestartContributionResponse> restartContribution(
      $grpc.ServiceCall call, $0.RestartContributionRequest request);
  $async.Future<$0.SendContributionMessageResponse> sendContributionMessage(
      $grpc.ServiceCall call, $0.SendContributionMessageRequest request);
  $async.Future<$0.ListContributionMessagesResponse> listContributionMessages(
      $grpc.ServiceCall call, $0.ListContributionMessagesRequest request);
  $async.Future<$0.GetGroupStatisticsResponse> getGroupStatistics(
      $grpc.ServiceCall call, $0.GetGroupStatisticsRequest request);
  $async.Future<$0.GetUserContributionStatsResponse> getUserContributionStats(
      $grpc.ServiceCall call, $0.GetUserContributionStatsRequest request);
  $async.Future<$0.GetOverdueContributionsResponse> getOverdueContributions(
      $grpc.ServiceCall call, $0.GetOverdueContributionsRequest request);
  $async.Future<$0.GetContributionAnalyticsResponse> getContributionAnalytics(
      $grpc.ServiceCall call, $0.GetContributionAnalyticsRequest request);
  $async.Future<$0.GetGroupActivityLogsResponse> getGroupActivityLogs(
      $grpc.ServiceCall call, $0.GetGroupActivityLogsRequest request);
  $async.Future<$0.GetContributionActivityLogsResponse>
      getContributionActivityLogs($grpc.ServiceCall call,
          $0.GetContributionActivityLogsRequest request);
  $async.Future<$0.ListPublicGroupsResponse> listPublicGroups(
      $grpc.ServiceCall call, $0.ListPublicGroupsRequest request);
  $async.Future<$0.GetPublicGroupResponse> getPublicGroup(
      $grpc.ServiceCall call, $0.GetPublicGroupRequest request);
  $async.Future<$0.JoinPublicGroupResponse> joinPublicGroup(
      $grpc.ServiceCall call, $0.JoinPublicGroupRequest request);
}
