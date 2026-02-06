//
//  Generated code. Do not modify.
//  source: group_account.proto
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

import 'group_account.pb.dart' as $21;

export 'group_account.pb.dart';

@$pb.GrpcServiceName('pb.GroupAccountService')
class GroupAccountServiceClient extends $grpc.Client {
  static final _$createGroup = $grpc.ClientMethod<$21.CreateGroupRequest, $21.CreateGroupResponse>(
      '/pb.GroupAccountService/CreateGroup',
      ($21.CreateGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.CreateGroupResponse.fromBuffer(value));
  static final _$getGroup = $grpc.ClientMethod<$21.GetGroupRequest, $21.GetGroupResponse>(
      '/pb.GroupAccountService/GetGroup',
      ($21.GetGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetGroupResponse.fromBuffer(value));
  static final _$listUserGroups = $grpc.ClientMethod<$21.ListUserGroupsRequest, $21.ListUserGroupsResponse>(
      '/pb.GroupAccountService/ListUserGroups',
      ($21.ListUserGroupsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.ListUserGroupsResponse.fromBuffer(value));
  static final _$updateGroup = $grpc.ClientMethod<$21.UpdateGroupRequest, $21.UpdateGroupResponse>(
      '/pb.GroupAccountService/UpdateGroup',
      ($21.UpdateGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.UpdateGroupResponse.fromBuffer(value));
  static final _$deleteGroup = $grpc.ClientMethod<$21.DeleteGroupRequest, $21.DeleteGroupResponse>(
      '/pb.GroupAccountService/DeleteGroup',
      ($21.DeleteGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.DeleteGroupResponse.fromBuffer(value));
  static final _$getGroupMembers = $grpc.ClientMethod<$21.GetGroupMembersRequest, $21.GetGroupMembersResponse>(
      '/pb.GroupAccountService/GetGroupMembers',
      ($21.GetGroupMembersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetGroupMembersResponse.fromBuffer(value));
  static final _$addMember = $grpc.ClientMethod<$21.AddMemberRequest, $21.AddMemberResponse>(
      '/pb.GroupAccountService/AddMember',
      ($21.AddMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.AddMemberResponse.fromBuffer(value));
  static final _$updateMemberRole = $grpc.ClientMethod<$21.UpdateMemberRoleRequest, $21.UpdateMemberRoleResponse>(
      '/pb.GroupAccountService/UpdateMemberRole',
      ($21.UpdateMemberRoleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.UpdateMemberRoleResponse.fromBuffer(value));
  static final _$removeMember = $grpc.ClientMethod<$21.RemoveMemberRequest, $21.RemoveMemberResponse>(
      '/pb.GroupAccountService/RemoveMember',
      ($21.RemoveMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.RemoveMemberResponse.fromBuffer(value));
  static final _$searchUsers = $grpc.ClientMethod<$21.SearchUsersRequest, $21.SearchUsersResponse>(
      '/pb.GroupAccountService/SearchUsers',
      ($21.SearchUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.SearchUsersResponse.fromBuffer(value));
  static final _$createContribution = $grpc.ClientMethod<$21.CreateContributionRequest, $21.CreateContributionResponse>(
      '/pb.GroupAccountService/CreateContribution',
      ($21.CreateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.CreateContributionResponse.fromBuffer(value));
  static final _$getContribution = $grpc.ClientMethod<$21.GetContributionRequest, $21.GetContributionResponse>(
      '/pb.GroupAccountService/GetContribution',
      ($21.GetContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetContributionResponse.fromBuffer(value));
  static final _$listGroupContributions = $grpc.ClientMethod<$21.ListGroupContributionsRequest, $21.ListGroupContributionsResponse>(
      '/pb.GroupAccountService/ListGroupContributions',
      ($21.ListGroupContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.ListGroupContributionsResponse.fromBuffer(value));
  static final _$updateContribution = $grpc.ClientMethod<$21.UpdateContributionRequest, $21.UpdateContributionResponse>(
      '/pb.GroupAccountService/UpdateContribution',
      ($21.UpdateContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.UpdateContributionResponse.fromBuffer(value));
  static final _$deleteContribution = $grpc.ClientMethod<$21.DeleteContributionRequest, $21.DeleteContributionResponse>(
      '/pb.GroupAccountService/DeleteContribution',
      ($21.DeleteContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.DeleteContributionResponse.fromBuffer(value));
  static final _$addMembersToContribution = $grpc.ClientMethod<$21.AddMembersToContributionRequest, $21.AddMembersToContributionResponse>(
      '/pb.GroupAccountService/AddMembersToContribution',
      ($21.AddMembersToContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.AddMembersToContributionResponse.fromBuffer(value));
  static final _$removeMemberFromContribution = $grpc.ClientMethod<$21.RemoveMemberFromContributionRequest, $21.RemoveMemberFromContributionResponse>(
      '/pb.GroupAccountService/RemoveMemberFromContribution',
      ($21.RemoveMemberFromContributionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.RemoveMemberFromContributionResponse.fromBuffer(value));
  static final _$getContributionMembers = $grpc.ClientMethod<$21.GetContributionMembersRequest, $21.GetContributionMembersResponse>(
      '/pb.GroupAccountService/GetContributionMembers',
      ($21.GetContributionMembersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetContributionMembersResponse.fromBuffer(value));
  static final _$makePayment = $grpc.ClientMethod<$21.MakePaymentRequest, $21.MakePaymentResponse>(
      '/pb.GroupAccountService/MakePayment',
      ($21.MakePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.MakePaymentResponse.fromBuffer(value));
  static final _$getContributionPayments = $grpc.ClientMethod<$21.GetContributionPaymentsRequest, $21.GetContributionPaymentsResponse>(
      '/pb.GroupAccountService/GetContributionPayments',
      ($21.GetContributionPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetContributionPaymentsResponse.fromBuffer(value));
  static final _$updatePaymentStatus = $grpc.ClientMethod<$21.UpdatePaymentStatusRequest, $21.UpdatePaymentStatusResponse>(
      '/pb.GroupAccountService/UpdatePaymentStatus',
      ($21.UpdatePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.UpdatePaymentStatusResponse.fromBuffer(value));
  static final _$processScheduledPayments = $grpc.ClientMethod<$21.ProcessScheduledPaymentsRequest, $21.ProcessScheduledPaymentsResponse>(
      '/pb.GroupAccountService/ProcessScheduledPayments',
      ($21.ProcessScheduledPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.ProcessScheduledPaymentsResponse.fromBuffer(value));
  static final _$getOverdueContributions = $grpc.ClientMethod<$21.GetOverdueContributionsRequest, $21.GetOverdueContributionsResponse>(
      '/pb.GroupAccountService/GetOverdueContributions',
      ($21.GetOverdueContributionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetOverdueContributionsResponse.fromBuffer(value));
  static final _$getPayoutSchedule = $grpc.ClientMethod<$21.GetPayoutScheduleRequest, $21.GetPayoutScheduleResponse>(
      '/pb.GroupAccountService/GetPayoutSchedule',
      ($21.GetPayoutScheduleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetPayoutScheduleResponse.fromBuffer(value));
  static final _$processPayout = $grpc.ClientMethod<$21.ProcessPayoutRequest, $21.ProcessPayoutResponse>(
      '/pb.GroupAccountService/ProcessPayout',
      ($21.ProcessPayoutRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.ProcessPayoutResponse.fromBuffer(value));
  static final _$updatePayoutStatus = $grpc.ClientMethod<$21.UpdatePayoutStatusRequest, $21.UpdatePayoutStatusResponse>(
      '/pb.GroupAccountService/UpdatePayoutStatus',
      ($21.UpdatePayoutStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.UpdatePayoutStatusResponse.fromBuffer(value));
  static final _$advancePayoutRotation = $grpc.ClientMethod<$21.AdvancePayoutRotationRequest, $21.AdvancePayoutRotationResponse>(
      '/pb.GroupAccountService/AdvancePayoutRotation',
      ($21.AdvancePayoutRotationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.AdvancePayoutRotationResponse.fromBuffer(value));
  static final _$generateReceipt = $grpc.ClientMethod<$21.GenerateReceiptRequest, $21.GenerateReceiptResponse>(
      '/pb.GroupAccountService/GenerateReceipt',
      ($21.GenerateReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GenerateReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<$21.GetUserContributionReceiptsRequest, $21.GetUserContributionReceiptsResponse>(
      '/pb.GroupAccountService/GetUserReceipts',
      ($21.GetUserContributionReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetUserContributionReceiptsResponse.fromBuffer(value));
  static final _$generateTranscript = $grpc.ClientMethod<$21.GenerateTranscriptRequest, $21.GenerateTranscriptResponse>(
      '/pb.GroupAccountService/GenerateTranscript',
      ($21.GenerateTranscriptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GenerateTranscriptResponse.fromBuffer(value));
  static final _$getGroupStatistics = $grpc.ClientMethod<$21.GetGroupStatisticsRequest, $21.GetGroupStatisticsResponse>(
      '/pb.GroupAccountService/GetGroupStatistics',
      ($21.GetGroupStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetGroupStatisticsResponse.fromBuffer(value));
  static final _$getUserContributionStats = $grpc.ClientMethod<$21.GetUserContributionStatsRequest, $21.GetUserContributionStatsResponse>(
      '/pb.GroupAccountService/GetUserContributionStats',
      ($21.GetUserContributionStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetUserContributionStatsResponse.fromBuffer(value));
  static final _$getContributionAnalytics = $grpc.ClientMethod<$21.GetContributionAnalyticsRequest, $21.GetContributionAnalyticsResponse>(
      '/pb.GroupAccountService/GetContributionAnalytics',
      ($21.GetContributionAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetContributionAnalyticsResponse.fromBuffer(value));
  static final _$getGroupActivityLogs = $grpc.ClientMethod<$21.GetGroupActivityLogsRequest, $21.GetGroupActivityLogsResponse>(
      '/pb.GroupAccountService/GetGroupActivityLogs',
      ($21.GetGroupActivityLogsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetGroupActivityLogsResponse.fromBuffer(value));
  static final _$getContributionActivityLogs = $grpc.ClientMethod<$21.GetContributionActivityLogsRequest, $21.GetContributionActivityLogsResponse>(
      '/pb.GroupAccountService/GetContributionActivityLogs',
      ($21.GetContributionActivityLogsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $21.GetContributionActivityLogsResponse.fromBuffer(value));

  GroupAccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$21.CreateGroupResponse> createGroup($21.CreateGroupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroup, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetGroupResponse> getGroup($21.GetGroupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroup, request, options: options);
  }

  $grpc.ResponseFuture<$21.ListUserGroupsResponse> listUserGroups($21.ListUserGroupsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listUserGroups, request, options: options);
  }

  $grpc.ResponseFuture<$21.UpdateGroupResponse> updateGroup($21.UpdateGroupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateGroup, request, options: options);
  }

  $grpc.ResponseFuture<$21.DeleteGroupResponse> deleteGroup($21.DeleteGroupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteGroup, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetGroupMembersResponse> getGroupMembers($21.GetGroupMembersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupMembers, request, options: options);
  }

  $grpc.ResponseFuture<$21.AddMemberResponse> addMember($21.AddMemberRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMember, request, options: options);
  }

  $grpc.ResponseFuture<$21.UpdateMemberRoleResponse> updateMemberRole($21.UpdateMemberRoleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMemberRole, request, options: options);
  }

  $grpc.ResponseFuture<$21.RemoveMemberResponse> removeMember($21.RemoveMemberRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeMember, request, options: options);
  }

  $grpc.ResponseFuture<$21.SearchUsersResponse> searchUsers($21.SearchUsersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$21.CreateContributionResponse> createContribution($21.CreateContributionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createContribution, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetContributionResponse> getContribution($21.GetContributionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContribution, request, options: options);
  }

  $grpc.ResponseFuture<$21.ListGroupContributionsResponse> listGroupContributions($21.ListGroupContributionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listGroupContributions, request, options: options);
  }

  $grpc.ResponseFuture<$21.UpdateContributionResponse> updateContribution($21.UpdateContributionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateContribution, request, options: options);
  }

  $grpc.ResponseFuture<$21.DeleteContributionResponse> deleteContribution($21.DeleteContributionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteContribution, request, options: options);
  }

  $grpc.ResponseFuture<$21.AddMembersToContributionResponse> addMembersToContribution($21.AddMembersToContributionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMembersToContribution, request, options: options);
  }

  $grpc.ResponseFuture<$21.RemoveMemberFromContributionResponse> removeMemberFromContribution($21.RemoveMemberFromContributionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeMemberFromContribution, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetContributionMembersResponse> getContributionMembers($21.GetContributionMembersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionMembers, request, options: options);
  }

  $grpc.ResponseFuture<$21.MakePaymentResponse> makePayment($21.MakePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makePayment, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetContributionPaymentsResponse> getContributionPayments($21.GetContributionPaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionPayments, request, options: options);
  }

  $grpc.ResponseFuture<$21.UpdatePaymentStatusResponse> updatePaymentStatus($21.UpdatePaymentStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$21.ProcessScheduledPaymentsResponse> processScheduledPayments($21.ProcessScheduledPaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processScheduledPayments, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetOverdueContributionsResponse> getOverdueContributions($21.GetOverdueContributionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueContributions, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetPayoutScheduleResponse> getPayoutSchedule($21.GetPayoutScheduleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayoutSchedule, request, options: options);
  }

  $grpc.ResponseFuture<$21.ProcessPayoutResponse> processPayout($21.ProcessPayoutRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayout, request, options: options);
  }

  $grpc.ResponseFuture<$21.UpdatePayoutStatusResponse> updatePayoutStatus($21.UpdatePayoutStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePayoutStatus, request, options: options);
  }

  $grpc.ResponseFuture<$21.AdvancePayoutRotationResponse> advancePayoutRotation($21.AdvancePayoutRotationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$advancePayoutRotation, request, options: options);
  }

  $grpc.ResponseFuture<$21.GenerateReceiptResponse> generateReceipt($21.GenerateReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetUserContributionReceiptsResponse> getUserReceipts($21.GetUserContributionReceiptsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$21.GenerateTranscriptResponse> generateTranscript($21.GenerateTranscriptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateTranscript, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetGroupStatisticsResponse> getGroupStatistics($21.GetGroupStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetUserContributionStatsResponse> getUserContributionStats($21.GetUserContributionStatsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserContributionStats, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetContributionAnalyticsResponse> getContributionAnalytics($21.GetContributionAnalyticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetGroupActivityLogsResponse> getGroupActivityLogs($21.GetGroupActivityLogsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupActivityLogs, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetContributionActivityLogsResponse> getContributionActivityLogs($21.GetContributionActivityLogsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContributionActivityLogs, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.GroupAccountService')
abstract class GroupAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GroupAccountService';

  GroupAccountServiceBase() {
    $addMethod($grpc.ServiceMethod<$21.CreateGroupRequest, $21.CreateGroupResponse>(
        'CreateGroup',
        createGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.CreateGroupRequest.fromBuffer(value),
        ($21.CreateGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetGroupRequest, $21.GetGroupResponse>(
        'GetGroup',
        getGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetGroupRequest.fromBuffer(value),
        ($21.GetGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.ListUserGroupsRequest, $21.ListUserGroupsResponse>(
        'ListUserGroups',
        listUserGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.ListUserGroupsRequest.fromBuffer(value),
        ($21.ListUserGroupsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.UpdateGroupRequest, $21.UpdateGroupResponse>(
        'UpdateGroup',
        updateGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.UpdateGroupRequest.fromBuffer(value),
        ($21.UpdateGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.DeleteGroupRequest, $21.DeleteGroupResponse>(
        'DeleteGroup',
        deleteGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.DeleteGroupRequest.fromBuffer(value),
        ($21.DeleteGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetGroupMembersRequest, $21.GetGroupMembersResponse>(
        'GetGroupMembers',
        getGroupMembers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetGroupMembersRequest.fromBuffer(value),
        ($21.GetGroupMembersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AddMemberRequest, $21.AddMemberResponse>(
        'AddMember',
        addMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.AddMemberRequest.fromBuffer(value),
        ($21.AddMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.UpdateMemberRoleRequest, $21.UpdateMemberRoleResponse>(
        'UpdateMemberRole',
        updateMemberRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.UpdateMemberRoleRequest.fromBuffer(value),
        ($21.UpdateMemberRoleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.RemoveMemberRequest, $21.RemoveMemberResponse>(
        'RemoveMember',
        removeMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.RemoveMemberRequest.fromBuffer(value),
        ($21.RemoveMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.SearchUsersRequest, $21.SearchUsersResponse>(
        'SearchUsers',
        searchUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.SearchUsersRequest.fromBuffer(value),
        ($21.SearchUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.CreateContributionRequest, $21.CreateContributionResponse>(
        'CreateContribution',
        createContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.CreateContributionRequest.fromBuffer(value),
        ($21.CreateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetContributionRequest, $21.GetContributionResponse>(
        'GetContribution',
        getContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetContributionRequest.fromBuffer(value),
        ($21.GetContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.ListGroupContributionsRequest, $21.ListGroupContributionsResponse>(
        'ListGroupContributions',
        listGroupContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.ListGroupContributionsRequest.fromBuffer(value),
        ($21.ListGroupContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.UpdateContributionRequest, $21.UpdateContributionResponse>(
        'UpdateContribution',
        updateContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.UpdateContributionRequest.fromBuffer(value),
        ($21.UpdateContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.DeleteContributionRequest, $21.DeleteContributionResponse>(
        'DeleteContribution',
        deleteContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.DeleteContributionRequest.fromBuffer(value),
        ($21.DeleteContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AddMembersToContributionRequest, $21.AddMembersToContributionResponse>(
        'AddMembersToContribution',
        addMembersToContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.AddMembersToContributionRequest.fromBuffer(value),
        ($21.AddMembersToContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.RemoveMemberFromContributionRequest, $21.RemoveMemberFromContributionResponse>(
        'RemoveMemberFromContribution',
        removeMemberFromContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.RemoveMemberFromContributionRequest.fromBuffer(value),
        ($21.RemoveMemberFromContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetContributionMembersRequest, $21.GetContributionMembersResponse>(
        'GetContributionMembers',
        getContributionMembers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetContributionMembersRequest.fromBuffer(value),
        ($21.GetContributionMembersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.MakePaymentRequest, $21.MakePaymentResponse>(
        'MakePayment',
        makePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.MakePaymentRequest.fromBuffer(value),
        ($21.MakePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetContributionPaymentsRequest, $21.GetContributionPaymentsResponse>(
        'GetContributionPayments',
        getContributionPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetContributionPaymentsRequest.fromBuffer(value),
        ($21.GetContributionPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.UpdatePaymentStatusRequest, $21.UpdatePaymentStatusResponse>(
        'UpdatePaymentStatus',
        updatePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.UpdatePaymentStatusRequest.fromBuffer(value),
        ($21.UpdatePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.ProcessScheduledPaymentsRequest, $21.ProcessScheduledPaymentsResponse>(
        'ProcessScheduledPayments',
        processScheduledPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.ProcessScheduledPaymentsRequest.fromBuffer(value),
        ($21.ProcessScheduledPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetOverdueContributionsRequest, $21.GetOverdueContributionsResponse>(
        'GetOverdueContributions',
        getOverdueContributions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetOverdueContributionsRequest.fromBuffer(value),
        ($21.GetOverdueContributionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetPayoutScheduleRequest, $21.GetPayoutScheduleResponse>(
        'GetPayoutSchedule',
        getPayoutSchedule_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetPayoutScheduleRequest.fromBuffer(value),
        ($21.GetPayoutScheduleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.ProcessPayoutRequest, $21.ProcessPayoutResponse>(
        'ProcessPayout',
        processPayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.ProcessPayoutRequest.fromBuffer(value),
        ($21.ProcessPayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.UpdatePayoutStatusRequest, $21.UpdatePayoutStatusResponse>(
        'UpdatePayoutStatus',
        updatePayoutStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.UpdatePayoutStatusRequest.fromBuffer(value),
        ($21.UpdatePayoutStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.AdvancePayoutRotationRequest, $21.AdvancePayoutRotationResponse>(
        'AdvancePayoutRotation',
        advancePayoutRotation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.AdvancePayoutRotationRequest.fromBuffer(value),
        ($21.AdvancePayoutRotationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GenerateReceiptRequest, $21.GenerateReceiptResponse>(
        'GenerateReceipt',
        generateReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GenerateReceiptRequest.fromBuffer(value),
        ($21.GenerateReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetUserContributionReceiptsRequest, $21.GetUserContributionReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetUserContributionReceiptsRequest.fromBuffer(value),
        ($21.GetUserContributionReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GenerateTranscriptRequest, $21.GenerateTranscriptResponse>(
        'GenerateTranscript',
        generateTranscript_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GenerateTranscriptRequest.fromBuffer(value),
        ($21.GenerateTranscriptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetGroupStatisticsRequest, $21.GetGroupStatisticsResponse>(
        'GetGroupStatistics',
        getGroupStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetGroupStatisticsRequest.fromBuffer(value),
        ($21.GetGroupStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetUserContributionStatsRequest, $21.GetUserContributionStatsResponse>(
        'GetUserContributionStats',
        getUserContributionStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetUserContributionStatsRequest.fromBuffer(value),
        ($21.GetUserContributionStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetContributionAnalyticsRequest, $21.GetContributionAnalyticsResponse>(
        'GetContributionAnalytics',
        getContributionAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetContributionAnalyticsRequest.fromBuffer(value),
        ($21.GetContributionAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetGroupActivityLogsRequest, $21.GetGroupActivityLogsResponse>(
        'GetGroupActivityLogs',
        getGroupActivityLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetGroupActivityLogsRequest.fromBuffer(value),
        ($21.GetGroupActivityLogsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetContributionActivityLogsRequest, $21.GetContributionActivityLogsResponse>(
        'GetContributionActivityLogs',
        getContributionActivityLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.GetContributionActivityLogsRequest.fromBuffer(value),
        ($21.GetContributionActivityLogsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$21.CreateGroupResponse> createGroup_Pre($grpc.ServiceCall call, $async.Future<$21.CreateGroupRequest> request) async {
    return createGroup(call, await request);
  }

  $async.Future<$21.GetGroupResponse> getGroup_Pre($grpc.ServiceCall call, $async.Future<$21.GetGroupRequest> request) async {
    return getGroup(call, await request);
  }

  $async.Future<$21.ListUserGroupsResponse> listUserGroups_Pre($grpc.ServiceCall call, $async.Future<$21.ListUserGroupsRequest> request) async {
    return listUserGroups(call, await request);
  }

  $async.Future<$21.UpdateGroupResponse> updateGroup_Pre($grpc.ServiceCall call, $async.Future<$21.UpdateGroupRequest> request) async {
    return updateGroup(call, await request);
  }

  $async.Future<$21.DeleteGroupResponse> deleteGroup_Pre($grpc.ServiceCall call, $async.Future<$21.DeleteGroupRequest> request) async {
    return deleteGroup(call, await request);
  }

  $async.Future<$21.GetGroupMembersResponse> getGroupMembers_Pre($grpc.ServiceCall call, $async.Future<$21.GetGroupMembersRequest> request) async {
    return getGroupMembers(call, await request);
  }

  $async.Future<$21.AddMemberResponse> addMember_Pre($grpc.ServiceCall call, $async.Future<$21.AddMemberRequest> request) async {
    return addMember(call, await request);
  }

  $async.Future<$21.UpdateMemberRoleResponse> updateMemberRole_Pre($grpc.ServiceCall call, $async.Future<$21.UpdateMemberRoleRequest> request) async {
    return updateMemberRole(call, await request);
  }

  $async.Future<$21.RemoveMemberResponse> removeMember_Pre($grpc.ServiceCall call, $async.Future<$21.RemoveMemberRequest> request) async {
    return removeMember(call, await request);
  }

  $async.Future<$21.SearchUsersResponse> searchUsers_Pre($grpc.ServiceCall call, $async.Future<$21.SearchUsersRequest> request) async {
    return searchUsers(call, await request);
  }

  $async.Future<$21.CreateContributionResponse> createContribution_Pre($grpc.ServiceCall call, $async.Future<$21.CreateContributionRequest> request) async {
    return createContribution(call, await request);
  }

  $async.Future<$21.GetContributionResponse> getContribution_Pre($grpc.ServiceCall call, $async.Future<$21.GetContributionRequest> request) async {
    return getContribution(call, await request);
  }

  $async.Future<$21.ListGroupContributionsResponse> listGroupContributions_Pre($grpc.ServiceCall call, $async.Future<$21.ListGroupContributionsRequest> request) async {
    return listGroupContributions(call, await request);
  }

  $async.Future<$21.UpdateContributionResponse> updateContribution_Pre($grpc.ServiceCall call, $async.Future<$21.UpdateContributionRequest> request) async {
    return updateContribution(call, await request);
  }

  $async.Future<$21.DeleteContributionResponse> deleteContribution_Pre($grpc.ServiceCall call, $async.Future<$21.DeleteContributionRequest> request) async {
    return deleteContribution(call, await request);
  }

  $async.Future<$21.AddMembersToContributionResponse> addMembersToContribution_Pre($grpc.ServiceCall call, $async.Future<$21.AddMembersToContributionRequest> request) async {
    return addMembersToContribution(call, await request);
  }

  $async.Future<$21.RemoveMemberFromContributionResponse> removeMemberFromContribution_Pre($grpc.ServiceCall call, $async.Future<$21.RemoveMemberFromContributionRequest> request) async {
    return removeMemberFromContribution(call, await request);
  }

  $async.Future<$21.GetContributionMembersResponse> getContributionMembers_Pre($grpc.ServiceCall call, $async.Future<$21.GetContributionMembersRequest> request) async {
    return getContributionMembers(call, await request);
  }

  $async.Future<$21.MakePaymentResponse> makePayment_Pre($grpc.ServiceCall call, $async.Future<$21.MakePaymentRequest> request) async {
    return makePayment(call, await request);
  }

  $async.Future<$21.GetContributionPaymentsResponse> getContributionPayments_Pre($grpc.ServiceCall call, $async.Future<$21.GetContributionPaymentsRequest> request) async {
    return getContributionPayments(call, await request);
  }

  $async.Future<$21.UpdatePaymentStatusResponse> updatePaymentStatus_Pre($grpc.ServiceCall call, $async.Future<$21.UpdatePaymentStatusRequest> request) async {
    return updatePaymentStatus(call, await request);
  }

  $async.Future<$21.ProcessScheduledPaymentsResponse> processScheduledPayments_Pre($grpc.ServiceCall call, $async.Future<$21.ProcessScheduledPaymentsRequest> request) async {
    return processScheduledPayments(call, await request);
  }

  $async.Future<$21.GetOverdueContributionsResponse> getOverdueContributions_Pre($grpc.ServiceCall call, $async.Future<$21.GetOverdueContributionsRequest> request) async {
    return getOverdueContributions(call, await request);
  }

  $async.Future<$21.GetPayoutScheduleResponse> getPayoutSchedule_Pre($grpc.ServiceCall call, $async.Future<$21.GetPayoutScheduleRequest> request) async {
    return getPayoutSchedule(call, await request);
  }

  $async.Future<$21.ProcessPayoutResponse> processPayout_Pre($grpc.ServiceCall call, $async.Future<$21.ProcessPayoutRequest> request) async {
    return processPayout(call, await request);
  }

  $async.Future<$21.UpdatePayoutStatusResponse> updatePayoutStatus_Pre($grpc.ServiceCall call, $async.Future<$21.UpdatePayoutStatusRequest> request) async {
    return updatePayoutStatus(call, await request);
  }

  $async.Future<$21.AdvancePayoutRotationResponse> advancePayoutRotation_Pre($grpc.ServiceCall call, $async.Future<$21.AdvancePayoutRotationRequest> request) async {
    return advancePayoutRotation(call, await request);
  }

  $async.Future<$21.GenerateReceiptResponse> generateReceipt_Pre($grpc.ServiceCall call, $async.Future<$21.GenerateReceiptRequest> request) async {
    return generateReceipt(call, await request);
  }

  $async.Future<$21.GetUserContributionReceiptsResponse> getUserReceipts_Pre($grpc.ServiceCall call, $async.Future<$21.GetUserContributionReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$21.GenerateTranscriptResponse> generateTranscript_Pre($grpc.ServiceCall call, $async.Future<$21.GenerateTranscriptRequest> request) async {
    return generateTranscript(call, await request);
  }

  $async.Future<$21.GetGroupStatisticsResponse> getGroupStatistics_Pre($grpc.ServiceCall call, $async.Future<$21.GetGroupStatisticsRequest> request) async {
    return getGroupStatistics(call, await request);
  }

  $async.Future<$21.GetUserContributionStatsResponse> getUserContributionStats_Pre($grpc.ServiceCall call, $async.Future<$21.GetUserContributionStatsRequest> request) async {
    return getUserContributionStats(call, await request);
  }

  $async.Future<$21.GetContributionAnalyticsResponse> getContributionAnalytics_Pre($grpc.ServiceCall call, $async.Future<$21.GetContributionAnalyticsRequest> request) async {
    return getContributionAnalytics(call, await request);
  }

  $async.Future<$21.GetGroupActivityLogsResponse> getGroupActivityLogs_Pre($grpc.ServiceCall call, $async.Future<$21.GetGroupActivityLogsRequest> request) async {
    return getGroupActivityLogs(call, await request);
  }

  $async.Future<$21.GetContributionActivityLogsResponse> getContributionActivityLogs_Pre($grpc.ServiceCall call, $async.Future<$21.GetContributionActivityLogsRequest> request) async {
    return getContributionActivityLogs(call, await request);
  }

  $async.Future<$21.CreateGroupResponse> createGroup($grpc.ServiceCall call, $21.CreateGroupRequest request);
  $async.Future<$21.GetGroupResponse> getGroup($grpc.ServiceCall call, $21.GetGroupRequest request);
  $async.Future<$21.ListUserGroupsResponse> listUserGroups($grpc.ServiceCall call, $21.ListUserGroupsRequest request);
  $async.Future<$21.UpdateGroupResponse> updateGroup($grpc.ServiceCall call, $21.UpdateGroupRequest request);
  $async.Future<$21.DeleteGroupResponse> deleteGroup($grpc.ServiceCall call, $21.DeleteGroupRequest request);
  $async.Future<$21.GetGroupMembersResponse> getGroupMembers($grpc.ServiceCall call, $21.GetGroupMembersRequest request);
  $async.Future<$21.AddMemberResponse> addMember($grpc.ServiceCall call, $21.AddMemberRequest request);
  $async.Future<$21.UpdateMemberRoleResponse> updateMemberRole($grpc.ServiceCall call, $21.UpdateMemberRoleRequest request);
  $async.Future<$21.RemoveMemberResponse> removeMember($grpc.ServiceCall call, $21.RemoveMemberRequest request);
  $async.Future<$21.SearchUsersResponse> searchUsers($grpc.ServiceCall call, $21.SearchUsersRequest request);
  $async.Future<$21.CreateContributionResponse> createContribution($grpc.ServiceCall call, $21.CreateContributionRequest request);
  $async.Future<$21.GetContributionResponse> getContribution($grpc.ServiceCall call, $21.GetContributionRequest request);
  $async.Future<$21.ListGroupContributionsResponse> listGroupContributions($grpc.ServiceCall call, $21.ListGroupContributionsRequest request);
  $async.Future<$21.UpdateContributionResponse> updateContribution($grpc.ServiceCall call, $21.UpdateContributionRequest request);
  $async.Future<$21.DeleteContributionResponse> deleteContribution($grpc.ServiceCall call, $21.DeleteContributionRequest request);
  $async.Future<$21.AddMembersToContributionResponse> addMembersToContribution($grpc.ServiceCall call, $21.AddMembersToContributionRequest request);
  $async.Future<$21.RemoveMemberFromContributionResponse> removeMemberFromContribution($grpc.ServiceCall call, $21.RemoveMemberFromContributionRequest request);
  $async.Future<$21.GetContributionMembersResponse> getContributionMembers($grpc.ServiceCall call, $21.GetContributionMembersRequest request);
  $async.Future<$21.MakePaymentResponse> makePayment($grpc.ServiceCall call, $21.MakePaymentRequest request);
  $async.Future<$21.GetContributionPaymentsResponse> getContributionPayments($grpc.ServiceCall call, $21.GetContributionPaymentsRequest request);
  $async.Future<$21.UpdatePaymentStatusResponse> updatePaymentStatus($grpc.ServiceCall call, $21.UpdatePaymentStatusRequest request);
  $async.Future<$21.ProcessScheduledPaymentsResponse> processScheduledPayments($grpc.ServiceCall call, $21.ProcessScheduledPaymentsRequest request);
  $async.Future<$21.GetOverdueContributionsResponse> getOverdueContributions($grpc.ServiceCall call, $21.GetOverdueContributionsRequest request);
  $async.Future<$21.GetPayoutScheduleResponse> getPayoutSchedule($grpc.ServiceCall call, $21.GetPayoutScheduleRequest request);
  $async.Future<$21.ProcessPayoutResponse> processPayout($grpc.ServiceCall call, $21.ProcessPayoutRequest request);
  $async.Future<$21.UpdatePayoutStatusResponse> updatePayoutStatus($grpc.ServiceCall call, $21.UpdatePayoutStatusRequest request);
  $async.Future<$21.AdvancePayoutRotationResponse> advancePayoutRotation($grpc.ServiceCall call, $21.AdvancePayoutRotationRequest request);
  $async.Future<$21.GenerateReceiptResponse> generateReceipt($grpc.ServiceCall call, $21.GenerateReceiptRequest request);
  $async.Future<$21.GetUserContributionReceiptsResponse> getUserReceipts($grpc.ServiceCall call, $21.GetUserContributionReceiptsRequest request);
  $async.Future<$21.GenerateTranscriptResponse> generateTranscript($grpc.ServiceCall call, $21.GenerateTranscriptRequest request);
  $async.Future<$21.GetGroupStatisticsResponse> getGroupStatistics($grpc.ServiceCall call, $21.GetGroupStatisticsRequest request);
  $async.Future<$21.GetUserContributionStatsResponse> getUserContributionStats($grpc.ServiceCall call, $21.GetUserContributionStatsRequest request);
  $async.Future<$21.GetContributionAnalyticsResponse> getContributionAnalytics($grpc.ServiceCall call, $21.GetContributionAnalyticsRequest request);
  $async.Future<$21.GetGroupActivityLogsResponse> getGroupActivityLogs($grpc.ServiceCall call, $21.GetGroupActivityLogsRequest request);
  $async.Future<$21.GetContributionActivityLogsResponse> getContributionActivityLogs($grpc.ServiceCall call, $21.GetContributionActivityLogsRequest request);
}
