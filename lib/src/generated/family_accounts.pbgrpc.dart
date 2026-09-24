// This is a generated file - do not edit.
//
// Generated from family_accounts.proto.

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

import 'family_accounts.pb.dart' as $0;

export 'family_accounts.pb.dart';

/// Family Account Management Service
/// Provides functionality for creating and managing family and friends shared accounts
@$pb.GrpcServiceName('accounts.v1.FamilyAccountsService')
class FamilyAccountsServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  FamilyAccountsServiceClient(super.channel,
      {super.options, super.interceptors});

  /// Create a new family account
  /// The creator becomes the first admin of the family account
  $grpc.ResponseFuture<$0.CreateFamilyAccountResponse> createFamilyAccount(
    $0.CreateFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createFamilyAccount, request, options: options);
  }

  /// Get all family accounts for the authenticated user
  /// Returns both accounts created by user and accounts where user is a member
  $grpc.ResponseFuture<$0.GetFamilyAccountsResponse> getFamilyAccounts(
    $0.GetFamilyAccountsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFamilyAccounts, request, options: options);
  }

  /// Get details of a specific family account
  /// User must be a member of the family account
  $grpc.ResponseFuture<$0.GetFamilyAccountResponse> getFamilyAccount(
    $0.GetFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFamilyAccount, request, options: options);
  }

  /// Add a member to a family account
  /// Only admins can add members
  /// Sends invitation via email, SMS, or username lookup
  $grpc.ResponseFuture<$0.AddFamilyMemberResponse> addFamilyMember(
    $0.AddFamilyMemberRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addFamilyMember, request, options: options);
  }

  /// Update member's allocation, spending limits, and role
  /// Only admins can update member settings
  $grpc.ResponseFuture<$0.UpdateFamilyMemberResponse> updateFamilyMember(
    $0.UpdateFamilyMemberRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateFamilyMember, request, options: options);
  }

  /// Remove a member from the family account
  /// Only admins can remove members
  /// Member's card will be frozen and remaining balance returned to family pool
  $grpc.ResponseFuture<$0.RemoveFamilyMemberResponse> removeFamilyMember(
    $0.RemoveFamilyMemberRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$removeFamilyMember, request, options: options);
  }

  /// Accept a family invitation
  /// Called by invited users to join a family account
  $grpc.ResponseFuture<$0.AcceptFamilyInvitationResponse>
      acceptFamilyInvitation(
    $0.AcceptFamilyInvitationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$acceptFamilyInvitation, request,
        options: options);
  }

  /// Decline a family invitation
  $grpc.ResponseFuture<$0.DeclineFamilyInvitationResponse>
      declineFamilyInvitation(
    $0.DeclineFamilyInvitationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$declineFamilyInvitation, request,
        options: options);
  }

  /// Get pending invitations for the authenticated user
  $grpc.ResponseFuture<$0.GetPendingInvitationsResponse> getPendingInvitations(
    $0.GetPendingInvitationsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPendingInvitations, request, options: options);
  }

  /// Get the authenticated user's invitation history across all statuses
  /// (pending, accepted, declined, expired, removed). Supports optional
  /// status filter + pagination. Invitee-side view.
  $grpc.ResponseFuture<$0.GetMyInvitationHistoryResponse>
      getMyInvitationHistory(
    $0.GetMyInvitationHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMyInvitationHistory, request,
        options: options);
  }

  /// Get invitations the authenticated user has SENT (as a family admin).
  /// Returns members across every family the user admins, filterable by
  /// family_id + status. Inviter-side view.
  $grpc.ResponseFuture<$0.GetSentInvitationsResponse> getSentInvitations(
    $0.GetSentInvitationsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSentInvitations, request, options: options);
  }

  /// Get transaction history for a family account
  /// All members can view all transactions (full transparency)
  $grpc.ResponseFuture<$0.GetFamilyTransactionsResponse> getFamilyTransactions(
    $0.GetFamilyTransactionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFamilyTransactions, request, options: options);
  }

  /// Allocate additional funds to a specific member
  /// Only admins can allocate funds
  $grpc.ResponseFuture<$0.AllocateFundsResponse> allocateFunds(
    $0.AllocateFundsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$allocateFunds, request, options: options);
  }

  /// Generate a virtual card for a family member
  /// Member can request their own card, or admin can generate for them
  $grpc.ResponseFuture<$0.GenerateMemberCardResponse> generateMemberCard(
    $0.GenerateMemberCardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$generateMemberCard, request, options: options);
  }

  /// Freeze a family account
  /// Only admins can freeze the account
  /// All member cards will be frozen
  $grpc.ResponseFuture<$0.FreezeFamilyAccountResponse> freezeFamilyAccount(
    $0.FreezeFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$freezeFamilyAccount, request, options: options);
  }

  /// Unfreeze a family account
  /// Only admins can unfreeze the account
  $grpc.ResponseFuture<$0.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount(
    $0.UnfreezeFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unfreezeFamilyAccount, request, options: options);
  }

  /// Delete a family account
  /// Only creator can delete
  /// All member cards will be frozen and remaining balance returned to creator
  $grpc.ResponseFuture<$0.DeleteFamilyAccountResponse> deleteFamilyAccount(
    $0.DeleteFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteFamilyAccount, request, options: options);
  }

  /// A non-creator member leaves the family on their own. Their allocation
  /// returns to the pool; the creator cannot leave (delete instead).
  $grpc.ResponseFuture<$0.LeaveFamilyAccountResponse> leaveFamilyAccount(
    $0.LeaveFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$leaveFamilyAccount, request, options: options);
  }

  /// Process a member contribution to the family pool (hybrid funding)
  /// Active members can contribute to the shared pool
  $grpc.ResponseFuture<$0.ProcessMemberContributionResponse>
      processMemberContribution(
    $0.ProcessMemberContributionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$processMemberContribution, request,
        options: options);
  }

  /// Setup a family account after creation (choose distribution mode, activate)
  $grpc.ResponseFuture<$0.SetupFamilyAccountResponse> setupFamilyAccount(
    $0.SetupFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setupFamilyAccount, request, options: options);
  }

  /// Update the fund distribution mode for an active family account
  $grpc.ResponseFuture<$0.UpdateFundDistributionModeResponse>
      updateFundDistributionMode(
    $0.UpdateFundDistributionModeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateFundDistributionMode, request,
        options: options);
  }

  /// Update spending visibility and the funding policy on an ACTIVE account.
  ///
  /// These were previously settable only through SetupFamilyAccount, which
  /// refuses to run once the account leaves pending_setup — so a creator who
  /// picked the wrong option during the wizard could never change it, for the
  /// life of the account. Both are enforced server-side (visibility gates the
  /// spend summary, funding policy gates ProcessMemberContribution), so they
  /// must be changeable through a path that applies the same normalisation the
  /// wizard does.
  $grpc.ResponseFuture<$0.UpdateFamilySettingsResponse> updateFamilySettings(
    $0.UpdateFamilySettingsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateFamilySettings, request, options: options);
  }

  /// AuthorizeFamilySpend resolves the family + spending member from the family
  /// virtual account id and verifies the spend against the distribution mode and
  /// per-member limits. Does NOT move money — call before the real debit.
  $grpc.ResponseFuture<$0.AuthorizeFamilySpendResponse> authorizeFamilySpend(
    $0.AuthorizeFamilySpendRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$authorizeFamilySpend, request, options: options);
  }

  /// RecordFamilySpend updates the family ledger after a successful real debit:
  /// decrements the pool (shared_pool) or the member allocation, bumps
  /// spent_today / spent_this_month, and writes a spending FamilyTransaction.
  /// Idempotent on transaction_id.
  $grpc.ResponseFuture<$0.RecordFamilySpendResponse> recordFamilySpend(
    $0.RecordFamilySpendRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$recordFamilySpend, request, options: options);
  }

  /// ReleaseFamilySpend reverses a still-outstanding reservation when a spend
  /// FAILS before the real money moved / before capture. Idempotent on reference.
  $grpc.ResponseFuture<$0.ReleaseFamilySpendResponse> releaseFamilySpend(
    $0.ReleaseFamilySpendRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$releaseFamilySpend, request, options: options);
  }

  /// RefundFamilySpend reverses a CAPTURED spend when the provider refunds / the
  /// transfer is rolled back AFTER the money moved. Writes a refund transaction.
  /// Idempotent on reference.
  $grpc.ResponseFuture<$0.RefundFamilySpendResponse> refundFamilySpend(
    $0.RefundFamilySpendRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$refundFamilySpend, request, options: options);
  }

  /// GetFamilySpendByReference is a read-only lookup of the family-pool
  /// reservation(s) for a payment reference (0 or 1 — reference is unique). Used
  /// by core-payments' admin internal-transfer detail to surface the family
  /// spend lifecycle. No side effects.
  $grpc.ResponseFuture<$0.GetFamilySpendByReferenceResponse>
      getFamilySpendByReference(
    $0.GetFamilySpendByReferenceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFamilySpendByReference, request,
        options: options);
  }

  /// List family accounts across all users with admin-only filters
  $grpc.ResponseFuture<$0.AdminListFamilyAccountsResponse>
      adminListFamilyAccounts(
    $0.AdminListFamilyAccountsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminListFamilyAccounts, request,
        options: options);
  }

  /// Get full detail for any family account (no membership check)
  $grpc.ResponseFuture<$0.AdminGetFamilyAccountResponse> adminGetFamilyAccount(
    $0.AdminGetFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminGetFamilyAccount, request, options: options);
  }

  /// Admin freeze (records reason and last_admin_action_by/at)
  $grpc.ResponseFuture<$0.AdminFreezeFamilyAccountResponse>
      adminFreezeFamilyAccount(
    $0.AdminFreezeFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminFreezeFamilyAccount, request,
        options: options);
  }

  /// Admin unfreeze
  $grpc.ResponseFuture<$0.AdminUnfreezeFamilyAccountResponse>
      adminUnfreezeFamilyAccount(
    $0.AdminUnfreezeFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminUnfreezeFamilyAccount, request,
        options: options);
  }

  /// Admin delete — bypasses the user confirmation_code check
  $grpc.ResponseFuture<$0.AdminDeleteFamilyAccountResponse>
      adminDeleteFamilyAccount(
    $0.AdminDeleteFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminDeleteFamilyAccount, request,
        options: options);
  }

  /// Admin force-allocate funds from the pool to a member
  $grpc.ResponseFuture<$0.AdminForceAllocateFundsResponse>
      adminForceAllocateFunds(
    $0.AdminForceAllocateFundsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminForceAllocateFunds, request,
        options: options);
  }

  /// Admin remove member (no confirmation, audit-only)
  $grpc.ResponseFuture<$0.AdminRemoveFamilyMemberResponse>
      adminRemoveFamilyMember(
    $0.AdminRemoveFamilyMemberRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminRemoveFamilyMember, request,
        options: options);
  }

  /// Admin update notes on an account (free-text for ops follow-up)
  $grpc.ResponseFuture<$0.AdminUpdateFamilyAccountNotesResponse>
      adminUpdateFamilyAccountNotes(
    $0.AdminUpdateFamilyAccountNotesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminUpdateFamilyAccountNotes, request,
        options: options);
  }

  /// Admin: paginated full transaction history (ops view, all members).
  $grpc.ResponseFuture<$0.AdminGetFamilyTransactionsResponse>
      adminGetFamilyTransactions(
    $0.AdminGetFamilyTransactionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminGetFamilyTransactions, request,
        options: options);
  }

  /// Admin: money-integrity reconciliation (fresh snapshot + recent history).
  $grpc.ResponseFuture<$0.AdminGetFamilyReconciliationResponse>
      adminGetFamilyReconciliation(
    $0.AdminGetFamilyReconciliationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminGetFamilyReconciliation, request,
        options: options);
  }

  /// Admin: force a reconciliation pass for one family now.
  $grpc.ResponseFuture<$0.AdminGetFamilyReconciliationResponse>
      adminReconcileFamilyAccount(
    $0.AdminReconcileFamilyAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminReconcileFamilyAccount, request,
        options: options);
  }

  /// Admin: immutable audit log of sensitive actions on a family account.
  $grpc.ResponseFuture<$0.AdminGetFamilyAuditLogResponse>
      adminGetFamilyAuditLog(
    $0.AdminGetFamilyAuditLogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminGetFamilyAuditLog, request,
        options: options);
  }

  /// What the caller may currently create, and what it is costing them.
  $grpc.ResponseFuture<$0.GetFamilyCapacityResponse> getFamilyCapacity(
    $0.GetFamilyCapacityRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFamilyCapacity, request, options: options);
  }

  /// Buy one extra slot. Charges the first month immediately.
  $grpc.ResponseFuture<$0.RequestExtraFamilySlotResponse>
      requestExtraFamilySlot(
    $0.RequestExtraFamilySlotRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestExtraFamilySlot, request,
        options: options);
  }

  /// The caller's slots with their billing state.
  $grpc.ResponseFuture<$0.ListFamilySlotsResponse> listFamilySlots(
    $0.ListFamilySlotsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listFamilySlots, request, options: options);
  }

  /// Give up a slot at the end of the period already paid for.
  $grpc.ResponseFuture<$0.CancelFamilySlotResponse> cancelFamilySlot(
    $0.CancelFamilySlotRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelFamilySlot, request, options: options);
  }

  /// Billing history for one slot — what answers "why was I charged".
  $grpc.ResponseFuture<$0.GetFamilySlotChargesResponse> getFamilySlotCharges(
    $0.GetFamilySlotChargesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFamilySlotCharges, request, options: options);
  }

  /// Admin: every slot and its billing state, for revenue and dispute work.
  $grpc.ResponseFuture<$0.AdminListFamilySlotsResponse> adminListFamilySlots(
    $0.AdminListFamilySlotsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminListFamilySlots, request, options: options);
  }

  /// Admin: charge attempts across all slots, successful and failed.
  $grpc.ResponseFuture<$0.AdminListFamilySlotChargesResponse>
      adminListFamilySlotCharges(
    $0.AdminListFamilySlotChargesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminListFamilySlotCharges, request,
        options: options);
  }

  // method descriptors

  static final _$createFamilyAccount = $grpc.ClientMethod<
          $0.CreateFamilyAccountRequest, $0.CreateFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/CreateFamilyAccount',
      ($0.CreateFamilyAccountRequest value) => value.writeToBuffer(),
      $0.CreateFamilyAccountResponse.fromBuffer);
  static final _$getFamilyAccounts = $grpc.ClientMethod<
          $0.GetFamilyAccountsRequest, $0.GetFamilyAccountsResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyAccounts',
      ($0.GetFamilyAccountsRequest value) => value.writeToBuffer(),
      $0.GetFamilyAccountsResponse.fromBuffer);
  static final _$getFamilyAccount = $grpc.ClientMethod<
          $0.GetFamilyAccountRequest, $0.GetFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyAccount',
      ($0.GetFamilyAccountRequest value) => value.writeToBuffer(),
      $0.GetFamilyAccountResponse.fromBuffer);
  static final _$addFamilyMember =
      $grpc.ClientMethod<$0.AddFamilyMemberRequest, $0.AddFamilyMemberResponse>(
          '/accounts.v1.FamilyAccountsService/AddFamilyMember',
          ($0.AddFamilyMemberRequest value) => value.writeToBuffer(),
          $0.AddFamilyMemberResponse.fromBuffer);
  static final _$updateFamilyMember = $grpc.ClientMethod<
          $0.UpdateFamilyMemberRequest, $0.UpdateFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/UpdateFamilyMember',
      ($0.UpdateFamilyMemberRequest value) => value.writeToBuffer(),
      $0.UpdateFamilyMemberResponse.fromBuffer);
  static final _$removeFamilyMember = $grpc.ClientMethod<
          $0.RemoveFamilyMemberRequest, $0.RemoveFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/RemoveFamilyMember',
      ($0.RemoveFamilyMemberRequest value) => value.writeToBuffer(),
      $0.RemoveFamilyMemberResponse.fromBuffer);
  static final _$acceptFamilyInvitation = $grpc.ClientMethod<
          $0.AcceptFamilyInvitationRequest, $0.AcceptFamilyInvitationResponse>(
      '/accounts.v1.FamilyAccountsService/AcceptFamilyInvitation',
      ($0.AcceptFamilyInvitationRequest value) => value.writeToBuffer(),
      $0.AcceptFamilyInvitationResponse.fromBuffer);
  static final _$declineFamilyInvitation = $grpc.ClientMethod<
          $0.DeclineFamilyInvitationRequest,
          $0.DeclineFamilyInvitationResponse>(
      '/accounts.v1.FamilyAccountsService/DeclineFamilyInvitation',
      ($0.DeclineFamilyInvitationRequest value) => value.writeToBuffer(),
      $0.DeclineFamilyInvitationResponse.fromBuffer);
  static final _$getPendingInvitations = $grpc.ClientMethod<
          $0.GetPendingInvitationsRequest, $0.GetPendingInvitationsResponse>(
      '/accounts.v1.FamilyAccountsService/GetPendingInvitations',
      ($0.GetPendingInvitationsRequest value) => value.writeToBuffer(),
      $0.GetPendingInvitationsResponse.fromBuffer);
  static final _$getMyInvitationHistory = $grpc.ClientMethod<
          $0.GetMyInvitationHistoryRequest, $0.GetMyInvitationHistoryResponse>(
      '/accounts.v1.FamilyAccountsService/GetMyInvitationHistory',
      ($0.GetMyInvitationHistoryRequest value) => value.writeToBuffer(),
      $0.GetMyInvitationHistoryResponse.fromBuffer);
  static final _$getSentInvitations = $grpc.ClientMethod<
          $0.GetSentInvitationsRequest, $0.GetSentInvitationsResponse>(
      '/accounts.v1.FamilyAccountsService/GetSentInvitations',
      ($0.GetSentInvitationsRequest value) => value.writeToBuffer(),
      $0.GetSentInvitationsResponse.fromBuffer);
  static final _$getFamilyTransactions = $grpc.ClientMethod<
          $0.GetFamilyTransactionsRequest, $0.GetFamilyTransactionsResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyTransactions',
      ($0.GetFamilyTransactionsRequest value) => value.writeToBuffer(),
      $0.GetFamilyTransactionsResponse.fromBuffer);
  static final _$allocateFunds =
      $grpc.ClientMethod<$0.AllocateFundsRequest, $0.AllocateFundsResponse>(
          '/accounts.v1.FamilyAccountsService/AllocateFunds',
          ($0.AllocateFundsRequest value) => value.writeToBuffer(),
          $0.AllocateFundsResponse.fromBuffer);
  static final _$generateMemberCard = $grpc.ClientMethod<
          $0.GenerateMemberCardRequest, $0.GenerateMemberCardResponse>(
      '/accounts.v1.FamilyAccountsService/GenerateMemberCard',
      ($0.GenerateMemberCardRequest value) => value.writeToBuffer(),
      $0.GenerateMemberCardResponse.fromBuffer);
  static final _$freezeFamilyAccount = $grpc.ClientMethod<
          $0.FreezeFamilyAccountRequest, $0.FreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/FreezeFamilyAccount',
      ($0.FreezeFamilyAccountRequest value) => value.writeToBuffer(),
      $0.FreezeFamilyAccountResponse.fromBuffer);
  static final _$unfreezeFamilyAccount = $grpc.ClientMethod<
          $0.UnfreezeFamilyAccountRequest, $0.UnfreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/UnfreezeFamilyAccount',
      ($0.UnfreezeFamilyAccountRequest value) => value.writeToBuffer(),
      $0.UnfreezeFamilyAccountResponse.fromBuffer);
  static final _$deleteFamilyAccount = $grpc.ClientMethod<
          $0.DeleteFamilyAccountRequest, $0.DeleteFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/DeleteFamilyAccount',
      ($0.DeleteFamilyAccountRequest value) => value.writeToBuffer(),
      $0.DeleteFamilyAccountResponse.fromBuffer);
  static final _$leaveFamilyAccount = $grpc.ClientMethod<
          $0.LeaveFamilyAccountRequest, $0.LeaveFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/LeaveFamilyAccount',
      ($0.LeaveFamilyAccountRequest value) => value.writeToBuffer(),
      $0.LeaveFamilyAccountResponse.fromBuffer);
  static final _$processMemberContribution = $grpc.ClientMethod<
          $0.ProcessMemberContributionRequest,
          $0.ProcessMemberContributionResponse>(
      '/accounts.v1.FamilyAccountsService/ProcessMemberContribution',
      ($0.ProcessMemberContributionRequest value) => value.writeToBuffer(),
      $0.ProcessMemberContributionResponse.fromBuffer);
  static final _$setupFamilyAccount = $grpc.ClientMethod<
          $0.SetupFamilyAccountRequest, $0.SetupFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/SetupFamilyAccount',
      ($0.SetupFamilyAccountRequest value) => value.writeToBuffer(),
      $0.SetupFamilyAccountResponse.fromBuffer);
  static final _$updateFundDistributionMode = $grpc.ClientMethod<
          $0.UpdateFundDistributionModeRequest,
          $0.UpdateFundDistributionModeResponse>(
      '/accounts.v1.FamilyAccountsService/UpdateFundDistributionMode',
      ($0.UpdateFundDistributionModeRequest value) => value.writeToBuffer(),
      $0.UpdateFundDistributionModeResponse.fromBuffer);
  static final _$updateFamilySettings = $grpc.ClientMethod<
          $0.UpdateFamilySettingsRequest, $0.UpdateFamilySettingsResponse>(
      '/accounts.v1.FamilyAccountsService/UpdateFamilySettings',
      ($0.UpdateFamilySettingsRequest value) => value.writeToBuffer(),
      $0.UpdateFamilySettingsResponse.fromBuffer);
  static final _$authorizeFamilySpend = $grpc.ClientMethod<
          $0.AuthorizeFamilySpendRequest, $0.AuthorizeFamilySpendResponse>(
      '/accounts.v1.FamilyAccountsService/AuthorizeFamilySpend',
      ($0.AuthorizeFamilySpendRequest value) => value.writeToBuffer(),
      $0.AuthorizeFamilySpendResponse.fromBuffer);
  static final _$recordFamilySpend = $grpc.ClientMethod<
          $0.RecordFamilySpendRequest, $0.RecordFamilySpendResponse>(
      '/accounts.v1.FamilyAccountsService/RecordFamilySpend',
      ($0.RecordFamilySpendRequest value) => value.writeToBuffer(),
      $0.RecordFamilySpendResponse.fromBuffer);
  static final _$releaseFamilySpend = $grpc.ClientMethod<
          $0.ReleaseFamilySpendRequest, $0.ReleaseFamilySpendResponse>(
      '/accounts.v1.FamilyAccountsService/ReleaseFamilySpend',
      ($0.ReleaseFamilySpendRequest value) => value.writeToBuffer(),
      $0.ReleaseFamilySpendResponse.fromBuffer);
  static final _$refundFamilySpend = $grpc.ClientMethod<
          $0.RefundFamilySpendRequest, $0.RefundFamilySpendResponse>(
      '/accounts.v1.FamilyAccountsService/RefundFamilySpend',
      ($0.RefundFamilySpendRequest value) => value.writeToBuffer(),
      $0.RefundFamilySpendResponse.fromBuffer);
  static final _$getFamilySpendByReference = $grpc.ClientMethod<
          $0.GetFamilySpendByReferenceRequest,
          $0.GetFamilySpendByReferenceResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilySpendByReference',
      ($0.GetFamilySpendByReferenceRequest value) => value.writeToBuffer(),
      $0.GetFamilySpendByReferenceResponse.fromBuffer);
  static final _$adminListFamilyAccounts = $grpc.ClientMethod<
          $0.AdminListFamilyAccountsRequest,
          $0.AdminListFamilyAccountsResponse>(
      '/accounts.v1.FamilyAccountsService/AdminListFamilyAccounts',
      ($0.AdminListFamilyAccountsRequest value) => value.writeToBuffer(),
      $0.AdminListFamilyAccountsResponse.fromBuffer);
  static final _$adminGetFamilyAccount = $grpc.ClientMethod<
          $0.AdminGetFamilyAccountRequest, $0.AdminGetFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/AdminGetFamilyAccount',
      ($0.AdminGetFamilyAccountRequest value) => value.writeToBuffer(),
      $0.AdminGetFamilyAccountResponse.fromBuffer);
  static final _$adminFreezeFamilyAccount = $grpc.ClientMethod<
          $0.AdminFreezeFamilyAccountRequest,
          $0.AdminFreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/AdminFreezeFamilyAccount',
      ($0.AdminFreezeFamilyAccountRequest value) => value.writeToBuffer(),
      $0.AdminFreezeFamilyAccountResponse.fromBuffer);
  static final _$adminUnfreezeFamilyAccount = $grpc.ClientMethod<
          $0.AdminUnfreezeFamilyAccountRequest,
          $0.AdminUnfreezeFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/AdminUnfreezeFamilyAccount',
      ($0.AdminUnfreezeFamilyAccountRequest value) => value.writeToBuffer(),
      $0.AdminUnfreezeFamilyAccountResponse.fromBuffer);
  static final _$adminDeleteFamilyAccount = $grpc.ClientMethod<
          $0.AdminDeleteFamilyAccountRequest,
          $0.AdminDeleteFamilyAccountResponse>(
      '/accounts.v1.FamilyAccountsService/AdminDeleteFamilyAccount',
      ($0.AdminDeleteFamilyAccountRequest value) => value.writeToBuffer(),
      $0.AdminDeleteFamilyAccountResponse.fromBuffer);
  static final _$adminForceAllocateFunds = $grpc.ClientMethod<
          $0.AdminForceAllocateFundsRequest,
          $0.AdminForceAllocateFundsResponse>(
      '/accounts.v1.FamilyAccountsService/AdminForceAllocateFunds',
      ($0.AdminForceAllocateFundsRequest value) => value.writeToBuffer(),
      $0.AdminForceAllocateFundsResponse.fromBuffer);
  static final _$adminRemoveFamilyMember = $grpc.ClientMethod<
          $0.AdminRemoveFamilyMemberRequest,
          $0.AdminRemoveFamilyMemberResponse>(
      '/accounts.v1.FamilyAccountsService/AdminRemoveFamilyMember',
      ($0.AdminRemoveFamilyMemberRequest value) => value.writeToBuffer(),
      $0.AdminRemoveFamilyMemberResponse.fromBuffer);
  static final _$adminUpdateFamilyAccountNotes = $grpc.ClientMethod<
          $0.AdminUpdateFamilyAccountNotesRequest,
          $0.AdminUpdateFamilyAccountNotesResponse>(
      '/accounts.v1.FamilyAccountsService/AdminUpdateFamilyAccountNotes',
      ($0.AdminUpdateFamilyAccountNotesRequest value) => value.writeToBuffer(),
      $0.AdminUpdateFamilyAccountNotesResponse.fromBuffer);
  static final _$adminGetFamilyTransactions = $grpc.ClientMethod<
          $0.AdminGetFamilyTransactionsRequest,
          $0.AdminGetFamilyTransactionsResponse>(
      '/accounts.v1.FamilyAccountsService/AdminGetFamilyTransactions',
      ($0.AdminGetFamilyTransactionsRequest value) => value.writeToBuffer(),
      $0.AdminGetFamilyTransactionsResponse.fromBuffer);
  static final _$adminGetFamilyReconciliation = $grpc.ClientMethod<
          $0.AdminGetFamilyReconciliationRequest,
          $0.AdminGetFamilyReconciliationResponse>(
      '/accounts.v1.FamilyAccountsService/AdminGetFamilyReconciliation',
      ($0.AdminGetFamilyReconciliationRequest value) => value.writeToBuffer(),
      $0.AdminGetFamilyReconciliationResponse.fromBuffer);
  static final _$adminReconcileFamilyAccount = $grpc.ClientMethod<
          $0.AdminReconcileFamilyAccountRequest,
          $0.AdminGetFamilyReconciliationResponse>(
      '/accounts.v1.FamilyAccountsService/AdminReconcileFamilyAccount',
      ($0.AdminReconcileFamilyAccountRequest value) => value.writeToBuffer(),
      $0.AdminGetFamilyReconciliationResponse.fromBuffer);
  static final _$adminGetFamilyAuditLog = $grpc.ClientMethod<
          $0.AdminGetFamilyAuditLogRequest, $0.AdminGetFamilyAuditLogResponse>(
      '/accounts.v1.FamilyAccountsService/AdminGetFamilyAuditLog',
      ($0.AdminGetFamilyAuditLogRequest value) => value.writeToBuffer(),
      $0.AdminGetFamilyAuditLogResponse.fromBuffer);
  static final _$getFamilyCapacity = $grpc.ClientMethod<
          $0.GetFamilyCapacityRequest, $0.GetFamilyCapacityResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilyCapacity',
      ($0.GetFamilyCapacityRequest value) => value.writeToBuffer(),
      $0.GetFamilyCapacityResponse.fromBuffer);
  static final _$requestExtraFamilySlot = $grpc.ClientMethod<
          $0.RequestExtraFamilySlotRequest, $0.RequestExtraFamilySlotResponse>(
      '/accounts.v1.FamilyAccountsService/RequestExtraFamilySlot',
      ($0.RequestExtraFamilySlotRequest value) => value.writeToBuffer(),
      $0.RequestExtraFamilySlotResponse.fromBuffer);
  static final _$listFamilySlots =
      $grpc.ClientMethod<$0.ListFamilySlotsRequest, $0.ListFamilySlotsResponse>(
          '/accounts.v1.FamilyAccountsService/ListFamilySlots',
          ($0.ListFamilySlotsRequest value) => value.writeToBuffer(),
          $0.ListFamilySlotsResponse.fromBuffer);
  static final _$cancelFamilySlot = $grpc.ClientMethod<
          $0.CancelFamilySlotRequest, $0.CancelFamilySlotResponse>(
      '/accounts.v1.FamilyAccountsService/CancelFamilySlot',
      ($0.CancelFamilySlotRequest value) => value.writeToBuffer(),
      $0.CancelFamilySlotResponse.fromBuffer);
  static final _$getFamilySlotCharges = $grpc.ClientMethod<
          $0.GetFamilySlotChargesRequest, $0.GetFamilySlotChargesResponse>(
      '/accounts.v1.FamilyAccountsService/GetFamilySlotCharges',
      ($0.GetFamilySlotChargesRequest value) => value.writeToBuffer(),
      $0.GetFamilySlotChargesResponse.fromBuffer);
  static final _$adminListFamilySlots = $grpc.ClientMethod<
          $0.AdminListFamilySlotsRequest, $0.AdminListFamilySlotsResponse>(
      '/accounts.v1.FamilyAccountsService/AdminListFamilySlots',
      ($0.AdminListFamilySlotsRequest value) => value.writeToBuffer(),
      $0.AdminListFamilySlotsResponse.fromBuffer);
  static final _$adminListFamilySlotCharges = $grpc.ClientMethod<
          $0.AdminListFamilySlotChargesRequest,
          $0.AdminListFamilySlotChargesResponse>(
      '/accounts.v1.FamilyAccountsService/AdminListFamilySlotCharges',
      ($0.AdminListFamilySlotChargesRequest value) => value.writeToBuffer(),
      $0.AdminListFamilySlotChargesResponse.fromBuffer);
}

@$pb.GrpcServiceName('accounts.v1.FamilyAccountsService')
abstract class FamilyAccountsServiceBase extends $grpc.Service {
  $core.String get $name => 'accounts.v1.FamilyAccountsService';

  FamilyAccountsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateFamilyAccountRequest,
            $0.CreateFamilyAccountResponse>(
        'CreateFamilyAccount',
        createFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateFamilyAccountRequest.fromBuffer(value),
        ($0.CreateFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFamilyAccountsRequest,
            $0.GetFamilyAccountsResponse>(
        'GetFamilyAccounts',
        getFamilyAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFamilyAccountsRequest.fromBuffer(value),
        ($0.GetFamilyAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFamilyAccountRequest,
            $0.GetFamilyAccountResponse>(
        'GetFamilyAccount',
        getFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFamilyAccountRequest.fromBuffer(value),
        ($0.GetFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddFamilyMemberRequest,
            $0.AddFamilyMemberResponse>(
        'AddFamilyMember',
        addFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AddFamilyMemberRequest.fromBuffer(value),
        ($0.AddFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateFamilyMemberRequest,
            $0.UpdateFamilyMemberResponse>(
        'UpdateFamilyMember',
        updateFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateFamilyMemberRequest.fromBuffer(value),
        ($0.UpdateFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveFamilyMemberRequest,
            $0.RemoveFamilyMemberResponse>(
        'RemoveFamilyMember',
        removeFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RemoveFamilyMemberRequest.fromBuffer(value),
        ($0.RemoveFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AcceptFamilyInvitationRequest,
            $0.AcceptFamilyInvitationResponse>(
        'AcceptFamilyInvitation',
        acceptFamilyInvitation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AcceptFamilyInvitationRequest.fromBuffer(value),
        ($0.AcceptFamilyInvitationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeclineFamilyInvitationRequest,
            $0.DeclineFamilyInvitationResponse>(
        'DeclineFamilyInvitation',
        declineFamilyInvitation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeclineFamilyInvitationRequest.fromBuffer(value),
        ($0.DeclineFamilyInvitationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPendingInvitationsRequest,
            $0.GetPendingInvitationsResponse>(
        'GetPendingInvitations',
        getPendingInvitations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPendingInvitationsRequest.fromBuffer(value),
        ($0.GetPendingInvitationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyInvitationHistoryRequest,
            $0.GetMyInvitationHistoryResponse>(
        'GetMyInvitationHistory',
        getMyInvitationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyInvitationHistoryRequest.fromBuffer(value),
        ($0.GetMyInvitationHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSentInvitationsRequest,
            $0.GetSentInvitationsResponse>(
        'GetSentInvitations',
        getSentInvitations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSentInvitationsRequest.fromBuffer(value),
        ($0.GetSentInvitationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFamilyTransactionsRequest,
            $0.GetFamilyTransactionsResponse>(
        'GetFamilyTransactions',
        getFamilyTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFamilyTransactionsRequest.fromBuffer(value),
        ($0.GetFamilyTransactionsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.AllocateFundsRequest, $0.AllocateFundsResponse>(
            'AllocateFunds',
            allocateFunds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AllocateFundsRequest.fromBuffer(value),
            ($0.AllocateFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateMemberCardRequest,
            $0.GenerateMemberCardResponse>(
        'GenerateMemberCard',
        generateMemberCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GenerateMemberCardRequest.fromBuffer(value),
        ($0.GenerateMemberCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FreezeFamilyAccountRequest,
            $0.FreezeFamilyAccountResponse>(
        'FreezeFamilyAccount',
        freezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.FreezeFamilyAccountRequest.fromBuffer(value),
        ($0.FreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnfreezeFamilyAccountRequest,
            $0.UnfreezeFamilyAccountResponse>(
        'UnfreezeFamilyAccount',
        unfreezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UnfreezeFamilyAccountRequest.fromBuffer(value),
        ($0.UnfreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteFamilyAccountRequest,
            $0.DeleteFamilyAccountResponse>(
        'DeleteFamilyAccount',
        deleteFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteFamilyAccountRequest.fromBuffer(value),
        ($0.DeleteFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LeaveFamilyAccountRequest,
            $0.LeaveFamilyAccountResponse>(
        'LeaveFamilyAccount',
        leaveFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.LeaveFamilyAccountRequest.fromBuffer(value),
        ($0.LeaveFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessMemberContributionRequest,
            $0.ProcessMemberContributionResponse>(
        'ProcessMemberContribution',
        processMemberContribution_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ProcessMemberContributionRequest.fromBuffer(value),
        ($0.ProcessMemberContributionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetupFamilyAccountRequest,
            $0.SetupFamilyAccountResponse>(
        'SetupFamilyAccount',
        setupFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetupFamilyAccountRequest.fromBuffer(value),
        ($0.SetupFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateFundDistributionModeRequest,
            $0.UpdateFundDistributionModeResponse>(
        'UpdateFundDistributionMode',
        updateFundDistributionMode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateFundDistributionModeRequest.fromBuffer(value),
        ($0.UpdateFundDistributionModeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateFamilySettingsRequest,
            $0.UpdateFamilySettingsResponse>(
        'UpdateFamilySettings',
        updateFamilySettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateFamilySettingsRequest.fromBuffer(value),
        ($0.UpdateFamilySettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AuthorizeFamilySpendRequest,
            $0.AuthorizeFamilySpendResponse>(
        'AuthorizeFamilySpend',
        authorizeFamilySpend_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AuthorizeFamilySpendRequest.fromBuffer(value),
        ($0.AuthorizeFamilySpendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RecordFamilySpendRequest,
            $0.RecordFamilySpendResponse>(
        'RecordFamilySpend',
        recordFamilySpend_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RecordFamilySpendRequest.fromBuffer(value),
        ($0.RecordFamilySpendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReleaseFamilySpendRequest,
            $0.ReleaseFamilySpendResponse>(
        'ReleaseFamilySpend',
        releaseFamilySpend_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReleaseFamilySpendRequest.fromBuffer(value),
        ($0.ReleaseFamilySpendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RefundFamilySpendRequest,
            $0.RefundFamilySpendResponse>(
        'RefundFamilySpend',
        refundFamilySpend_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RefundFamilySpendRequest.fromBuffer(value),
        ($0.RefundFamilySpendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFamilySpendByReferenceRequest,
            $0.GetFamilySpendByReferenceResponse>(
        'GetFamilySpendByReference',
        getFamilySpendByReference_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFamilySpendByReferenceRequest.fromBuffer(value),
        ($0.GetFamilySpendByReferenceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListFamilyAccountsRequest,
            $0.AdminListFamilyAccountsResponse>(
        'AdminListFamilyAccounts',
        adminListFamilyAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListFamilyAccountsRequest.fromBuffer(value),
        ($0.AdminListFamilyAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetFamilyAccountRequest,
            $0.AdminGetFamilyAccountResponse>(
        'AdminGetFamilyAccount',
        adminGetFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetFamilyAccountRequest.fromBuffer(value),
        ($0.AdminGetFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminFreezeFamilyAccountRequest,
            $0.AdminFreezeFamilyAccountResponse>(
        'AdminFreezeFamilyAccount',
        adminFreezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminFreezeFamilyAccountRequest.fromBuffer(value),
        ($0.AdminFreezeFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminUnfreezeFamilyAccountRequest,
            $0.AdminUnfreezeFamilyAccountResponse>(
        'AdminUnfreezeFamilyAccount',
        adminUnfreezeFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminUnfreezeFamilyAccountRequest.fromBuffer(value),
        ($0.AdminUnfreezeFamilyAccountResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminDeleteFamilyAccountRequest,
            $0.AdminDeleteFamilyAccountResponse>(
        'AdminDeleteFamilyAccount',
        adminDeleteFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminDeleteFamilyAccountRequest.fromBuffer(value),
        ($0.AdminDeleteFamilyAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminForceAllocateFundsRequest,
            $0.AdminForceAllocateFundsResponse>(
        'AdminForceAllocateFunds',
        adminForceAllocateFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminForceAllocateFundsRequest.fromBuffer(value),
        ($0.AdminForceAllocateFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminRemoveFamilyMemberRequest,
            $0.AdminRemoveFamilyMemberResponse>(
        'AdminRemoveFamilyMember',
        adminRemoveFamilyMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminRemoveFamilyMemberRequest.fromBuffer(value),
        ($0.AdminRemoveFamilyMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminUpdateFamilyAccountNotesRequest,
            $0.AdminUpdateFamilyAccountNotesResponse>(
        'AdminUpdateFamilyAccountNotes',
        adminUpdateFamilyAccountNotes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminUpdateFamilyAccountNotesRequest.fromBuffer(value),
        ($0.AdminUpdateFamilyAccountNotesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetFamilyTransactionsRequest,
            $0.AdminGetFamilyTransactionsResponse>(
        'AdminGetFamilyTransactions',
        adminGetFamilyTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetFamilyTransactionsRequest.fromBuffer(value),
        ($0.AdminGetFamilyTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetFamilyReconciliationRequest,
            $0.AdminGetFamilyReconciliationResponse>(
        'AdminGetFamilyReconciliation',
        adminGetFamilyReconciliation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetFamilyReconciliationRequest.fromBuffer(value),
        ($0.AdminGetFamilyReconciliationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminReconcileFamilyAccountRequest,
            $0.AdminGetFamilyReconciliationResponse>(
        'AdminReconcileFamilyAccount',
        adminReconcileFamilyAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminReconcileFamilyAccountRequest.fromBuffer(value),
        ($0.AdminGetFamilyReconciliationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetFamilyAuditLogRequest,
            $0.AdminGetFamilyAuditLogResponse>(
        'AdminGetFamilyAuditLog',
        adminGetFamilyAuditLog_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetFamilyAuditLogRequest.fromBuffer(value),
        ($0.AdminGetFamilyAuditLogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFamilyCapacityRequest,
            $0.GetFamilyCapacityResponse>(
        'GetFamilyCapacity',
        getFamilyCapacity_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFamilyCapacityRequest.fromBuffer(value),
        ($0.GetFamilyCapacityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestExtraFamilySlotRequest,
            $0.RequestExtraFamilySlotResponse>(
        'RequestExtraFamilySlot',
        requestExtraFamilySlot_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestExtraFamilySlotRequest.fromBuffer(value),
        ($0.RequestExtraFamilySlotResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListFamilySlotsRequest,
            $0.ListFamilySlotsResponse>(
        'ListFamilySlots',
        listFamilySlots_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListFamilySlotsRequest.fromBuffer(value),
        ($0.ListFamilySlotsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelFamilySlotRequest,
            $0.CancelFamilySlotResponse>(
        'CancelFamilySlot',
        cancelFamilySlot_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelFamilySlotRequest.fromBuffer(value),
        ($0.CancelFamilySlotResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFamilySlotChargesRequest,
            $0.GetFamilySlotChargesResponse>(
        'GetFamilySlotCharges',
        getFamilySlotCharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFamilySlotChargesRequest.fromBuffer(value),
        ($0.GetFamilySlotChargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListFamilySlotsRequest,
            $0.AdminListFamilySlotsResponse>(
        'AdminListFamilySlots',
        adminListFamilySlots_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListFamilySlotsRequest.fromBuffer(value),
        ($0.AdminListFamilySlotsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListFamilySlotChargesRequest,
            $0.AdminListFamilySlotChargesResponse>(
        'AdminListFamilySlotCharges',
        adminListFamilySlotCharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListFamilySlotChargesRequest.fromBuffer(value),
        ($0.AdminListFamilySlotChargesResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$0.CreateFamilyAccountResponse> createFamilyAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateFamilyAccountRequest> $request) async {
    return createFamilyAccount($call, await $request);
  }

  $async.Future<$0.CreateFamilyAccountResponse> createFamilyAccount(
      $grpc.ServiceCall call, $0.CreateFamilyAccountRequest request);

  $async.Future<$0.GetFamilyAccountsResponse> getFamilyAccounts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetFamilyAccountsRequest> $request) async {
    return getFamilyAccounts($call, await $request);
  }

  $async.Future<$0.GetFamilyAccountsResponse> getFamilyAccounts(
      $grpc.ServiceCall call, $0.GetFamilyAccountsRequest request);

  $async.Future<$0.GetFamilyAccountResponse> getFamilyAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetFamilyAccountRequest> $request) async {
    return getFamilyAccount($call, await $request);
  }

  $async.Future<$0.GetFamilyAccountResponse> getFamilyAccount(
      $grpc.ServiceCall call, $0.GetFamilyAccountRequest request);

  $async.Future<$0.AddFamilyMemberResponse> addFamilyMember_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AddFamilyMemberRequest> $request) async {
    return addFamilyMember($call, await $request);
  }

  $async.Future<$0.AddFamilyMemberResponse> addFamilyMember(
      $grpc.ServiceCall call, $0.AddFamilyMemberRequest request);

  $async.Future<$0.UpdateFamilyMemberResponse> updateFamilyMember_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateFamilyMemberRequest> $request) async {
    return updateFamilyMember($call, await $request);
  }

  $async.Future<$0.UpdateFamilyMemberResponse> updateFamilyMember(
      $grpc.ServiceCall call, $0.UpdateFamilyMemberRequest request);

  $async.Future<$0.RemoveFamilyMemberResponse> removeFamilyMember_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RemoveFamilyMemberRequest> $request) async {
    return removeFamilyMember($call, await $request);
  }

  $async.Future<$0.RemoveFamilyMemberResponse> removeFamilyMember(
      $grpc.ServiceCall call, $0.RemoveFamilyMemberRequest request);

  $async.Future<$0.AcceptFamilyInvitationResponse> acceptFamilyInvitation_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AcceptFamilyInvitationRequest> $request) async {
    return acceptFamilyInvitation($call, await $request);
  }

  $async.Future<$0.AcceptFamilyInvitationResponse> acceptFamilyInvitation(
      $grpc.ServiceCall call, $0.AcceptFamilyInvitationRequest request);

  $async.Future<$0.DeclineFamilyInvitationResponse> declineFamilyInvitation_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DeclineFamilyInvitationRequest> $request) async {
    return declineFamilyInvitation($call, await $request);
  }

  $async.Future<$0.DeclineFamilyInvitationResponse> declineFamilyInvitation(
      $grpc.ServiceCall call, $0.DeclineFamilyInvitationRequest request);

  $async.Future<$0.GetPendingInvitationsResponse> getPendingInvitations_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetPendingInvitationsRequest> $request) async {
    return getPendingInvitations($call, await $request);
  }

  $async.Future<$0.GetPendingInvitationsResponse> getPendingInvitations(
      $grpc.ServiceCall call, $0.GetPendingInvitationsRequest request);

  $async.Future<$0.GetMyInvitationHistoryResponse> getMyInvitationHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMyInvitationHistoryRequest> $request) async {
    return getMyInvitationHistory($call, await $request);
  }

  $async.Future<$0.GetMyInvitationHistoryResponse> getMyInvitationHistory(
      $grpc.ServiceCall call, $0.GetMyInvitationHistoryRequest request);

  $async.Future<$0.GetSentInvitationsResponse> getSentInvitations_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSentInvitationsRequest> $request) async {
    return getSentInvitations($call, await $request);
  }

  $async.Future<$0.GetSentInvitationsResponse> getSentInvitations(
      $grpc.ServiceCall call, $0.GetSentInvitationsRequest request);

  $async.Future<$0.GetFamilyTransactionsResponse> getFamilyTransactions_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetFamilyTransactionsRequest> $request) async {
    return getFamilyTransactions($call, await $request);
  }

  $async.Future<$0.GetFamilyTransactionsResponse> getFamilyTransactions(
      $grpc.ServiceCall call, $0.GetFamilyTransactionsRequest request);

  $async.Future<$0.AllocateFundsResponse> allocateFunds_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AllocateFundsRequest> $request) async {
    return allocateFunds($call, await $request);
  }

  $async.Future<$0.AllocateFundsResponse> allocateFunds(
      $grpc.ServiceCall call, $0.AllocateFundsRequest request);

  $async.Future<$0.GenerateMemberCardResponse> generateMemberCard_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GenerateMemberCardRequest> $request) async {
    return generateMemberCard($call, await $request);
  }

  $async.Future<$0.GenerateMemberCardResponse> generateMemberCard(
      $grpc.ServiceCall call, $0.GenerateMemberCardRequest request);

  $async.Future<$0.FreezeFamilyAccountResponse> freezeFamilyAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.FreezeFamilyAccountRequest> $request) async {
    return freezeFamilyAccount($call, await $request);
  }

  $async.Future<$0.FreezeFamilyAccountResponse> freezeFamilyAccount(
      $grpc.ServiceCall call, $0.FreezeFamilyAccountRequest request);

  $async.Future<$0.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UnfreezeFamilyAccountRequest> $request) async {
    return unfreezeFamilyAccount($call, await $request);
  }

  $async.Future<$0.UnfreezeFamilyAccountResponse> unfreezeFamilyAccount(
      $grpc.ServiceCall call, $0.UnfreezeFamilyAccountRequest request);

  $async.Future<$0.DeleteFamilyAccountResponse> deleteFamilyAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DeleteFamilyAccountRequest> $request) async {
    return deleteFamilyAccount($call, await $request);
  }

  $async.Future<$0.DeleteFamilyAccountResponse> deleteFamilyAccount(
      $grpc.ServiceCall call, $0.DeleteFamilyAccountRequest request);

  $async.Future<$0.LeaveFamilyAccountResponse> leaveFamilyAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.LeaveFamilyAccountRequest> $request) async {
    return leaveFamilyAccount($call, await $request);
  }

  $async.Future<$0.LeaveFamilyAccountResponse> leaveFamilyAccount(
      $grpc.ServiceCall call, $0.LeaveFamilyAccountRequest request);

  $async.Future<$0.ProcessMemberContributionResponse>
      processMemberContribution_Pre($grpc.ServiceCall $call,
          $async.Future<$0.ProcessMemberContributionRequest> $request) async {
    return processMemberContribution($call, await $request);
  }

  $async.Future<$0.ProcessMemberContributionResponse> processMemberContribution(
      $grpc.ServiceCall call, $0.ProcessMemberContributionRequest request);

  $async.Future<$0.SetupFamilyAccountResponse> setupFamilyAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SetupFamilyAccountRequest> $request) async {
    return setupFamilyAccount($call, await $request);
  }

  $async.Future<$0.SetupFamilyAccountResponse> setupFamilyAccount(
      $grpc.ServiceCall call, $0.SetupFamilyAccountRequest request);

  $async.Future<$0.UpdateFundDistributionModeResponse>
      updateFundDistributionMode_Pre($grpc.ServiceCall $call,
          $async.Future<$0.UpdateFundDistributionModeRequest> $request) async {
    return updateFundDistributionMode($call, await $request);
  }

  $async.Future<$0.UpdateFundDistributionModeResponse>
      updateFundDistributionMode(
          $grpc.ServiceCall call, $0.UpdateFundDistributionModeRequest request);

  $async.Future<$0.UpdateFamilySettingsResponse> updateFamilySettings_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateFamilySettingsRequest> $request) async {
    return updateFamilySettings($call, await $request);
  }

  $async.Future<$0.UpdateFamilySettingsResponse> updateFamilySettings(
      $grpc.ServiceCall call, $0.UpdateFamilySettingsRequest request);

  $async.Future<$0.AuthorizeFamilySpendResponse> authorizeFamilySpend_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AuthorizeFamilySpendRequest> $request) async {
    return authorizeFamilySpend($call, await $request);
  }

  $async.Future<$0.AuthorizeFamilySpendResponse> authorizeFamilySpend(
      $grpc.ServiceCall call, $0.AuthorizeFamilySpendRequest request);

  $async.Future<$0.RecordFamilySpendResponse> recordFamilySpend_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RecordFamilySpendRequest> $request) async {
    return recordFamilySpend($call, await $request);
  }

  $async.Future<$0.RecordFamilySpendResponse> recordFamilySpend(
      $grpc.ServiceCall call, $0.RecordFamilySpendRequest request);

  $async.Future<$0.ReleaseFamilySpendResponse> releaseFamilySpend_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReleaseFamilySpendRequest> $request) async {
    return releaseFamilySpend($call, await $request);
  }

  $async.Future<$0.ReleaseFamilySpendResponse> releaseFamilySpend(
      $grpc.ServiceCall call, $0.ReleaseFamilySpendRequest request);

  $async.Future<$0.RefundFamilySpendResponse> refundFamilySpend_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RefundFamilySpendRequest> $request) async {
    return refundFamilySpend($call, await $request);
  }

  $async.Future<$0.RefundFamilySpendResponse> refundFamilySpend(
      $grpc.ServiceCall call, $0.RefundFamilySpendRequest request);

  $async.Future<$0.GetFamilySpendByReferenceResponse>
      getFamilySpendByReference_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetFamilySpendByReferenceRequest> $request) async {
    return getFamilySpendByReference($call, await $request);
  }

  $async.Future<$0.GetFamilySpendByReferenceResponse> getFamilySpendByReference(
      $grpc.ServiceCall call, $0.GetFamilySpendByReferenceRequest request);

  $async.Future<$0.AdminListFamilyAccountsResponse> adminListFamilyAccounts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminListFamilyAccountsRequest> $request) async {
    return adminListFamilyAccounts($call, await $request);
  }

  $async.Future<$0.AdminListFamilyAccountsResponse> adminListFamilyAccounts(
      $grpc.ServiceCall call, $0.AdminListFamilyAccountsRequest request);

  $async.Future<$0.AdminGetFamilyAccountResponse> adminGetFamilyAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminGetFamilyAccountRequest> $request) async {
    return adminGetFamilyAccount($call, await $request);
  }

  $async.Future<$0.AdminGetFamilyAccountResponse> adminGetFamilyAccount(
      $grpc.ServiceCall call, $0.AdminGetFamilyAccountRequest request);

  $async.Future<$0.AdminFreezeFamilyAccountResponse>
      adminFreezeFamilyAccount_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AdminFreezeFamilyAccountRequest> $request) async {
    return adminFreezeFamilyAccount($call, await $request);
  }

  $async.Future<$0.AdminFreezeFamilyAccountResponse> adminFreezeFamilyAccount(
      $grpc.ServiceCall call, $0.AdminFreezeFamilyAccountRequest request);

  $async.Future<$0.AdminUnfreezeFamilyAccountResponse>
      adminUnfreezeFamilyAccount_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AdminUnfreezeFamilyAccountRequest> $request) async {
    return adminUnfreezeFamilyAccount($call, await $request);
  }

  $async.Future<$0.AdminUnfreezeFamilyAccountResponse>
      adminUnfreezeFamilyAccount(
          $grpc.ServiceCall call, $0.AdminUnfreezeFamilyAccountRequest request);

  $async.Future<$0.AdminDeleteFamilyAccountResponse>
      adminDeleteFamilyAccount_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AdminDeleteFamilyAccountRequest> $request) async {
    return adminDeleteFamilyAccount($call, await $request);
  }

  $async.Future<$0.AdminDeleteFamilyAccountResponse> adminDeleteFamilyAccount(
      $grpc.ServiceCall call, $0.AdminDeleteFamilyAccountRequest request);

  $async.Future<$0.AdminForceAllocateFundsResponse> adminForceAllocateFunds_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminForceAllocateFundsRequest> $request) async {
    return adminForceAllocateFunds($call, await $request);
  }

  $async.Future<$0.AdminForceAllocateFundsResponse> adminForceAllocateFunds(
      $grpc.ServiceCall call, $0.AdminForceAllocateFundsRequest request);

  $async.Future<$0.AdminRemoveFamilyMemberResponse> adminRemoveFamilyMember_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminRemoveFamilyMemberRequest> $request) async {
    return adminRemoveFamilyMember($call, await $request);
  }

  $async.Future<$0.AdminRemoveFamilyMemberResponse> adminRemoveFamilyMember(
      $grpc.ServiceCall call, $0.AdminRemoveFamilyMemberRequest request);

  $async.Future<$0.AdminUpdateFamilyAccountNotesResponse>
      adminUpdateFamilyAccountNotes_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.AdminUpdateFamilyAccountNotesRequest>
              $request) async {
    return adminUpdateFamilyAccountNotes($call, await $request);
  }

  $async.Future<$0.AdminUpdateFamilyAccountNotesResponse>
      adminUpdateFamilyAccountNotes($grpc.ServiceCall call,
          $0.AdminUpdateFamilyAccountNotesRequest request);

  $async.Future<$0.AdminGetFamilyTransactionsResponse>
      adminGetFamilyTransactions_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AdminGetFamilyTransactionsRequest> $request) async {
    return adminGetFamilyTransactions($call, await $request);
  }

  $async.Future<$0.AdminGetFamilyTransactionsResponse>
      adminGetFamilyTransactions(
          $grpc.ServiceCall call, $0.AdminGetFamilyTransactionsRequest request);

  $async.Future<$0.AdminGetFamilyReconciliationResponse>
      adminGetFamilyReconciliation_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.AdminGetFamilyReconciliationRequest>
              $request) async {
    return adminGetFamilyReconciliation($call, await $request);
  }

  $async.Future<$0.AdminGetFamilyReconciliationResponse>
      adminGetFamilyReconciliation($grpc.ServiceCall call,
          $0.AdminGetFamilyReconciliationRequest request);

  $async.Future<$0.AdminGetFamilyReconciliationResponse>
      adminReconcileFamilyAccount_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AdminReconcileFamilyAccountRequest> $request) async {
    return adminReconcileFamilyAccount($call, await $request);
  }

  $async.Future<$0.AdminGetFamilyReconciliationResponse>
      adminReconcileFamilyAccount($grpc.ServiceCall call,
          $0.AdminReconcileFamilyAccountRequest request);

  $async.Future<$0.AdminGetFamilyAuditLogResponse> adminGetFamilyAuditLog_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminGetFamilyAuditLogRequest> $request) async {
    return adminGetFamilyAuditLog($call, await $request);
  }

  $async.Future<$0.AdminGetFamilyAuditLogResponse> adminGetFamilyAuditLog(
      $grpc.ServiceCall call, $0.AdminGetFamilyAuditLogRequest request);

  $async.Future<$0.GetFamilyCapacityResponse> getFamilyCapacity_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetFamilyCapacityRequest> $request) async {
    return getFamilyCapacity($call, await $request);
  }

  $async.Future<$0.GetFamilyCapacityResponse> getFamilyCapacity(
      $grpc.ServiceCall call, $0.GetFamilyCapacityRequest request);

  $async.Future<$0.RequestExtraFamilySlotResponse> requestExtraFamilySlot_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestExtraFamilySlotRequest> $request) async {
    return requestExtraFamilySlot($call, await $request);
  }

  $async.Future<$0.RequestExtraFamilySlotResponse> requestExtraFamilySlot(
      $grpc.ServiceCall call, $0.RequestExtraFamilySlotRequest request);

  $async.Future<$0.ListFamilySlotsResponse> listFamilySlots_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListFamilySlotsRequest> $request) async {
    return listFamilySlots($call, await $request);
  }

  $async.Future<$0.ListFamilySlotsResponse> listFamilySlots(
      $grpc.ServiceCall call, $0.ListFamilySlotsRequest request);

  $async.Future<$0.CancelFamilySlotResponse> cancelFamilySlot_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelFamilySlotRequest> $request) async {
    return cancelFamilySlot($call, await $request);
  }

  $async.Future<$0.CancelFamilySlotResponse> cancelFamilySlot(
      $grpc.ServiceCall call, $0.CancelFamilySlotRequest request);

  $async.Future<$0.GetFamilySlotChargesResponse> getFamilySlotCharges_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetFamilySlotChargesRequest> $request) async {
    return getFamilySlotCharges($call, await $request);
  }

  $async.Future<$0.GetFamilySlotChargesResponse> getFamilySlotCharges(
      $grpc.ServiceCall call, $0.GetFamilySlotChargesRequest request);

  $async.Future<$0.AdminListFamilySlotsResponse> adminListFamilySlots_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminListFamilySlotsRequest> $request) async {
    return adminListFamilySlots($call, await $request);
  }

  $async.Future<$0.AdminListFamilySlotsResponse> adminListFamilySlots(
      $grpc.ServiceCall call, $0.AdminListFamilySlotsRequest request);

  $async.Future<$0.AdminListFamilySlotChargesResponse>
      adminListFamilySlotCharges_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AdminListFamilySlotChargesRequest> $request) async {
    return adminListFamilySlotCharges($call, await $request);
  }

  $async.Future<$0.AdminListFamilySlotChargesResponse>
      adminListFamilySlotCharges(
          $grpc.ServiceCall call, $0.AdminListFamilySlotChargesRequest request);
}
