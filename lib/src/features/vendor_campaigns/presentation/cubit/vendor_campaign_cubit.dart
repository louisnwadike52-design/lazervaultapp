import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/vendor_campaign_repository.dart';
import '../../domain/vendor_entities.dart';
import 'vendor_campaign_state.dart';

/// Drives the Vendor Campaigns screens.
///
/// Deliberately NOT the owner of the scan. A redemption commits platform money
/// and its result has to be shown immediately on the scanner, so
/// [VendorCampaignRepository.redeem] is awaited directly by the scan screen and
/// this cubit is told afterwards. Routing it through a state emission would put
/// a rebuild between the customer and their answer.
class VendorCampaignCubit extends Cubit<VendorCampaignState> {
  VendorCampaignCubit(this._repo) : super(const VendorCampaignInitial());

  final VendorCampaignRepository _repo;

  VendorStatus _status = VendorStatus.unknown;
  List<VendorCampaign> _campaigns = const [];

  VendorStatus get status => _status;

  /// Loads status and campaigns together.
  Future<void> load() async {
    if (isClosed) return;
    emit(const VendorCampaignLoading());
    try {
      // Status first: it also refreshes the cached tile gate.
      _status = await _repo.getStatus();
      if (isClosed) return;

      if (!_status.isVendor) {
        // Not a vendor. Not an error — the screen says so plainly rather than
        // showing a failure for something that is simply not theirs.
        _campaigns = const [];
        emit(VendorCampaignLoaded(status: _status, campaigns: _campaigns));
        return;
      }

      _campaigns = await _repo.listCampaigns();
      if (isClosed) return;
      emit(VendorCampaignLoaded(status: _status, campaigns: _campaigns));
    } catch (e) {
      if (isClosed) return;
      emit(VendorCampaignError(vendorErrorMessage(e)));
    }
  }

  /// Re-reads after a scan, so the served count and accrued total on the list
  /// match what the scanner just showed.
  Future<void> refreshQuietly() async {
    if (isClosed) return;
    try {
      _status = await _repo.getStatus();
      _campaigns = await _repo.listCampaigns();
      if (isClosed) return;
      emit(VendorCampaignLoaded(status: _status, campaigns: _campaigns));
    } catch (_) {
      // A failed background refresh must not replace a good screen with an
      // error: the numbers the vendor is looking at were correct a moment ago.
    }
  }

  /// Withdraws one campaign's earnings.
  Future<void> withdraw(String campaignId) async {
    if (isClosed) return;
    emit(const VendorCampaignLoading());
    try {
      final payout = await _repo.withdraw(campaignId);
      if (isClosed) return;
      emit(VendorPayoutCompleted(payout));
      await refreshQuietly();
    } catch (e) {
      if (isClosed) return;
      emit(VendorCampaignError(vendorErrorMessage(e)));
      // Put the list back so the screen is usable after the message is read.
      await refreshQuietly();
    }
  }

  /// Records one customer served, and returns the answer directly.
  ///
  /// NOT routed through a state emission. The scanner has to put the result in
  /// front of the person at the door immediately, and a rebuild between the
  /// scan and its answer is exactly the pause that makes a queue bunch up.
  /// Errors propagate so the scanner can show the refusal that matches them.
  Future<RedeemOutcome> redeem({
    required String campaignId,
    required String customerUserId,
  }) =>
      _repo.redeem(campaignId: campaignId, customerUserId: customerUserId);

  /// Loads who was served on one campaign.
  Future<List<VendorRedemption>> redemptionsFor(String campaignId) =>
      _repo.listRedemptions(campaignId);
}
