library;

import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';

/// THE TWO SIDES OF A PERSON'S CROWDFUNDING MONEY.
///
/// Crowdfund had no statistics page. "My Activity" opened a LIST of campaigns
/// and a LIST of donations, so the questions people actually have — how much
/// have I raised, how much of it can I take out, how much have I given away,
/// how much of that came back — had to be answered by adding rows up by hand.
///
/// Both answers are computed from data the app already fetches
/// (`getMyCrowdfunds`, `getUserDonations`); nothing here needs a new endpoint.
/// It is a plain function over two lists so the arithmetic — the part that
/// would quietly tell someone the wrong figure about their own money — is
/// testable without a widget, a cubit or gRPC.
///
/// ## Withdrawable is NOT "total raised"
///
/// `currentAmount` is the campaign's live, unwithdrawn, unrefunded pot: the
/// contribution saga adds to it, a withdrawal subtracts from it, and a refund
/// subtracts from it. So raised-to-date and available-to-withdraw are
/// different numbers, and a campaign that has already paid out shows the
/// difference. Treating them as one is how a creator gets told they can take
/// out money that has already left.
class CrowdfundMoneySummary {
  const CrowdfundMoneySummary({
    required this.campaignCount,
    required this.activeCampaigns,
    required this.totalRaised,
    required this.availableToWithdraw,
    required this.totalRefundedToDonors,
    required this.donationCount,
    required this.totalDonated,
    required this.donationsRefunded,
    required this.campaignsBacked,
    required this.currency,
  });

  /// Campaigns this person created.
  final int campaignCount;
  final int activeCampaigns;

  /// Money donated to their campaigns, before any withdrawal.
  final double totalRaised;

  /// What they can take out right now, across all their campaigns.
  final double availableToWithdraw;

  /// Money their campaigns have given back to donors (cancellations).
  final double totalRefundedToDonors;

  /// Donations this person made to OTHER people's campaigns.
  final int donationCount;
  final double totalDonated;

  /// Of those, the money that came back after a campaign was cancelled.
  final double donationsRefunded;

  /// How many distinct campaigns they have backed.
  final int campaignsBacked;

  /// The currency every figure above is in. Empty when there is nothing to
  /// show, so the UI can say so rather than printing a naira sign over
  /// zeroes.
  final String currency;

  bool get hasCreated => campaignCount > 0;
  bool get hasBacked => donationCount > 0;
  bool get isEmpty => !hasCreated && !hasBacked;

  /// Net position: given away, minus what came back, minus what they can
  /// still take out of their own campaigns.
  double get netGiven => totalDonated - donationsRefunded;

  static CrowdfundMoneySummary from({
    required List<Crowdfund> created,
    required List<CrowdfundDonation> donations,
    String fallbackCurrency = 'NGN',
  }) {
    var raised = 0.0;
    var available = 0.0;
    var refundedOut = 0.0;
    var active = 0;
    String currency = '';

    for (final c in created) {
      // currentAmount is the live pot; the campaign's own refund counter is
      // what it has already paid back. Raised-to-date is therefore the pot
      // plus everything that has since left it.
      available += c.currentAmount;
      refundedOut += c.totalRefunded;
      raised += c.currentAmount + c.totalRefunded;
      if (c.status == CrowdfundStatus.active) active++;
      if (currency.isEmpty && c.currency.trim().isNotEmpty) {
        currency = c.currency.trim().toUpperCase();
      }
    }

    var donated = 0.0;
    var donationsBack = 0.0;
    final backed = <String>{};
    var counted = 0;

    for (final d in donations) {
      // ONLY SETTLED MONEY COUNTS. A pending or failed donation has not left
      // the donor's wallet, and showing it as given would overstate what
      // they have actually parted with.
      switch (d.status) {
        case DonationStatus.completed:
          donated += d.amount;
          counted++;
          backed.add(d.crowdfundId);
          break;
        case DonationStatus.refunded:
          // It left and came back: both halves are shown so the page can say
          // "you gave X, Y came back" rather than silently netting them.
          donated += d.amount;
          donationsBack += d.amount;
          counted++;
          backed.add(d.crowdfundId);
          break;
        default:
          break;
      }
      if (currency.isEmpty && d.currency.trim().isNotEmpty) {
        currency = d.currency.trim().toUpperCase();
      }
    }

    return CrowdfundMoneySummary(
      campaignCount: created.length,
      activeCampaigns: active,
      totalRaised: raised,
      availableToWithdraw: available,
      totalRefundedToDonors: refundedOut,
      donationCount: counted,
      totalDonated: donated,
      donationsRefunded: donationsBack,
      campaignsBacked: backed.length,
      currency: currency.isNotEmpty
          ? currency
          : (created.isEmpty && donations.isEmpty ? '' : fallbackCurrency),
    );
  }
}
