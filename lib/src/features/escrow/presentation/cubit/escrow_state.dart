part of 'escrow_cubit.dart';

sealed class EscrowState {
  const EscrowState();
}

class EscrowInitial extends EscrowState {
  const EscrowInitial();
}

class EscrowLoading extends EscrowState {
  const EscrowLoading();
}

/// The caller's deal list, with the resolved current user id so the UI can
/// tell buyer-side from seller-side rows.
class EscrowDealsLoaded extends EscrowState {
  final List<EscrowDealEntity> deals;
  final String currentUserId;
  const EscrowDealsLoaded(this.deals, this.currentUserId);
}

class EscrowDealLoaded extends EscrowState {
  final EscrowDealEntity deal;
  final String currentUserId;
  const EscrowDealLoaded(this.deal, this.currentUserId);
}

class EscrowFeeQuoted extends EscrowState {
  final EscrowFeeQuote quote;
  const EscrowFeeQuoted(this.quote);
}

/// A mutation (create/deliver/release/cancel/dispute) is in flight.
class EscrowActionInProgress extends EscrowState {
  const EscrowActionInProgress();
}

class EscrowActionSuccess extends EscrowState {
  final String message;
  final EscrowDealEntity deal;
  const EscrowActionSuccess(this.message, this.deal);
}

class EscrowError extends EscrowState {
  final String message;
  const EscrowError(this.message);
}
