// payout_assignment_service.dart
//
// Thin Dart wrapper around the 6 receiver/scheduled-payout RPCs added
// to GroupAccountService. Returns generated proto messages directly
// rather than mapping into domain entities — the receiver/payout
// surface is small enough that an extra entity layer would be churn
// for no payoff.
//
// Used by:
//   * GroupAccountCubit — for setReceiver / triggerManualPayout state.
//   * The contribution-details receiver banner + manual-payout CTA.
//   * The receiver-picker bottom sheet.
//
// Wiring: registered in injection_container.dart with the same gRPC
// client the data source already uses. Errors surface as the gRPC
// `GrpcError` type so callers can branch on `code`.

import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/group_account.pbgrpc.dart' as pb;
import 'package:lazervault/src/generated/group_account.pb.dart' as pb_msg;
import 'package:lazervault/src/generated/group_account.pbenum.dart' as pb_enum;

class PayoutAssignmentService {
  final pb.GroupAccountServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  PayoutAssignmentService({
    required pb.GroupAccountServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  Future<CallOptions> _opts() => _callOptionsHelper.withAuth();

  // --------------------------------------------------------------------------
  // Rotation
  // --------------------------------------------------------------------------

  /// Move a ROSCA on to its next cycle by hand.
  ///
  /// The rotation normally advances itself: the payout supervisor calls the
  /// same server path right after a cycle's payout succeeds. But that call is
  /// deliberately non-fatal — the money has already moved by then, so a
  /// failure there is logged and the circle simply stops, waiting for someone
  /// to advance it. Until now nothing in the app could, so a circle that
  /// missed its advance was stuck with no way forward: its next cycle's slot
  /// sits in `manual_review` reading "contribution status is completed (must
  /// be active)".
  ///
  /// Server-side this closes the finished cycle (writing its row into
  /// contribution_cycles), bumps the lifetime counter, moves the pointer to
  /// the next member in the rotation and re-anchors the cycle calendar.
  ///
  /// Expected refusals, which callers should show rather than retry:
  ///   * FAILED_PRECONDITION — every remaining position is held by a member
  ///     in arrears, so the pot is deliberately NOT sent on. It clears when
  ///     one of them pays.
  ///   * PERMISSION_DENIED — only the creator may advance the circle.
  Future<pb_msg.AdvancePayoutRotationResponse> advanceRotation({
    required String contributionId,
  }) async {
    final req = pb_msg.AdvancePayoutRotationRequest(
      contributionId: contributionId,
    );
    return _client.advancePayoutRotation(req, options: await _opts());
  }

  // --------------------------------------------------------------------------
  // Receiver assignment
  // --------------------------------------------------------------------------

  /// Designate (or reassign) the recipient of the next payout for
  /// (contributionId, cycleIndex). cycleIndex=0 for one-time
  /// contributions; for ROSCA pass the cycle that is paying out.
  ///
  /// Side effects (server-side):
  ///   * If auto_payout is enabled and deadline is in the FUTURE, the
  ///     scheduler enqueues the payout to fire at deadline.
  ///   * If auto_payout is enabled and deadline already PASSED, the
  ///     scheduler enqueues an immediate one-shot fire.
  ///   * If auto_payout is disabled, the row drops to "ready" and the
  ///     creator is expected to call [triggerManualPayout].
  Future<pb_msg.SetPayoutReceiverResponse> setReceiver({
    required String contributionId,
    int cycleIndex = 0,
    required String recipientUserId,
    String? recipientAccountId,
    String? note,
  }) async {
    final req = pb_msg.SetPayoutReceiverRequest(
      contributionId: contributionId,
      cycleIndex: cycleIndex,
      recipientUserId: recipientUserId,
      recipientAccountId: recipientAccountId ?? '',
      note: note ?? '',
    );
    return _client.setPayoutReceiver(req, options: await _opts());
  }

  /// Read the active receiver + scheduled-payout state for the cycle.
  /// Returns the response with both fields nullable — callers should
  /// treat `receiver == null` as "no one designated yet".
  Future<pb_msg.GetPayoutReceiverResponse> getReceiver({
    required String contributionId,
    int cycleIndex = 0,
  }) async {
    final req = pb_msg.GetPayoutReceiverRequest(
      contributionId: contributionId,
      cycleIndex: cycleIndex,
    );
    return _client.getPayoutReceiver(req, options: await _opts());
  }

  /// Soft-clear the active receiver. The scheduled-payout row drops
  /// back to pending_receiver and any pending Redis fire is canceled.
  /// Audit history of the prior assignment is preserved.
  Future<pb_msg.ClearPayoutReceiverResponse> clearReceiver({
    required String contributionId,
    int cycleIndex = 0,
  }) async {
    final req = pb_msg.ClearPayoutReceiverRequest(
      contributionId: contributionId,
      cycleIndex: cycleIndex,
    );
    return _client.clearPayoutReceiver(req, options: await _opts());
  }

  // --------------------------------------------------------------------------
  // Manual payout trigger
  // --------------------------------------------------------------------------

  /// Fire a manual-mode payout immediately. Idempotent — a row already
  /// settled returns success without doing anything; a row in_flight
  /// returns Aborted (caller should poll). Errors map to gRPC codes:
  ///
  ///   * FAILED_PRECONDITION — payout not in (ready|failed) state.
  ///   * NOT_FOUND           — no scheduled-payout row exists.
  ///   * PERMISSION_DENIED   — caller is not group admin.
  Future<pb_msg.TriggerManualPayoutResponse> triggerManualPayout({
    required String contributionId,
    int cycleIndex = 0,
  }) async {
    final req = pb_msg.TriggerManualPayoutRequest(
      contributionId: contributionId,
      cycleIndex: cycleIndex,
    );
    return _client.triggerManualPayout(req, options: await _opts());
  }

  /// Take a stuck payout off automation so the manual trigger works again.
  ///
  /// The scheduler stops burning attempts on a condition it cannot resolve
  /// (an inactive receiver account, a pot still filling), and the row is
  /// re-armed to `ready` — which is the state [triggerManualPayout] accepts.
  /// Idempotent: switching an already-manual payout returns the same row.
  Future<pb_msg.SwitchPayoutToManualResponse> switchPayoutToManual({
    required String contributionId,
    int cycleIndex = 0,
  }) async {
    final req = pb_msg.SwitchPayoutToManualRequest(
      contributionId: contributionId,
      cycleIndex: cycleIndex,
    );
    return _client.switchPayoutToManual(req, options: await _opts());
  }

  // --------------------------------------------------------------------------
  // Scheduled-payout queries
  // --------------------------------------------------------------------------

  /// List scheduled payouts for a contribution. For one-time this
  /// returns at most 1 row; for ROSCA up to N (one per cycle).
  Future<pb_msg.ListScheduledPayoutsResponse> listForContribution({
    required String contributionId,
    List<pb_enum.ScheduledPayoutStatus>? statuses,
    int limit = 50,
    int offset = 0,
  }) async {
    final req = pb_msg.ListScheduledPayoutsRequest(
      contributionId: contributionId,
      limit: limit,
      offset: offset,
    );
    if (statuses != null && statuses.isNotEmpty) {
      req.statuses.addAll(statuses);
    }
    return _client.listScheduledPayouts(req, options: await _opts());
  }

  /// Detail page query — full row + active receiver + recent events.
  /// Used by the admin dashboard's payout-detail screen and (later)
  /// by an admin-only debug page in the mobile app.
  Future<pb_msg.GetScheduledPayoutResponse> getScheduledPayout({
    required String payoutId,
  }) async {
    final req = pb_msg.GetScheduledPayoutRequest(payoutId: payoutId);
    return _client.getScheduledPayout(req, options: await _opts());
  }
}

// Helper for callers that need to mutate the int64 amount field on a
// proto message before sending. Kept here so every receiver-flow
// caller doesn't have to import fixnum directly.
fixnum.Int64 amountToInt64(int amount) => fixnum.Int64(amount);
