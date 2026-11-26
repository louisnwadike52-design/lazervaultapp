import 'package:equatable/equatable.dart';

import '../../domain/vendor_entities.dart';

abstract class VendorCampaignState extends Equatable {
  const VendorCampaignState();
  @override
  List<Object?> get props => [];
}

class VendorCampaignInitial extends VendorCampaignState {
  const VendorCampaignInitial();
}

class VendorCampaignLoading extends VendorCampaignState {
  const VendorCampaignLoading();
}

class VendorCampaignLoaded extends VendorCampaignState {
  const VendorCampaignLoaded({
    required this.status,
    required this.campaigns,
  });

  final VendorStatus status;
  final List<VendorCampaign> campaigns;

  VendorCampaignLoaded copyWith({
    VendorStatus? status,
    List<VendorCampaign>? campaigns,
  }) =>
      VendorCampaignLoaded(
        status: status ?? this.status,
        campaigns: campaigns ?? this.campaigns,
      );

  @override
  List<Object?> get props => [status, campaigns];
}

class VendorCampaignError extends VendorCampaignState {
  const VendorCampaignError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

/// Emitted after a successful withdrawal so the screen can show a receipt.
class VendorPayoutCompleted extends VendorCampaignState {
  const VendorPayoutCompleted(this.payout);
  final VendorPayout payout;
  @override
  List<Object?> get props => [payout];
}
