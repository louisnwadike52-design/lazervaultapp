import 'package:grpc/grpc.dart';

import 'package:lazervault/src/core/errors/grpc_exceptions.dart';
import '../../../../../core/services/grpc_call_options_helper.dart';
import '../../../../generated/family_accounts.pbgrpc.dart' as family_pb;

/// Paid family-account slots — capacity beyond the free allowance, billed
/// monthly.
///
/// Kept separate from [FamilyAccountGrpcDataSource]: slots are billing, not
/// family data, and folding five money RPCs into a 900-line data source that
/// already covers members, cards and invitations helps nobody.
///
/// Returns the generated proto types directly rather than re-modelling them.
/// These are billing records read straight onto a screen — a parallel entity
/// layer would be five more files that can only drift from the proto.
class FamilySlotsDataSource {
  FamilySlotsDataSource({
    required family_pb.FamilyAccountsServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  final family_pb.FamilyAccountsServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  /// What the user may currently create, and what one more slot costs.
  Future<family_pb.GetFamilyCapacityResponse> getCapacity() async {
    try {
      final options = await _callOptionsHelper.withAuth();
      return await _client.getFamilyCapacity(
        family_pb.GetFamilyCapacityRequest(),
        options: options,
      );
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  /// Buy one more slot. Charges the first month immediately.
  ///
  /// [idempotencyKey] must be stable across retries of the SAME purchase — one
  /// key per confirmation, generated when the sheet opens, not per attempt.
  /// A fresh key on a retry after a timeout buys a second slot.
  ///
  /// [pinToken] / [pinTransactionId] carry the transaction-PIN confirmation.
  /// The token is minted by auth-service against [pinTransactionId], so the two
  /// must come from the SAME PIN prompt — a token sent with a different
  /// transaction id is refused rather than loosely accepted.
  Future<family_pb.RequestExtraFamilySlotResponse> requestExtraSlot({
    required String idempotencyKey,
    String pinToken = '',
    String pinTransactionId = '',
  }) async {
    try {
      final options = await _callOptionsHelper.withAuth();
      return await _client.requestExtraFamilySlot(
        family_pb.RequestExtraFamilySlotRequest(
          idempotencyKey: idempotencyKey,
          pinToken: pinToken,
          pinTransactionId: pinTransactionId,
        ),
        options: options,
      );
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  /// The user's slots, including cancelled ones — somebody asking what they pay
  /// for is often really asking whether a cancellation went through.
  Future<List<family_pb.FamilyPaidSlot>> listSlots() async {
    try {
      final options = await _callOptionsHelper.withAuth();
      final resp = await _client.listFamilySlots(
        family_pb.ListFamilySlotsRequest(),
        options: options,
      );
      return resp.slots;
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  /// Give up a slot. Takes effect at the end of the period already paid for.
  Future<String> cancelSlot({required String slotId}) async {
    try {
      final options = await _callOptionsHelper.withAuth();
      final resp = await _client.cancelFamilySlot(
        family_pb.CancelFamilySlotRequest(slotId: slotId),
        options: options,
      );
      return resp.message;
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  /// Billing history for one slot — what answers "why was I charged".
  Future<List<family_pb.FamilySlotCharge>> slotCharges({
    required String slotId,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final options = await _callOptionsHelper.withAuth();
      final resp = await _client.getFamilySlotCharges(
        family_pb.GetFamilySlotChargesRequest(
          slotId: slotId,
          limit: limit,
          offset: offset,
        ),
        options: options,
      );
      return resp.charges;
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }
}
