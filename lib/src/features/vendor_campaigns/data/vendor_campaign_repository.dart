import 'package:grpc/grpc.dart';

import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/vendor_access.dart';
import 'package:lazervault/src/generated/vendor_campaigns.pbgrpc.dart' as pb;

import '../domain/vendor_entities.dart';

/// Talks to products-gateway's VendorCampaignService.
///
/// Money crosses the wire as int64 KOBO in both directions and is NOT
/// converted here — unlike the crowdfund data source, which multiplies and
/// divides by 100 because crowdfund stores naira. The vendor path is kobo end
/// to end, so there is no conversion to get wrong.
class VendorCampaignRepository {
  VendorCampaignRepository({
    required pb.VendorCampaignServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  final pb.VendorCampaignServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  /// Am I a vendor?
  ///
  /// NEVER THROWS. The caller is the tile gate, and a thrown error there would
  /// have to be caught into the same "not a vendor" answer anyway — returning
  /// it directly makes the safe default impossible to forget.
  Future<VendorStatus> getStatus() async {
    try {
      final options = await _callOptionsHelper.withAuth();
      final resp = await _client.getVendorStatus(
        pb.GetVendorStatusRequest(),
        options: options,
      );
      final status = VendorStatus(
        isVendor: resp.isVendor,
        isActive: resp.isActive,
        vendorId: resp.vendorId,
        displayName: resp.displayName,
        businessName: resp.businessName,
        status: resp.status,
        activeCampaigns: resp.activeCampaigns,
        outstandingKobo: resp.outstandingKobo.toInt(),
        // The server replied. Everything below this line is a decision; a
        // throw caught at the bottom is not, and must not be remembered as
        // one — see VendorStatus.answered.
        answered: true,
      );

      // Only a REAL answer updates the cache. A failed call below leaves the
      // previous value alone rather than writing false, so one timeout cannot
      // hide the tile from a vendor in the middle of service.
      await VendorAccess.remember(
        isActive: status.isVendor && status.isActive,
        businessName: status.businessName,
      );
      return status;
    } catch (_) {
      return VendorStatus.unknown;
    }
  }

  /// This vendor's campaigns.
  Future<List<VendorCampaign>> listCampaigns(
      {int limit = 20, int offset = 0}) async {
    final options = await _callOptionsHelper.withAuth();
    final resp = await _client.listVendorCampaigns(
      pb.ListVendorCampaignsRequest(limit: limit, offset: offset),
      options: options,
    );
    return resp.campaigns.map(_campaign).toList();
  }

  /// Record a customer served.
  ///
  /// An ALREADY-SERVED customer comes back as a normal result with
  /// [RedeemOutcome.alreadyServed] set, not as a thrown error.
  Future<RedeemOutcome> redeem({
    required String campaignId,
    required String customerUserId,
  }) async {
    final options = await _callOptionsHelper.withAuth();
    final resp = await _client.redeemByQR(
      pb.RedeemByQRRequest(
        campaignId: campaignId,
        customerUserId: customerUserId,
      ),
      options: options,
    );
    return RedeemOutcome(
      redemptionId: resp.redemptionId,
      alreadyServed: resp.alreadyServed,
      servedAt:
          resp.hasServedAt() ? resp.servedAt.toDateTime().toLocal() : null,
      customerName: resp.customerName,
      customerUsername: resp.customerUsername,
      amountKobo: resp.amountKobo.toInt(),
      currency: resp.currency,
      redeemedCount: resp.redeemedCount,
      maxRedemptions: resp.maxRedemptions,
      remainingRedemptions: resp.remainingRedemptions,
      campaignStatus: resp.campaignStatus,
    );
  }

  /// Who was served on one campaign.
  Future<List<VendorRedemption>> listRedemptions(
    String campaignId, {
    int limit = 50,
    int offset = 0,
  }) async {
    final options = await _callOptionsHelper.withAuth();
    final resp = await _client.listCampaignRedemptions(
      pb.ListCampaignRedemptionsRequest(
        campaignId: campaignId,
        limit: limit,
        offset: offset,
      ),
      options: options,
    );
    return resp.redemptions
        .map(
          (r) => VendorRedemption(
            id: r.id,
            customerUserId: r.customerUserId,
            customerName: r.customerName,
            customerUsername: r.customerUsername,
            amountKobo: r.amountKobo.toInt(),
            currency: r.currency,
            scannedAt: r.scannedAt.toDateTime().toLocal(),
          ),
        )
        .toList();
  }

  /// Withdraw a finished campaign's earnings.
  Future<VendorPayout> withdraw(String campaignId) async {
    final options = await _callOptionsHelper.withAuth();
    final resp = await _client.withdrawCampaignEarnings(
      pb.WithdrawCampaignEarningsRequest(campaignId: campaignId),
      options: options,
    );
    return VendorPayout(
      payoutId: resp.payoutId,
      amountKobo: resp.amountKobo.toInt(),
      currency: resp.currency,
      reference: resp.reference,
      status: resp.status,
      alreadyPaid: resp.alreadyPaid,
      paidAt: resp.hasPaidAt() ? resp.paidAt.toDateTime().toLocal() : null,
    );
  }

  VendorCampaign _campaign(pb.VendorCampaignMessage c) => VendorCampaign(
        id: c.id,
        name: c.name,
        currency: c.currency.isEmpty ? 'NGN' : c.currency,
        unitAmountKobo: c.unitAmountKobo.toInt(),
        maxRedemptions: c.maxRedemptions,
        redeemedCount: c.redeemedCount,
        remainingRedemptions: c.remainingRedemptions,
        accruedAmountKobo: c.accruedAmountKobo.toInt(),
        paidOutKobo: c.paidOutKobo.toInt(),
        outstandingKobo: c.outstandingKobo.toInt(),
        status: c.status,
        startsAt: c.startsAt.toDateTime().toLocal(),
        endsAt: c.endsAt.toDateTime().toLocal(),
        closeReason: c.closeReason,
        // Empty from an older server means the narrow rule, which is what
        // every campaign created before the scope existed actually runs.
        uniquenessScope:
            c.uniquenessScope.isEmpty ? 'campaign' : c.uniquenessScope,
      );
}

/// Turns a gRPC refusal into a sentence a person at a door can act on.
///
/// The server answers with stable CODES rather than prose precisely so this
/// mapping can live here, in the user's language, instead of a backend
/// sentence being shown verbatim on a phone held over a queue.
String vendorErrorMessage(Object error) {
  final code = error is GrpcError ? (error.message ?? '') : error.toString();

  switch (code) {
    case 'CAMPAIGN_EXHAUSTED':
      return 'This campaign has reached its limit. No more customers can be served on it.';
    case 'CAMPAIGN_ENDED':
      return 'This campaign has ended.';
    case 'CAMPAIGN_NOT_STARTED':
      return 'This campaign has not started yet.';
    case 'CAMPAIGN_NOT_ACTIVE':
      return 'This campaign is not accepting scans.';
    case 'CAMPAIGN_STILL_OPEN':
      return 'You can withdraw once the campaign has closed.';
    case 'CAMPAIGN_NOT_FOUND':
      return 'That campaign could not be found.';
    case 'CUSTOMER_UNKNOWN':
      return 'That code does not belong to a Lazervault customer.';
    case 'QR_NOT_A_PROFILE_CODE':
      return 'That is not a Lazervault profile code.';
    case 'SELF_REDEMPTION':
      return 'You cannot scan your own profile code.';
    case 'NOT_A_VENDOR':
      return 'This account is not set up to scan customers.';
    case 'VENDOR_SUSPENDED':
      return 'Scanning is paused for this account. Your earnings so far are safe and still payable.';
    case 'PAYOUTS_DISABLED':
      return 'Withdrawals are paused right now. Your earnings are safe and still owed to you.';
    case 'NOTHING_TO_WITHDRAW':
      return 'There is nothing to withdraw on this campaign.';
  }

  if (error is GrpcError && error.code == StatusCode.unavailable) {
    return 'Could not reach Lazervault. The scan was not recorded.';
  }
  return 'The scan could not be recorded. Please try again.';
}
